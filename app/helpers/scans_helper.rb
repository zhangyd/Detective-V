module ScansHelper

	def self.scan repo, user

	  tasks = []
	  lang = repo.language
	  status = "No known vulnerabilities"

    @scan = Scan.create(
      repo_id: repo.id,
      status: status,
      user_id: user.id
    )

    if lang != nil
      tasks = Settings.pipeline.tasks_for[lang].split(",")
    end

    logfile = File.open(Rails.root.join("log/scans"), 'a')
    logfile.sync = true

    ApplicationHelper.inside_github_archive(repo, user) do |dir|
      pipeline_options = {
        :appname => repo.name,
        :target => "#{dir}",
        :quiet => false,
        :npm_registry => Settings.pipeline['npm_registry'],
        :run_tasks => tasks,
        :pmd_path => Settings.pipeline['pmd_path'],
        :findsecbugs_path => Settings.pipeline['findsecbugs_path'],
        :logfile => logfile,
        :debug => true
      }

      tracker = Pipeline.run(pipeline_options)
      findings = tracker.findings

      findings.each do |finding|
        @scan.update_attribute(:status, "Vulnerabilities found")
        Issue.create(
          severity: finding.severity,
          source: finding.source,
          description: finding.description,
          detail: finding.detail,
          fingerprint: finding.fingerprint,
          scan_id: @scan.id,
          repo_id: repo.id,
          scanner: finding.source[:scanner],
          file: finding.source[:file], 
          line: finding.source[:line],
          code: finding.source[:code],
          user_id: user.id
        )
      end
	  end

    return @scan
  end
end

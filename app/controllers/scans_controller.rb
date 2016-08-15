class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]

  # GET /scans
  # GET /scans.json
  def index
    @scans = Scan.all
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans
  # POST /scans.json
  def create
    repo = Repo.find(scan_params[:repo_id])
    tasks = []
    lang = repo.language
    status = "No known vulnerabilities"

    @scan = Scan.new(
      repo_id: repo.id,
      status: status
    )

    if lang == nil
    else
      tasks = Settings.pipeline.tasks_for[lang].split(",")
    end

    logfile = File.open(Rails.root.join("log/scans"), 'a')
    logfile.sync = true

    ApplicationHelper.inside_github_archive(repo) do |dir|
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
        @scan.status = "Vulnerabilities found"
        Issue.create(
          severity: finding.severity,
          source: finding.source,
          description: finding.description,
          detail: finding.detail,
          fingerprint: finding.fingerprint,
          scan_id: @scan.id,
          repo_id: repo.id,
          scanner: finding.source[:scanner],
          line: finding.source[:line],
          code: finding.source[:code]
        )
      end
    end

    respond_to do |format|
      if @scan.save
        format.html { redirect_to @scan, notice: 'Scan was successfully created.' }
        format.json { render :show, status: :created, location: @scan }
      else
        format.html { render :new }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to @scan, notice: 'Scan was successfully updated.' }
        format.json { render :show, status: :ok, location: @scan }
      else
        format.html { render :edit }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    @scan.destroy
    respond_to do |format|
      format.html { redirect_to scans_url, notice: 'Scan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:status, :repo_id)
    end
end

require 'pipeline'
require 'tempfile'

module ApplicationHelper

	def self.github
		return Octokit::Client.new(:access_token => Settings.github.api_access_token)
	end

  def self.inside_github_archive repo
    dir = Dir.mktmpdir
    filename = Dir::Tmpname.make_tmpname(['detective_v', '.tar.gz'], nil)
    archive_link = self.github.archive_link(repo.owner + "/" + repo.name)

    IO.copy_stream(open(archive_link), "#{dir}/#{filename}")

    raise(IOError, "#{dir}/#{filename} does not exist") unless FileTest.exists?("#{dir}/#{filename}")

    exit_msg = `tar xzf #{dir}/#{filename} -C #{dir} 2>&1`
    raise(IOError, exit_msg) if $?.to_i != 0

    yield Dir.glob("#{dir}/*/").max_by {|f| File.mtime(f)}
  rescue StandardError => e
    Rails.logger.error "Error inside_github_archive #{e.message}" unless Rails.env == 'test'
    raise e
  ensure
    FileUtils.remove_entry_secure(dir)
  end

end
require 'pipeline'
require 'tempfile'

module ApplicationHelper

	def self.github curr
    if (curr != nil) && curr.access_token?
		  return Octokit::Client.new(:access_token => curr.access_token)
    else
      return nil
    end
	end

  def self.inside_github_archive repo, current_user
    dir = Dir.mktmpdir
    filename = Dir::Tmpname.make_tmpname(['detective_v', '.tar.gz'], nil)
    begin
      archive_link = self.github(current_user).archive_link(repo.owner + "/" + repo.name)
    rescue Exception => e
      Rails.logger.error "Error with Octokit api access_token"
      raise e
    end

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
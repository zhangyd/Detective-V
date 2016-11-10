class UserNotifier < ApplicationMailer

	def scan_done_email(user, repos)
    @user = user
    @num_repos = repos.count
    @num_issues = 0
    for repo in repos
    	@num_issues = @num_issues + repo.scans.last.issues.count
    end
    mail(to: @user.email, subject: 'Your Most Recent Scan Has Completed')
  end
end

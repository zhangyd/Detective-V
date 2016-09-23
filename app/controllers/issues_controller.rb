require 'octokit'

class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.all
    # remove these?
    @repos = Repo.all
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @repos = Repo.all
  end

  # GET /issues/new
  def new
    @issue = Issue.new
    @repos = Repo.all
  end

  # GET /issues/1/edit
  def edit
    @repos = Repo.all
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    @repos = Repo.all
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish
    # @user = ApplicationController.current_user
    @issue = Issue.find(params[:id])
    @repos = Repo.all
    @publish_repo  = Repo.find(@issue.repo_id)
    # ApplicationHelper.github.create_issue()
    token = "2626e7c10238415ea0c5a372c343f5f015d61e9d"
    user_github = Octokit::Client.new(:access_token => token)
    # user_github = ApplicationHelper.github
    @result = user_github.create_issue("#{@publish_repo.owner}/#{@publish_repo.name}", @issue.description, render_to_string("github_issue"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_params
      params.require(:issue).permit(:severity, :source, :description, :detail, :fingerprint, :scan_id)
    end
end

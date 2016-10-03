class ReposController < ApplicationController
  before_action :set_repo, only: [:show, :edit, :update, :destroy]
  include ScansHelper

  # GET /repos
  # GET /repos.json
  def index
  end

  # GET /repos/1
  # GET /repos/1.json
  def show
    final_params = []
    unless @repo.scans.last == nil
      last_scan_id = @repo.scans.last.id
      final_query_array = ["SELECT * FROM issues WHERE scan_id = ?", "ORDER BY issues.severity DESC"]
      final_params.push(last_scan_id)
      final_query = final_query_array.join(" ")
      @issues = Issue.find_by_sql [final_query, *final_params]
    end
  end

  # GET /repos/new
  def new
    @repo = Repo.new
  end

  # GET /repos/1/edit
  def edit
  end

  # POST /repos
  # POST /repos.json
  def create
    params = Repo.get_repo(repo_params[:name], repo_params[:owner])
    if params == nil
      puts "@@@ Found bad url"
      @user.errors[:base] << "fail"
      redirect_to root_path and return
    end
    
    params[:user_id] = current_user.id
    @repo = Repo.new(params)

    respond_to do |format|
      if @repo.save
        format.html { redirect_to @repo, notice: 'Repo was successfully created.' }
        format.json { render :show, status: :created, location: @repo }
      else
        format.html { render :new }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repos/1
  # PATCH/PUT /repos/1.json
  def update
    respond_to do |format|
      if @repo.update(repo_params)
        format.html { redirect_to @repo, notice: 'Repo was successfully updated.' }
        format.json { render :show, status: :ok, location: @repo }
      else
        format.html { render :edit }
        format.json { render json: @repo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repos/1
  # DELETE /repos/1.json
  def destroy
    @repo.destroy
    respond_to do |format|
      format.html { redirect_to repos_url, notice: 'Repo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def actions
    repos = Repo.find(params[:repo_ids])

    if params[:delete]
      repos.each do |repo|
        repo.destroy
      end
      redirect_to :back, notice: 'Repos were successfully deleted.' 
    end

    if params[:scan]
      @scans = []
      repos.each do |repo|
        @scan = ScansHelper.scan(repo, current_user)
        @scans.push(@scan)
      end

      #check to see if any errors while scanning
      redirect_to :back, notice: 'Scans created.'
      # respond_to do |format|
      #   if @scan.save
      #     format.html { redirect_to @scan, notice: 'Scans were successfully created.' }
      #     format.json { render :show, status: :created, location: @scan }
      #   else
      #     format.html { render :new }
      #     format.json { render json: @scan.errors, status: :unprocessable_entity }
      #   end
      # end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repo
      @repo = Repo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repo_params
      params.require(:repo).permit(:name, :owner, :html_url, :description, :language, :size, :user_id, :repo_ids => [])
    end
end

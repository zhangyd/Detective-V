require "rails_helper"

describe "Public access to repos", type: :request do
  it "denies access to repos#new" do
    get new_repo_path
    expect(response).to redirect_to login_url
  end
end
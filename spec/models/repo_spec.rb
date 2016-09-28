# spec/models/repo_spec.rb
require 'rails_helper'

describe Repo do
  it "has a valid factory" do
  	FactoryGirl.create(:repo).should be_valid
  end
  it "is invalid without a name" do
  	FactoryGirl.build(:repo, name: nil).should_not be_valid
  end
  it "is invalid without an owner" do
  	FactoryGirl.build(:repo, owner: nil).should_not be_valid
  end
  it "populates all values for github repo" do
  	repo = FactoryGirl.create(:repo, owner: "aegrobbel", name: "detective-v")
  	params = Repo.get_repo(repo.name, repo.owner)
  	expect(params[:name]).to eq("detective-v")
  	expect(params[:owner]).to eq("aegrobbel")
  	expect(params[:html_url]).to eq("https://github.com/aegrobbel/detective-v")
  	expect(params[:description]).to eq(nil)
  	expect(params[:language]).to eq("Ruby")
  	expect(params[:size]).to be > 0
  end
  it "fail to find github repo" do
  	repo = FactoryGirl.create(:repo, owner: "aegrobbel", name: "IDoNotExist")
  	params = Repo.get_repo(repo.name, repo.owner)
  	expect(params).to eq(nil)
  end
end
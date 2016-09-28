# spec/models/issue_spec.rb
require 'spec_helper'

describe Issue, type: :model do
  it "has a valid factory" do
  	FactoryGirl.create(:issue).should be_valid
  end
  it "is invalid without a repo_id" do
  	FactoryGirl.build(:issue, repo_id: nil).should_not be_valid
  end
  it "is invalid without a scan_id" do
  	FactoryGirl.build(:issue, scan_id: nil).should_not be_valid
  end
end
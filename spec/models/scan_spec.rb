# spec/models/scan_spec.rb
require 'rails_helper'

describe Scan, type: :model do
  it "has a valid factory" do
  	FactoryGirl.create(:scan).should be_valid
  end
  it "is invalid without a repo_id" do
  	FactoryGirl.build(:scan, repo_id: nil).should_not be_valid
  end
end
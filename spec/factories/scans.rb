# spec/factories/issues.rb
require 'faker'

FactoryGirl.define do
  factory :scan do |f|
    f.status { Faker::Name.first_name }
    f.repo_id 1
  end
end
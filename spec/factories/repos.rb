# spec/factories/issues.rb
require 'faker'

FactoryGirl.define do
  factory :repo do |f|
    f.name "myRepo"
    f.owner "Abby"
    f.html_url "url"
    f.description "description of repo"
    f.language "ruby"
    f.size 100
  end
end
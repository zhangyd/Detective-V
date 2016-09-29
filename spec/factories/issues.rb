# spec/factories/issues.rb
require 'faker'

FactoryGirl.define do
  factory :issue do |f|
  	f.severity 1
  	f.source "source1"
  	f.description "vulnerable app"
  	f.detail "found on line 1"
  	f.fingerprint "unique hash"
  	f.scan_id 1
  	f.repo_id 0
  	f.scanner "scanner1"
  	f.file "file1"
  	f.line "line1"
  	f.code "code1"
  end
end
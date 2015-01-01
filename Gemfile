source "https://rubygems.org"

gemspec

gem "rake"

gem "straightedge", path: "../straightedge"
gem "activesupport"    

group :development do
  gem "pry"
  gem "gosu"
  gem "straightedge-gosu", path: "../straightedge-gosu"
end

group :test do
  gem "rspec-core"
  gem "rspec-expectations"
  gem "rspec-mocks"
  gem "rake"
  gem "yard"
end


gem "codeclimate-test-reporter", group: :test, require: nil

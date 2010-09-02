require "rubygems"
require "parka/specification"

Parka::Specification.new do |gem|
  gem.name     = "github-backup"
  gem.version  = Github::Backup::VERSION
  gem.summary  = "Backup your Github repositories"
  gem.homepage = "http://github.com/ddollar/github-backup"

  gem.executables = "github-backup"
end

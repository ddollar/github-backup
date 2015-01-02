$:.unshift File.expand_path("../lib", __FILE__)

require "github-backup"

Gem::Specification.new do |s|
  s.name        = "github-backup"
  s.version     = Github::Backup::VERSION

  s.author   = "David Dollar"
  s.email    = "david@dollar.io"
  s.summary  = "Backup your Github repositories"
  s.homepage = "http://github.com/ddollar/github-backup"
  s.license  = "MIT"

  s.executables = "github-backup"

  s.add_dependency "octokit", "~> 3.7"
end

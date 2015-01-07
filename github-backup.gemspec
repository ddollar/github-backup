$:.unshift File.expand_path("../lib", __FILE__)

require "github-backup/version"

Gem::Specification.new do |s|
  s.name        = "github-backup"
  s.version     = GithubBackup::VERSION

  s.author      = "David Dollar"
  s.email       = "david@dollar.io"
  s.summary     = "Backup your Github repositories"
  s.description = "Library and command line tool for backing up GitHub repositories"
  s.homepage    = "http://github.com/ddollar/github-backup"
  s.license     = "MIT"

  s.files         = `git ls-files`.split($/)
  s.require_paths = ['lib']
  s.executables   = "github-backup"

  s.add_dependency "octokit", "~> 3.7"

  s.add_development_dependency "rake"
  s.add_development_dependency "minitest", "~> 5.5.0"
  s.add_development_dependency "minitest-stub-const", "~> 0.2"
end

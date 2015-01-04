# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'github-backup/version'

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
  s.executables = "github-backup"

  s.add_dependency "octokit", "~> 3.7"
end

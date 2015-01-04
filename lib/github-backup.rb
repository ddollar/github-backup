require 'fileutils'
require 'octokit'
require 'pp'
require 'yaml'

Dir[File.dirname(__FILE__) + '/github-backup/*.rb'].each do |file|
  require file
end

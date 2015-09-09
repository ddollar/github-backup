$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'github-backup'
require 'minitest/autorun'
require 'fakefs/safe'
require File.join(File.dirname(__FILE__), 'support', 'deep_struct')

def sawyer_repo
  DeepStruct.new(
    {:id=>251112,
     :name=>"github-backup",
     :full_name=>"ddollar/github-backup",
     :owner=>
      {:login=>"ddollar",
       :id=>3308,
       :avatar_url=>"https://avatars.githubusercontent.com/u/3308?v=3",
       :gravatar_id=>"",
       :url=>"https://api.github.com/users/ddollar",
       :html_url=>"https://github.com/ddollar",
       :followers_url=>"https://api.github.com/users/ddollar/followers",
       :following_url=>
        "https://api.github.com/users/ddollar/following{/other_user}",
       :gists_url=>"https://api.github.com/users/ddollar/gists{/gist_id}",
       :starred_url=>"https://api.github.com/users/ddollar/starred{/owner}{/repo}",
       :subscriptions_url=>"https://api.github.com/users/ddollar/subscriptions",
       :organizations_url=>"https://api.github.com/users/ddollar/orgs",
       :repos_url=>"https://api.github.com/users/ddollar/repos",
       :events_url=>"https://api.github.com/users/ddollar/events{/privacy}",
       :received_events_url=>
        "https://api.github.com/users/ddollar/received_events",
       :type=>"User",
       :site_admin=>false},
     :private=>false,
     :html_url=>"https://github.com/ddollar/github-backup",
     :description=>"Back up your Github repositories",
     :fork=>false,
     :url=>"https://api.github.com/repos/ddollar/github-backup",
     :forks_url=>"https://api.github.com/repos/ddollar/github-backup/forks",
     :keys_url=>"https://api.github.com/repos/ddollar/github-backup/keys{/key_id}",
     :collaborators_url=>
      "https://api.github.com/repos/ddollar/github-backup/collaborators{/collaborator}",
     :teams_url=>"https://api.github.com/repos/ddollar/github-backup/teams",
     :hooks_url=>"https://api.github.com/repos/ddollar/github-backup/hooks",
     :issue_events_url=>
      "https://api.github.com/repos/ddollar/github-backup/issues/events{/number}",
     :events_url=>"https://api.github.com/repos/ddollar/github-backup/events",
     :assignees_url=>
      "https://api.github.com/repos/ddollar/github-backup/assignees{/user}",
     :branches_url=>
      "https://api.github.com/repos/ddollar/github-backup/branches{/branch}",
     :tags_url=>"https://api.github.com/repos/ddollar/github-backup/tags",
     :blobs_url=>
      "https://api.github.com/repos/ddollar/github-backup/git/blobs{/sha}",
     :git_tags_url=>
      "https://api.github.com/repos/ddollar/github-backup/git/tags{/sha}",
     :git_refs_url=>
      "https://api.github.com/repos/ddollar/github-backup/git/refs{/sha}",
     :trees_url=>
      "https://api.github.com/repos/ddollar/github-backup/git/trees{/sha}",
     :statuses_url=>
      "https://api.github.com/repos/ddollar/github-backup/statuses/{sha}",
     :languages_url=>
      "https://api.github.com/repos/ddollar/github-backup/languages",
     :stargazers_url=>
      "https://api.github.com/repos/ddollar/github-backup/stargazers",
     :contributors_url=>
      "https://api.github.com/repos/ddollar/github-backup/contributors",
     :subscribers_url=>
      "https://api.github.com/repos/ddollar/github-backup/subscribers",
     :subscription_url=>
      "https://api.github.com/repos/ddollar/github-backup/subscription",
     :commits_url=>
      "https://api.github.com/repos/ddollar/github-backup/commits{/sha}",
     :git_commits_url=>
      "https://api.github.com/repos/ddollar/github-backup/git/commits{/sha}",
     :comments_url=>
      "https://api.github.com/repos/ddollar/github-backup/comments{/number}",
     :issue_comment_url=>
      "https://api.github.com/repos/ddollar/github-backup/issues/comments{/number}",
     :contents_url=>
      "https://api.github.com/repos/ddollar/github-backup/contents/{+path}",
     :compare_url=>
      "https://api.github.com/repos/ddollar/github-backup/compare/{base}...{head}",
     :merges_url=>"https://api.github.com/repos/ddollar/github-backup/merges",
     :archive_url=>
      "https://api.github.com/repos/ddollar/github-backup/{archive_format}{/ref}",
     :downloads_url=>
      "https://api.github.com/repos/ddollar/github-backup/downloads",
     :issues_url=>
      "https://api.github.com/repos/ddollar/github-backup/issues{/number}",
     :pulls_url=>
      "https://api.github.com/repos/ddollar/github-backup/pulls{/number}",
     :milestones_url=>
      "https://api.github.com/repos/ddollar/github-backup/milestones{/number}",
     :notifications_url=>
      "https://api.github.com/repos/ddollar/github-backup/notifications{?since,all,participating}",
     :labels_url=>
      "https://api.github.com/repos/ddollar/github-backup/labels{/name}",
     :releases_url=>
      "https://api.github.com/repos/ddollar/github-backup/releases{/id}",
     :created_at=>"2009-07-14 17:52:13 UTC",
     :updated_at=>"2015-08-27 14:54:56 UTC",
     :pushed_at=>"2015-06-13 15:58:00 UTC",
     :git_url=>"git://github.com/ddollar/github-backup.git",
     :ssh_url=>"git@github.com:ddollar/github-backup.git",
     :clone_url=>"https://github.com/ddollar/github-backup.git",
     :svn_url=>"https://github.com/ddollar/github-backup",
     :homepage=>"",
     :size=>306,
     :stargazers_count=>66,
     :watchers_count=>66,
     :language=>"Ruby",
     :has_issues=>true,
     :has_downloads=>true,
     :has_wiki=>true,
     :has_pages=>false,
     :forks_count=>18,
     :mirror_url=>nil,
     :open_issues_count=>0,
     :forks=>18,
     :open_issues=>0,
     :watchers=>66,
     :default_branch=>"master",
     :permissions=>{:admin=>false, :push=>true, :pull=>true},
     :network_count=>18,
     :subscribers_count=>9})
end

def sawyer_anonymous_gist
  DeepStruct.new(
  {:url=>"https://api.github.com/gists/380919418d982afbc4fc",
   :forks_url=>"https://api.github.com/gists/380919418d982afbc4fc/forks",
   :commits_url=>"https://api.github.com/gists/380919418d982afbc4fc/commits",
   :id=>"380919418d982afbc4fc",
   :git_pull_url=>"https://gist.github.com/380919418d982afbc4fc.git",
   :git_push_url=>"https://gist.github.com/380919418d982afbc4fc.git",
   :html_url=>"https://gist.github.com/380919418d982afbc4fc",
   :files=>
    {:"anon.txt"=>
      {:filename=>"anon.txt",
       :type=>"text/plain",
       :language=>"Text",
       :raw_url=>
        "https://gist.githubusercontent.com/anonymous/380919418d982afbc4fc/raw/6991197cadbb876aabebdaa9ead52962857f0443/anon.txt",
       :size=>19,
       :truncated=>false,
       :content=>"Nothing to see here"}},
   :public=>true,
   :created_at=>'2015-09-07 22:23:58 UTC',
   :updated_at=>'2015-09-07 22:23:58 UTC',
   :description=>"Anonymous Gist",
   :comments=>0,
   :user=>nil,
   :comments_url=>"https://api.github.com/gists/380919418d982afbc4fc/comments",
   :forks=>[],
   :history=>
    [{:user=>
       {:login=>"invalid-email-address",
        :id=>148100,
        :avatar_url=>"https://avatars.githubusercontent.com/u/148100?v=3",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/invalid-email-address",
        :html_url=>"https://github.com/invalid-email-address",
        :followers_url=>
         "https://api.github.com/users/invalid-email-address/followers",
        :following_url=>
         "https://api.github.com/users/invalid-email-address/following{/other_user}",
        :gists_url=>
         "https://api.github.com/users/invalid-email-address/gists{/gist_id}",
        :starred_url=>
         "https://api.github.com/users/invalid-email-address/starred{/owner}{/repo}",
        :subscriptions_url=>
         "https://api.github.com/users/invalid-email-address/subscriptions",
        :organizations_url=>
         "https://api.github.com/users/invalid-email-address/orgs",
        :repos_url=>"https://api.github.com/users/invalid-email-address/repos",
        :events_url=>
         "https://api.github.com/users/invalid-email-address/events{/privacy}",
        :received_events_url=>
         "https://api.github.com/users/invalid-email-address/received_events",
        :type=>"User",
        :site_admin=>false},
      :version=>"496b2ba699998442fbf864e9e7dcf47165b2f478",
      :committed_at=>'2015-09-07 22:23:58 UTC',
      :change_status=>{:total=>1, :additions=>1, :deletions=>0},
      :url=>
       "https://api.github.com/gists/380919418d982afbc4fc/496b2ba699998442fbf864e9e7dcf47165b2f478"}]}
       )
end

def sawyer_public_gist
  DeepStruct.new(
  {:url=>"https://api.github.com/gists/dae4757f11749b6edaf2",
   :forks_url=>"https://api.github.com/gists/dae4757f11749b6edaf2/forks",
   :commits_url=>"https://api.github.com/gists/dae4757f11749b6edaf2/commits",
   :id=>"dae4757f11749b6edaf2",
   :git_pull_url=>"https://gist.github.com/dae4757f11749b6edaf2.git",
   :git_push_url=>"https://gist.github.com/dae4757f11749b6edaf2.git",
   :html_url=>"https://gist.github.com/dae4757f11749b6edaf2",
   :files=>
    {:"test.txt"=>
      {:filename=>"test.txt",
       :type=>"text/plain",
       :language=>"Text",
       :raw_url=>
        "https://gist.githubusercontent.com/garethrees/dae4757f11749b6edaf2/raw/3fde4e20239e009fb18787483735352a778229da/test.txt",
       :size=>5,
       :truncated=>false,
       :content=>"1,2,3"}},
   :public=>true,
   :created_at=>'2015-09-07 22:34:59 UTC',
   :updated_at=>'2015-09-07 22:34:59 UTC',
   :description=>"Test Gist",
   :comments=>0,
   :user=>nil,
   :comments_url=>"https://api.github.com/gists/dae4757f11749b6edaf2/comments",
   :owner=>
    {:login=>"garethrees",
     :id=>282788,
     :avatar_url=>"https://avatars.githubusercontent.com/u/282788?v=3",
     :gravatar_id=>"",
     :url=>"https://api.github.com/users/garethrees",
     :html_url=>"https://github.com/garethrees",
     :followers_url=>"https://api.github.com/users/garethrees/followers",
     :following_url=>
      "https://api.github.com/users/garethrees/following{/other_user}",
     :gists_url=>"https://api.github.com/users/garethrees/gists{/gist_id}",
     :starred_url=>
      "https://api.github.com/users/garethrees/starred{/owner}{/repo}",
     :subscriptions_url=>"https://api.github.com/users/garethrees/subscriptions",
     :organizations_url=>"https://api.github.com/users/garethrees/orgs",
     :repos_url=>"https://api.github.com/users/garethrees/repos",
     :events_url=>"https://api.github.com/users/garethrees/events{/privacy}",
     :received_events_url=>
      "https://api.github.com/users/garethrees/received_events",
     :type=>"User",
     :site_admin=>false},
   :forks=>[],
   :history=>
    [{:user=>
       {:login=>"garethrees",
        :id=>282788,
        :avatar_url=>"https://avatars.githubusercontent.com/u/282788?v=3",
        :gravatar_id=>"",
        :url=>"https://api.github.com/users/garethrees",
        :html_url=>"https://github.com/garethrees",
        :followers_url=>"https://api.github.com/users/garethrees/followers",
        :following_url=>
         "https://api.github.com/users/garethrees/following{/other_user}",
        :gists_url=>"https://api.github.com/users/garethrees/gists{/gist_id}",
        :starred_url=>
         "https://api.github.com/users/garethrees/starred{/owner}{/repo}",
        :subscriptions_url=>
         "https://api.github.com/users/garethrees/subscriptions",
        :organizations_url=>"https://api.github.com/users/garethrees/orgs",
        :repos_url=>"https://api.github.com/users/garethrees/repos",
        :events_url=>"https://api.github.com/users/garethrees/events{/privacy}",
        :received_events_url=>
         "https://api.github.com/users/garethrees/received_events",
        :type=>"User",
        :site_admin=>false},
      :version=>"99e263bff14f9565b844f7913b6b505513308a5f",
      :committed_at=>'2015-09-07 22:34:59 UTC',
      :change_status=>{:total=>1, :additions=>1, :deletions=>0},
      :url=>
       "https://api.github.com/gists/dae4757f11749b6edaf2/99e263bff14f9565b844f7913b6b505513308a5f"}]})
end

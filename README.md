## github-backup

[![Build Status](https://travis-ci.org/ddollar/github-backup.svg?branch=master)](https://travis-ci.org/ddollar/github-backup)
[![Code Climate](https://codeclimate.com/github/ddollar/github-backup/badges/gpa.svg)](https://codeclimate.com/github/ddollar/github-backup)

Back up your Github repositories locally.

To install it as a Gem, just run:

    $ gem install github-backup

To use it:

    $ github-backup ddollar /path/to/my/backup/root

## Authenticated Usage

### Seamless authentication using .gitconfig defaults

You will need a `~/.gitconfig` file in place with a `[github]` section

See: http://github.com/guides/tell-git-your-user-name-and-email-address

### Specify authentication at the command line

If you don't have a `[github]` section set up in your `~/.gitconfig` file, you
can provide your Github OAuth access token at the command line.

## License

MIT License

## Authorship

Created by David Dollar

Fixed for Github v3 by [Gareth Rees](https://github.com/garethrees)

[Other Contributors](https://github.com/ddollar/github-backup/graphs/contributors)

## Copyright

Copyright (c) 2010 David Dollar.

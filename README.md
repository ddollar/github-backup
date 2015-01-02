## github-backup

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

## Author

Created by David Dollar

Patches contributed by:
  Gabriel Gilder

## Copyright

Copyright (c) 2010 David Dollar.

# github-backup

Back up your Github repositories locally.

To install it as a Gem, just run:

    $ gem install github-backup

To use it:

    $ github-backup ddollar /path/to/my/backup/root

## Authenticated Usage

### Seamless authentication using .gitconfig defaults

You will need a `~/.gitconfig` file in place with a `[github]` section

See: http://github.com/guides/tell-git-your-user-name-and-email-address

### Prompt for authentication

If you don't have a `[github]` section set up in your `~/.gitconfig` file, you 
can provide your user name and Github API token at the prompt.

## License

MIT License

## Author

David Dollar

## Copyright

Copyright (c) 2010 David Dollar.

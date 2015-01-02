VERSION = $(shell ruby -Ilib -rgithub-backup -e "puts Github::Backup::VERSION")

SOURCES = Gemfile Gemfile.lock bin/github-backup lib/github-backup.rb
GEMSPEC = github-backup.gemspec
GEM     = github-backup-$(VERSION).gem

all: pkg/$(GEM)

release: pkg/$(GEM)
	gem push pkg/$(GEM)

pkg/$(GEM): $(GEMSPEC) $(SOURCES)
	gem build $(GEMSPEC)
	@mkdir -p pkg/
	mv $(GEM) pkg/$(GEM)

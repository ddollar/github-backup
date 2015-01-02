VERSION = $(shell ruby -Ilib -rgithub-backup -e "puts Github::Backup::VERSION")

SOURCES = Gemfile Gemfile.lock github-backup.gemspec bin/github-backup lib/github-backup.rb
GEM     = pkg/github-backup-$(VERSION).gem

all: $(GEM)

release: $(GEM)
	gem push $(GEM)

$(GEM): $(SOURCES)
	gem build github-backup.gemspec
	@mkdir -p pkg/
	mv github-backup-$(VERSION).gem $(GEM)

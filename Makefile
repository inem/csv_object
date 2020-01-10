c:
	bin/console

test:
	rake test

build:
	gem build csv_object.gemspec

push:
	gem push *.gem

all: test build push cleanup

release:
	# TODO
	# make all
	# + create tag
	# + git push

cleanup:
	rm *.gem

.PHONY: test
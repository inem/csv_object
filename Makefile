c:
	bin/console

test:
	rake test

build:
	gem build csv_object.gemspec

push:
	gem push *.gem

all: test build push cleanup

cleanup:
	rm *.gem

.PHONY: test
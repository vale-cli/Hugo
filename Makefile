.PHONY: test zip sync

all: test

zip:
	zip -r Hugo.zip Hugo -x "*.DS_Store"

sync:
	cd testdata && vale sync && cd -
	cd testdata/leaks && vale sync && cd -

test: zip sync
	go test -v ./...

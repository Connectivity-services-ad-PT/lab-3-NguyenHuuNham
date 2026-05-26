.PHONY: install lint mock mock-core mock-analytics test-mock test-local test-html clean

install:
	npm install

lint:
	npm run lint:contract

mock: mock-core

mock-core:
	npm run mock:core

mock-analytics:
	npm run mock:analytics

test-mock:
	npm run test:mock

test-local:
	npm run test:local

test-html:
	npm run test:html

clean:
	rm -f reports/*.xml reports/*.html

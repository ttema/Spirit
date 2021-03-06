clean:
	rm -fr dist/ build/ *.egg-info/

docs:
	cd docs && make clean && make html

test:
	python -Wd runtests.py

testjs:
	npm run gulp test && \
	jasmine --config=spirit/core/static/spirit/scripts/test/support/jasmine.json

buildjs:
	npm run gulp coffee

sdist: test clean
	python setup.py sdist

release: sdist
	twine upload dist/*

txpush:
	python manage.py spiritmakemessages --locale en && \
	python manage.py spirittxpush

txpull:
	python manage.py spirittxpull && \
	python manage.py spiritcompilemessages

tx: txpush txpull

start:
	python manage.py runserver

.PHONY: clean test sdist release docs txpush txpull tx start

.PHONY: clean test

clean:
	rm -rf .cache
	rm -rf .tox
	find . -name '*.pyc' -delete
	find . -name '__pycache__' -delete

test:
	tox
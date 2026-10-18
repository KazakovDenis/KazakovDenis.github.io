install:
	sudo apt install hugo
	git submodule init && git submodule update

run:
	hugo server -D --baseURL http://localhost:1313/

content:
	hugo new posts/draft.en.md

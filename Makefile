install:
	sudo apt install hugo
	git submodule init && git submodule update

run:
	hugo server -D

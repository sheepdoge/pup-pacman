build:
	docker build -t sheepdoge/pup-pacman .

test: build
	docker run sheepdoge/pup-pacman /bin/bash -c "./test.sh"

interactive: build
	docker run -it sheepdoge/pup-pacman /bin/bash

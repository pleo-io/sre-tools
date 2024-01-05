build:
	docker build -t network-tools:latest .

kubernetes-run:
	kubectl run -it nt --image network-tools:latest bash

docker-run:
	docker run --rm \
		-it \
		network-tools:latest bash

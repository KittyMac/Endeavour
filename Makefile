SWIFT_BUILD_FLAGS=--configuration release

build:
	swift build -v $(SWIFT_BUILD_FLAGS)

update:
	swift package update

clean:
	rm -rf .build

test:
	swift test -v

docker:
	-docker buildx create --name cluster_builder203
	-DOCKER_HOST=ssh://rjbowli@192.168.111.203 docker buildx create --name cluster_builder203 --platform linux/amd64 --append
	-docker buildx use cluster_builder203
	-docker buildx inspect --bootstrap
	-docker login
	docker buildx build --platform linux/amd64,linux/arm64 --push -t kittymac/endeavour .

docker-shell:
	docker pull kittymac/endeavour
	docker run --rm -it --entrypoint bash kittymac/endeavour

docker-run:
	docker pull kittymac/endeavour
	docker run --publish published=8080,target=8080,mode=host kittymac/endeavour ./EndeavourApp http

docker-service-log:
	-ssh rjbowli@192.168.111.200 "docker service logs --follow endeavour-http"

docker-service-start:
	-ssh rjbowli@192.168.111.200 "docker service create --name endeavour-http --constraint 'node.hostname==cluster200' --publish published=9080,target=8080,mode=host --with-registry-auth --mode global kittymac/endeavour ./endeavour http"
	
docker-service-stop:
	-ssh rjbowli@192.168.111.200 "docker service rm endeavour-http"
	
docker-service-deploy: docker-service-stop docker-service-start
	echo "deployed"
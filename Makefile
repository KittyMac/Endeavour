SWIFT_BUILD_FLAGS=--configuration release

build: preprocess
	swift build -v $(SWIFT_BUILD_FLAGS)

update:
	swift package update

clean:
	rm -rf .build

test:
	swift test -v

docker:
	-docker buildx create --name local_builder
	-DOCKER_HOST=tcp://192.168.1.198:2376 docker buildx create --name local_builder --platform linux/amd64 --append
	-docker buildx use local_builder
	-docker buildx inspect --bootstrap
	-docker login
	docker buildx build --platform linux/amd64,linux/arm64 --push -t kittymac/endeavour .

docker-local:
	docker run --publish published=8080,target=8080,mode=host kittymac/endeavour:latest ./EndeavourApp http

docker-service-log:
	-ssh rjbowli@192.168.1.200 "docker service logs --follow endeavour-http"

docker-service-start:
	-ssh rjbowli@192.168.1.200 "docker service create --name endeavour-http --constraint 'node.hostname==cluster200' --publish published=9080,target=8080,mode=host --with-registry-auth --mode global kittymac/endeavour ./endeavour http"
	
docker-service-stop:
	-ssh rjbowli@192.168.1.200 "docker service rm endeavour-http"
	
docker-service-deploy: docker-service-stop docker-service-start
	echo "deployed"
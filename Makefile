SWIFT_BUILD_FLAGS=--configuration release

build: preprocess
	swift build -v $(SWIFT_BUILD_FLAGS)

setup:
	./meta/SetupTemplateProject.sh
	#rm -f ./meta/SetupTemplateProject.sh

preprocess:
	./meta/CombinedBuildPhases.sh

figurehead:
	mate ./.build/checkouts/Figurehead/Resources/

update:
	mkdir -p ./Sources/Pamphlet
	swift package update
	rm -rf ./Sources/Pamphlet
	./meta/CombinedBuildPhases.sh

clean:
	rm -rf .build

test:
	swift test -v

pamphlet:
	rm -rf ./Sources/Pamphlet
	./meta/CombinedBuildPhases.sh

xcode: pamphlet preprocess
	swift package generate-xcodeproj
	meta/addBuildPhase Endeavour.xcodeproj/project.pbxproj "Endeavour::Endeavour" 'export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$$PATH; cd $${SRCROOT}; ./meta/CombinedBuildPhases.sh'
	#meta/addBuildPhase Endeavour.xcodeproj/project.pbxproj "Endeavour::Pamphlet" 'export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$$PATH; cd $${SRCROOT}; ./meta/CombinedBuildPhases.sh'
	sleep 2
	open Endeavour.xcodeproj

docker:
	-DOCKER_HOST=tcp://192.168.1.209:2376 docker buildx create --name cluster --platform linux/arm64/v8 --append
	-DOCKER_HOST=tcp://192.168.1.198:2376 docker buildx create --name cluster --platform linux/amd64 --append
	-docker buildx use cluster
	-docker buildx inspect --bootstrap
	-docker login
	docker buildx build --platform linux/amd64,linux/arm64/v8 --push -t kittymac/endeavour .

docker-service-log:
	-ssh rjbowli@192.168.1.200 "docker service logs --follow endeavour-http"

docker-service-start:
	-ssh rjbowli@192.168.1.200 "docker service create --name endeavour-http --constraint 'node.hostname==cluster200' --publish published=9080,target=8080,mode=host --with-registry-auth --mode global kittymac/endeavour ./endeavour http"
	
docker-service-stop:
	-ssh rjbowli@192.168.1.200 "docker service rm endeavour-http"
	
docker-service-deploy: docker-service-stop docker-service-start
	echo "deployed"
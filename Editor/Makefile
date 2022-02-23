all:
	node_modules/.bin/rollup editor.js -f iife -o ../Resources/public/endeavour/editor.bundle.js -p @rollup/plugin-node-resolve
	

install:
	-brew install node
	npm install
	
	npm i codemirror
	npm i @codemirror/basic-setup
	npm i @codemirror/collab
	npm i @codemirror/lang-javascript
	npm i @codemirror/lang-json
	npm i rollup @rollup/plugin-node-resolve
	
	npm update
# Automatically generated from config.lua

.DEFAULT_GOAL := moonscript

documentation:
	@echo -e '\033[32mRunning documentation\033[0m'
	@luvit parse.lua config.lua documentation
format:
	@echo -e '\033[32mRunning format\033[0m'
	@lua-format *.lua ./**/*.lua -i -c .luaformat.yaml
moonscript:
	@echo -e '\033[32mRunning moonscript\033[0m'
	@moonc .
lint:
	@echo -e '\033[32mRunning lint\033[0m'
	@luacheck .

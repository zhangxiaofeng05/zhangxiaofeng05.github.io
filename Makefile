PROJ_NAME="hugoBlog"

help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'

## deps: install all the deps
deps:
	git submodule update --init --recursive

## dev: run dev server
dev:
	hugo server

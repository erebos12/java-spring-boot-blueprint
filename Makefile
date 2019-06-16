.DEFAULT_GOAL:=remote
SHELL:=/bin/bash

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\033[36m***This is the Makefile to build and start ndaco locally***\033[0m \n \nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)


kill: ## kill myapp
	@ docker ps | grep myapp | grep -v grep | awk '{print $$1}' | xargs docker stop ; echo "Stopped myapp"
remote: kill ## run myapp
	@ docker build -t myapp . && docker run -p 8080:8080 myapp


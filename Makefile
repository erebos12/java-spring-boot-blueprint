.DEFAULT_GOAL:=remote
SHELL:=/bin/bash

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\033[36m***This is the Makefile to build and start ndaco locally***\033[0m \n \nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)


kill: ## kill alex
	@ docker ps | grep alex | grep -v grep | awk '{print $$1}' | xargs docker stop ; echo "Stopped alex"
remote: kill ## run alex
	@ docker build -t alex . && docker run -p 8080:8080 alex


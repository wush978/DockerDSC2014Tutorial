# bridgewell docker makefile template

workdir = $(shell pwd)
tag = twdsc2014tutorial

flag = -v ${workdir}/src:/src -p 8787:8787
repo = wush978

bashflag = -i

all: build

build:
	docker build -t ${repo}/${tag} .

run:
	docker run ${flag} --name ${tag} -d ${repo}/${tag}

runbash:
	docker run ${bashflag} ${flag} --rm --name ${tag}-bash -it ${repo}/${tag} /bin/bash

runargv:
	docker run ${bashflag} ${flag} --name ${tag}-bash -d ${repo}/${tag} ${argv}

killargv:
	docker stop ${tag}-bash
	docker rm ${tag}-bash

kill:
	docker kill $(tag) && docker rm $(tag)

pull:
	docker pull ${repo}/${tag}

push:
	docker push ${repo}/${tag}

clean:
	-docker rm `docker ps -a -q`
	-docker images -q --filter "dangling=true" | xargs docker rmi

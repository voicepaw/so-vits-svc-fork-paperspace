.PHONY: install preprocess continue tensorboard
.ONESHELL:

help:	## Show this help and exit
	@grep -hE '^[A-Za-z0-9_ \-]*?:.*##.*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	pip install -U pip wheel lxml
	pip uninstall -y torchvision
	pip install -U torch==2.0.0 torchaudio==2.0
	pip install so-vits-svc-fork

preprocess: ## Preprocess data
	svc pre-resample
	svc pre-config
	svc pre-hubert

continue: install ## Continue training
	svc train

tensorboard: ## Start tensorboard
	echo https://tensorboard-$$(hostname).clg07azjl.paperspacegradient.com
	tensorboard --logdir logs/44k --bind_all

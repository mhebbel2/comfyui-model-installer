# ComfyUI model installer

Simple script to facilitate quick downloading of models for comfyui.

Although you probably don't need this for local single deployments, the accompanying vast ai helper script allows usage on newly created remote machines. 


## Requirements 

Runs on linux (tested debian/bash). Should work on mac OSX as well (not tested).

If you want to use the remote vast ai uploading feature
you need to install vastai CLI:

https://cloud.vast.ai/cli/

and get an API key and login the cli. 

## Using it with vast.ai

First get yourself an account and credit.

Then create a single machine with GPU using the vast ai console:

https://cloud.vast.ai/

Make sure:
- use the ComfyUI template
- adjust the "container size" to have enough room for the models. normally I use 150GB which works

All other options are up to you and how much money you want to spend. 

Recommendations from me:
- RTX5090 as a minimum for most models
- 1Gbps download speed (so you don't wait too long for model installation)
- 100 Mbps so the UI display of images and films oa snappy

Go to the instances view:

https://cloud.vast.ai/instances/

and wait for your instance to show up. Then simply run:

'''./vastai-load-gpu.sh'''

Note: this script assumes you have only one instance on vast ai.

When the model is loaded simply open the instances view and click on "Open" button... wait until the next view opens then click on "launch application"... wait and comfyui should open.

## Extending the choice of configs

All configs are stored in the 'configs.yaml' file.  New configs can be added to this. 

To use files where API keys are needed you have to start the template with the key. 

## Using it locally without vast ai

You can of course use it to load the models locally on your PC/Laptop.

Just go into the 'loader' directory and run the 'run.sh' script:

'''./run.sh'''

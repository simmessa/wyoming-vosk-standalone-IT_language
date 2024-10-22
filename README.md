# Wyoming Vosk Standalone
A standalone container for vosk using the wyoming protocol. Inspired by [this hass.io addon](https://github.com/rhasspy/hassio-addons/tree/master/vosk).

# Prerequisites
* docker
* docker compose (or another way of starting the container)

# Usage
* clone the repo
* build the container: `bash build.sh`
* optional: adapt `docker-compose.yaml` to your use-case
* run the container: `docker compose up`

A directory called `dirs` will be created in the current folder. Inside that folder are the volumes specified in `docker-compose.yaml`

# Using it in Home Assistant
* Settings->Integrations->Add Integration: Add the wyoming protocol and add the IP of wherever you are running `Wyoming Vosk Standalone`. The port is `10300`.

# Note
Pull requests and ideas/feature requests are always welcome!

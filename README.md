# Wyoming Vosk Standalone
A standalone container for vosk using the wyoming protocol. Inspired by [this hass.io addon](https://github.com/rhasspy/hassio-addons/tree/master/vosk).

# Prerequisites
* docker
* docker compose (or another way of starting the container)

# Usage
* clone the repo
* change into the repo: `cd wyoming-vosk-standalone`
* build the container: `bash build.sh`
* optional: adapt `docker-compose.yaml` to your use-case
* run the container: `docker compose up`

A directory called `dirs` will be created in the current folder. Inside that folder are the volumes specified in `docker-compose.yaml`

# Using it in Home Assistant
* Settings->Integrations->Add Integration: Add the wyoming protocol and add the IP of wherever you are running `Wyoming Vosk Standalone`. The port is `10300`.

# Using a specific model
Other Vosk-Models can be found [here](https://alphacephei.com/vosk/models). Let's say you want to use `vosk-model-de-0.21`, a german model (de)
* `cd` into the models directory: `cd dirs/models`
* Download the model: `wget https://alphacephei.com/vosk/models/vosk-model-de-0.21.zip`
* Unzip: `unzip vosk-model-de-0.21.zip`
* vosk uses the foldername to determine the language: `mv vosk-model-de-0.21 de`
* optional: delete the zip: `rm unzip vosk-model-de-0.21.zip`
# Note
Pull requests and ideas/feature requests are always welcome!

# Note on italian language addons

I decided to embed the italian small model found at https://alphacephei.com/vosk/models/vosk-model-small-it-0.22.zip directly in the docker image. Of course you should still run build.sh to build yours or for a quick test you can use the prebuilt I made at simmessa/wyoming-vosk-italian for a readymade solution.

# Note on correction and sentences yaml

Since home assistant, where I intended to use vosk, had a lot of issues with textual output (see https://www.reddit.com/r/homeassistant/comments/1hu28a4/vosk_really_fast_but_adds_random_letters_on/ for a reference) I found a way to make it more accurate.

Basically I configured the wyoming-vosk container to enable correction with a provided sentence file, here's an example configuration:

```
docker run -d \
  --name=vosk-italian \
  -e CORRECT_SENTENCES=10 \
  -e PRELOAD_LANGUAGE=it \
  -v /path/to/vosk_sentences/:/share/vosk/sentences \
  --restart unless-stopped \
  simmessa/wyoming-vosk-italian
```

Here's a reference for wyoming "correction" configuration:
https://github.com/rhasspy/wyoming-vosk#corrected

Based on this information I created an example sentences [yaml file](example_sentences_it.yaml)

Keep in mind that you should put the file in the `/path/to/vosk_sentences` folder mounted above and also name file with the same value for your language model. The correct value is `it.yaml` for our use case with italian language.

That's all, you can customize the sentences yaml file as you wish, but the important thing to consider here is that correction will still allow for speech captures that don't follow the template, for example I'm able to ask for the time or temperature and it will work just fine.

You might be interested in tweaking the CORRECT_SENTENCES param passed in env var if your model doesn't behave, all the relevant details are in the aforementioned [doc link](https://github.com/rhasspy/wyoming-vosk#corrected)
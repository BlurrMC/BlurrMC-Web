# BlurrMC for Web
This is the rails app for running the backend of BlurrMC and the frontend of BlurrMC web. BlurrMC is a short style video social media platform. This rails server is required for running BlurrMC and without it, BlurrMC for iOS will not work.
## Note:
BlurrMC is now a defunct social media platform. There is a lot of code that is written horribly, and there is also some code that is written less horribly.

# Requirements
### These are the following requirements for running BlurrMC:
#### Programs
*  FFMPEG
*  FFMPEGThumbnailer
*  Ruby
*  Nodejs
*  Yarn
*  clamav
*  clamav-daemon
*  OpenJDK 8 (JRE, headless)
*  Elastic Search
*  Rpush Dameon (included with Rpush gem)
#### Hardware
*  Ubuntu 20.04 64bit
*  12Gb RAM (Probably less if you removed clamav)
*  2+ CPU cores 

# Commands to run on startup
* `rpush start`
* `sidekiq -q carrierwave`
* `redis-server`

# Copyright
Copyright 2021 Martin Velev

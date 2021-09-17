# BlurrMC for Web
This is the rails app for running the backend of BlurrMC and the frontend of BlurrMC web. BlurrMC is a short style video social media platform. This rails server is required for running BlurrMC and without it, BlurrMC for iOS will not work.
## Note:
BlurrMC is now a defunct social media platform. I'll still accept merge requests and any plans to try and bring it "back to life", but I'm not gonna be maintaing this personally. All hosting for BlurrMC has also been stopped, so don't run the app and then come back to me asking why it no work. If you really would like to run this app, make sure to change every single "https://blurrmc.com" reference to wherever you are hosting BlurrMC's web app. This web app is seriously a mess as it is the first big project I ever started working on. There is a lot of code that is written horribly, and there is also some code that is written less horribly.

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

# Dummy Sidekiq website

Used to generate realtime dummy data for Sidequarter.

## Heroku deploy

Press & play:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

**NOTICE:** Because of the order in which Heroku starts the processes the web process is unable
to connect to Redis and crashes instantly. Just restart the web process and it should all work as expected.

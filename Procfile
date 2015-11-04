web: bundle exec rackup -p $PORT ./config.ru
worker: bundle exec sidekiq -C ./sidekiq.yml -r ./app.rb

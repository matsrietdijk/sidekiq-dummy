require 'sinatra'
require 'sidekiq'
require 'redis'
require 'sidekiq/api'

$redis = Redis.new(url: ENV['REDIS_URL'])

class HardWorker
  include Sidekiq::Worker

  def perform
    sleep(rand(10))
    self.class.perform_in(rand(10 * 60))
    ClumsyWorker.perform_in(rand(2 * 60)) if rand(200) < 25
  end
end

class SleepyWorker
  include Sidekiq::Worker

  def perform
    sleep(rand(60))
    self.class.perform_in(rand(60 * 60))
    ClumsyWorker.perform_in(rand(2 * 60)) if rand(200) < 25
  end
end

class ClumsyWorker
  include Sidekiq::Worker

  def perform
    sleep(rand(20))
    raise Exception, 'Uhm... that was clumsy!'
  end
end

get '/' do
  stats = Sidekiq::Stats.new
  @failed = stats.failed
  @processed = stats.processed
  "Generating dummy data... (processed: #{@processed}, failed: #{@failed})"
end

10.times do
  HardWorker.perform_in(rand(2 * 60))
  SleepyWorker.perform_in(rand(2 * 60))
  ClumsyWorker.perform_in(rand(2 * 60))
end

require 'sidekiq'
require 'sidekiq-cron'

class WeatherForecastWorker
  include Sidekiq::Worker

  def perform
    puts "WeatherForecastWorker is performing..."
    subscribers = WeatherSubscription.all

    puts "Number of subscribers: #{subscribers.size}"
    
    subscribers.each do |subscriber|
      email = subscriber.email
      location = subscriber.location

      WeatherMailer.daily_forecast_email(email, location).deliver_now
    end
    puts "WeatherForecastWorker finished performing."
  end
end

require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq::Cron::Job.create(
      name: 'weather_forecast_worker',
      cron: '0 6 * * *', # Chạy vào 6h sáng
      class: 'WeatherForecastWorker'
    )
  end
end


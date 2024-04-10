class WeatherMailer < ApplicationMailer
  require 'httparty'

  def confirmation_email(email)
    @user_email = email
    mail(to: @user_email, subject: 'Confirmation Email')
  end

  def unsubscription_email(email)
    @user_email = email
    mail(to: @user_email, subject: 'Unsubscription Email')
  end

  def confirmation_instructions(subscription, confirmation_token)
    @subscription = subscription
    @confirmation_token = confirmation_token
    mail(to: @subscription.email, subject: 'Confirm your weather subscription')
  end

  def daily_forecast_email(email, location)
    @user_email = email
    @location = location
    
    api_key = ENV['WEATHER_API_KEY']
    response = HTTParty.get("https://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{@location}")
    
    if response.success?
      @weather_forecast = response.parsed_response
      mail(to: @user_email, subject: 'Daily Weather Forecast') do |format|
        format.html { render 'daily_forecast_email' }
      end
    else
      Rails.logger.error "Failed to fetch weather data: #{response.code} - #{response.body}"
    end
  end
end

class Api::V1::WeathersController < ApplicationController
  require 'httparty'

  def index
    q = params[:q]

    q ||= "vietnam"

    api_key = ENV['WEATHER_API_KEY']
    
    response = HTTParty.get("https://api.weatherapi.com/v1/current.json?key=#{api_key}&q=#{q}")
    
    if response.success?
      render json: response.parsed_response
    else
      render json: { error: "Failed to fetch weather data" }, status: :bad_request
    end
  end

  def forecast
    q = params[:q]
    q ||= "vietnam"

    api_key = ENV['WEATHER_API_KEY']
    
    response = HTTParty.get("https://api.weatherapi.com/v1/forecast.json?key=#{api_key}&q=#{q}&days=14&tp=24")
    
    if response.success?
      parsed_response = response.parsed_response
      if parsed_response['forecast'] && parsed_response['forecast']['forecastday'].is_a?(Array)
        parsed_response['forecast']['forecastday'].shift
      end
      render json: parsed_response
    else
      render json: { error: "Failed to fetch weather forecast data" }, status: :bad_request
    end
  end
end

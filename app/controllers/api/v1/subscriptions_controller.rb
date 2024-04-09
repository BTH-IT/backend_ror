class Api::V1::SubscriptionsController < ApplicationController
  def subscribe
    email = params[:email]
    location = params[:location]
    if email.present? && location.present?
      WeatherSubscription.subscribe(email, location)
      render json: { message: "Subscribed successfully" }
    else
      render json: { error: "Email and location cannot be blank" }, status: :unprocessable_entity
    end
  end

  def unsubscribe
    email = params[:email]
    if email.present?
      WeatherSubscription.unsubscribe(email)
      render json: { message: "Unsubscribed successfully" }
    else
      render json: { error: "Email cannot be blank" }, status: :unprocessable_entity
    end
  end
end

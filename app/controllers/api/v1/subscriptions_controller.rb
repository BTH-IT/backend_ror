class Api::V1::SubscriptionsController < ApplicationController
  def subscribe
    email = params[:email]
    location = params[:location]
  
    if email.present? && location.present?
      existing_subscription = WeatherSubscription.find_by(email: email)
  
      if existing_subscription
        render json: { message: "Subscription exists for #{existing_subscription.email}" }, status: :bad_request
      else
        subscription = WeatherSubscription.subscribe(email, location)
        if subscription
          render json: { message: "Subscribed successfully" }
        else
          render json: { error: "Subscription failed" }, status: :unprocessable_entity
        end
      end
    else
      render json: { error: "Email and location cannot be blank" }, status: :unprocessable_entity
    end
  end

  def unsubscribe
    email = params[:email]
    if email.present?
      if WeatherSubscription.unsubscribe(email)
        render json: { message: "Unsubscribed successfully" }
      else
        render json: { error: "Unsubscription failed" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Email cannot be blank" }, status: :unprocessable_entity
    end
  end

  def confirm
    email = params[:email]
    token = params[:token]
    if email.present? && token.present?
      if WeatherSubscription.confirm(email, token)
        render json: { message: "Subscription confirmed successfully" }
      else
        render json: { error: "Invalid confirmation token or email" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Email and token cannot be blank" }, status: :unprocessable_entity
    end
  end
end

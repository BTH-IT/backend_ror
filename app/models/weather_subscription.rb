class WeatherSubscription < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :location, presence: true
  validates :confirmation_token, presence: true
  validates :confirmed, inclusion: { in: [true, false] }

  before_validation :generate_confirmation_token, on: :create

  def self.subscribe(email, location)
    existing_subscription = WeatherSubscription.find_by(email: email)
    if existing_subscription
      return existing_subscription
    end
  
    subscription = WeatherSubscription.new(email: email, location: location)
    subscription.generate_confirmation_token
    subscription.confirmed = false

    if subscription.save
      send_confirmation_email(subscription)
      subscription
    else
      nil
    end
  end
  

  def self.confirm(email, entered_token)
    subscription = WeatherSubscription.find_by(email: email)

    if subscription.confirmation_token == entered_token
      subscription.update(confirmed: true)
      WeatherMailer.confirm_subscription(email).deliver_now
      true
    else
      false
    end
  end
  
  def self.unsubscribe(email)
    subscription = WeatherSubscription.find_by(email: email)
    subscription.destroy if subscription
    WeatherMailer.unsubscription_email(email).deliver_now
  end

  def self.send_confirmation_email(subscription)
    confirmation_token = subscription.confirmation_token
    WeatherMailer.confirmation_instructions(subscription, confirmation_token).deliver_now
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.hex(10)
  end
end

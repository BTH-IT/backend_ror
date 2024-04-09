class WeatherSubscription < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :location, presence: true

  def self.subscribe(email, location)
    subscription = WeatherSubscription.new(email: email, location: location)
    if subscription.save
      subscription
    else
      nil
    end
  end
  
  def self.unsubscribe(email)
    subscription = WeatherSubscription.find_by(email: email)
    subscription.destroy if subscription
  end
end

class AddConfirmationTokenToWeatherSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_subscriptions, :confirmation_token, :string
  end
end

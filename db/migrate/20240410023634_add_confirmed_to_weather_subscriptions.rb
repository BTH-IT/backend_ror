class AddConfirmedToWeatherSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_subscriptions, :confirmed, :boolean, default: false
  end
end

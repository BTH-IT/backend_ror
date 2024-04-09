class CreateWeatherSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_subscriptions do |t|
      t.string :email, null: false
      t.string :location, null: false
      t.timestamps
    end
    add_index :weather_subscriptions, :email, unique: true
  end
end

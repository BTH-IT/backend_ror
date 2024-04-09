# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

EDITOR=vi rails credentials:edit --environment production

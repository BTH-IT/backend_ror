# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Chạy lệnh để chỉnh sửa credentials
VISUAL=vi bin/rails credentials:edit

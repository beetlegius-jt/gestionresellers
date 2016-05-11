require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  verify_urls true
  secret "d10d7cb61954b11c11d1b3929e6a2c87beba0c9c9d838fe06731acfd9385834b"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end

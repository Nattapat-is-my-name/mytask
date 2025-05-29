source "https://rubygems.org"

# Use a specific version of Rails
# For edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"

# Asset pipeline
gem "propshaft"

# Database
gem "pg", "~> 1.1"

# Web server
gem "puma", ">= 5.0"

# JavaScript support
gem "importmap-rails"
gem "turbo-rails"      # Hotwire's SPA-like page accelerator
gem "stimulus-rails"   # Hotwire's modest JavaScript framework

# Styling
gem "tailwindcss-rails"

# JSON APIs
gem "jbuilder"

# Platform-specific
gem "tzinfo-data", platforms: %i[windows jruby]

# Caching, queues, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Performance
gem "bootsnap", require: false

# Deployment
gem "kamal", require: false

# HTTP acceleration
gem "thruster", require: false

# Optional: Image processing for Active Storage
# gem "image_processing", "~> 1.2"

gem "dotenv-rails"
group :development, :test do
  # Debugging tools
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Testing frameworks
  gem "rspec-rails"
  gem "cucumber-rails", require: false
  gem "database_cleaner"

  # Static code analysis
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Console for exception pages
  gem "web-console"
end

group :test do
  # System testing tools
  gem "capybara"
  gem "selenium-webdriver"
  gem "simplecov", require: false
end

Rails.application.config.middleware.use OmniAuth::Builder do

  # If you want these to work in your development environment, you must obtain
  # additional configuration information for these providers, configure SSL, and
  # configure your hostname. See README.md for additional detail.
  #

  if ENV['GOOGLE_CLIENT_ID'].present?
    provider :google_oauth2,
             ENV['GOOGLE_CLIENT_ID'],
             ENV['GOOGLE_CLIENT_SECRET']
  else
    puts "skipping Google OmniAuth provider"
  end

  if ENV['GITHUB_CLIENT_ID'].present?
    provider :github,
             ENV['GITHUB_CLIENT_ID'],
             ENV['GITHUB_SECRET'],
             scope: 'user'
  else
    puts "skipping GitHub OmniAuth provider"
  end

  if ENV['TWITTER_CLIENT_ID'].present?
    provider :twitter,
             ENV['TWITTER_CLIENT_ID'],
             ENV['TWITTER_SECRET']
  else
    puts "skipping Twitter OmniAuth provider"
  end

  if ENV['DISCORD_CLIENT_ID'].present?
    provider :discord,
             ENV['DISCORD_CLIENT_ID'],
             ENV['DISCORD_CLIENT_SECRET'],
             scope: 'email identify'
  else
    puts "skipping Discord OmniAuth provider"
  end

  # This provider should almost definitely not be available in production.
  #
  unless Rails.env.production?
    provider :developer, fields: [:uid], uid_field: :uid
  end

end

OmniAuth.config.form_css = ''

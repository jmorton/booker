ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'


class ActiveSupport::TestCase

  # FACTORIES.
  include FactoryBot::Syntax::Methods

  # OMNIAUTH.
  OmniAuth.config.test_mode = true
  OmniAuth.config.add_mock(:developer, OmniAuth::AuthHash.new({
    provider: 'developer',
    uid: 'test.uid'
  }))

  # GEOCODER.
  Geocoder.configure(:lookup => :test)
  Geocoder::Lookup::Test.set_default_stub([
    {
      'coordinates'  => [43.5499749, -96.700327],
      'address'      => 'Sioux Falls, SD, USA',
      'state'        => 'South Dakota',
      'state_code'   => 'SD',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ])

  # HELPERS.

  def as_user(&block)
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth['developer']
    get '/auth/developer' and follow_redirect!
    yield
    get '/logout'
    Rails.application.env_config["omniauth.auth"] = nil
  end

end

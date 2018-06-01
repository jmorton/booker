ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/pride'

class ActiveSupport::TestCase

  # FACTORIES.
  include FactoryBot::Syntax::Methods

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

end

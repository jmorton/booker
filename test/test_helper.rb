ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase

  # FIXTURES.
  fixtures :all

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

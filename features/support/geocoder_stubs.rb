puts "Setting up Geocoder stubs..."

# Don't hammer geocoding services; use 'features/geocoder_stubs.rb' to define
# values for location queries.
#
Geocoder.configure(lookup: :test)

# This value is returned whenever a stub isn't found; for example, when a unit
# is created using Factories. If you remove it, you will not be able to find
# nearby units (during search).
Geocoder::Lookup::Test.set_default_stub([
  { 'latitude'     => 43.5499749,
    'longitude'    => -96.700327,
    'address'      => 'Sioux Falls, SD',
    'state'        => 'South Dakota',
    'state_code'   => 'SD',
    'country'      => 'United States',
    'country_code' => 'US'
  }
])

Geocoder::Lookup::Test.add_stub(
  "Sioux Falls, SD", [
  {
    'latitude'     => 43.5499749,
    'longitude'    => -96.700327,
    'address'      => 'Sioux Falls, SD, USA',
    'state'        => 'South Dakota',
    'state_code'   => 'SD',
    'country'      => 'United States',
    'country_code' => 'US'
  }
])

Geocoder::Lookup::Test.add_stub(
  "Salt Lake, NV", [
  {
    'coordinates'  => [42.286792, -120.321331],
    'address'      => 'Salt Lake, NV, USA',
    'state'        => 'Salt Lake',
    'state_code'   => 'NV',
    'country'      => 'United States',
    'country_code' => 'US'
  }
])

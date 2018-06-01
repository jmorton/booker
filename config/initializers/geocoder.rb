Geocoder.configure(
  :lookup => :nominatim,
  :cache  => {},
  :ssl    => true,
  :http_headers => { "User-Agent" => ENV['MY_CONTACT_INFO'] },
)

# Chronic should parse values using the application's default timezone.
#
# see config/application.rb -- the timezone should be 'UTC'
#
# see https://github.com/mojombo/chronic/issues/182#issuecomment-227152798

module Chronic
  def self.time_class
    ::Time.zone
  end
end

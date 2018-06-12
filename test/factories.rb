FactoryBot.define do

  factory :identity do
    provider :developer
    sequence(:uid) { |n| "uid_#{n}" }
  end

  factory :guest do
    association :identity
    sequence(:name) { |n| "guest_#{n}" }
  end

  factory :owner do
    association :identity
    sequence(:name) { |n| "owner_#{n}" }
  end

  factory :unit do
    association :owner
    sequence(:name)    { |n| "unit_#{n}" }
    sequence(:address) { |n| "400 S 4th Ave #{n}, Sioux Falls, SD 57104" }
    check_in  '3PM'
    check_out '11AM'
    local_tz  'Central Time (US & Canada)'
    longitude -96.720761
    latitude   43.542322
  end

  factory :reservation do
    association :guest
    association :unit
    start_at    { 1.weeks.from_now.iso8601 }
    end_at      { 2.weeks.from_now.iso8601 }
  end

end

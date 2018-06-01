FactoryBot.define do

  factory :guest do
    sequence(:name) { |n| "guest_#{n}"}
  end

  factory :unit do
    sequence(:name)    { |n| "unit_#{n}" }
    sequence(:address) { |n| "400 S 4th Ave #{n}, Sioux Falls, SD 57104" }
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

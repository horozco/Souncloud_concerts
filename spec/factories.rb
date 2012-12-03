FactoryGirl.define do
  factory :user do
      sequence(:full_name) {|n| "Alguien_ #{n}"}
      sequence(:email) {|n| "a_a#{n}@b.com"}
      password "password"
  end

  factory :event do
    date "date of event"
    time "any time and duration of the event"
    price 0.5
    artist_name "michael jackson"
    artist_track "michael jackson"
    track "a track"
    full_description "this is a description of my event test"

    #pertenece a un usuario
    user

    factory :invalid_event do
        user nil
        artist_track ""
        date ""
        time ""
        full_description ""
    end

  end
end
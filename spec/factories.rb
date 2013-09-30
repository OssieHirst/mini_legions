FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :micropost do
    content "Lorem ipsum"
    user
  end

  factory :miniature do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:material) { ["Metal", "Hard Plastic", "Soft Plastic", "Resin", "Card"].sample }
    release_date { rand(1..100).days.from_now }
  end
end
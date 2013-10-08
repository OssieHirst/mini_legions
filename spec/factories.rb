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
    release_date { "01/12/2001" }
    scale "28mm" 
  end
end
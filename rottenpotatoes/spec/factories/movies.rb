FactoryGirl.define do
  factory :movie do
    title "Star Wars"
    rating  "PG"
    director "George Lucas"
    release_date {10.years.ago}
  end
end
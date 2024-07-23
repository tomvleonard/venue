FactoryBot.define do
  factory :event do |e|
    sequence(:performer) { |n| "Peformer#{n}" }
    sequence(:content) { |n| "This is content for Performer#{n}" }
    e.when { DateTime.current + 1.week }
  end
end

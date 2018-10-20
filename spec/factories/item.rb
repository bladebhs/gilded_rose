FactoryBot.define do
  sequence :name do |n|
    "Item #{n}"
  end

  factory :item do
    name { generate(:name) }
    sell_in { (1..20).to_a.sample }
    quality { (1..50).to_a.sample }
    initialize_with { new(name, sell_in, quality) }
  end
end

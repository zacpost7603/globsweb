FactoryBot.define do 
    factory :user do |f|
        f.sequence(:name) { |n| "Test User#{n}" }
        f.sequence(:email) { |n| "test#{n}@account.com" }
        f.password { "password" }
        f.password_confirmation {|d| d.password} 
    end
    factory :glob do |f|
        f.sequence(:title) { |n| "Glob #{n}"}
        f.sequence(:summary) { |n| "Glob #{n}"}
        f.sequence(:author) { |n| "Test User#{n}" }
        f.association :user
    end
end
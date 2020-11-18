FactoryBot.define do
	factory :article, class: Article do
		title {Faker::Artist.name}
		author {Faker::Name.unique.name}
	end

	factory :comment, class: Comment do
		association :article, factory: :article
		comment {Faker::Lorem.sentence}
	end

	factory :user, class: User do
		email {Faker::Internet.email}
		password {Faker::Alphanumeric.alpha(number: 10)}
	end
end
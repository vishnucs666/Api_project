require 'rails_helper'

RSpec.describe Article, type: :model do
	subject {
		described_class.new(title: 'test_book',
			author: 'test_author')
	}

	describe 'validations' do
		it "is valid with valid attributes" do
			expect(subject).to be_valid
		end

		it "is not valid with a title" do
			subject.title = nil
			expect(subject).to_not be_valid
		end
		
		it "is not valid with a author" do
			subject.author = nil
			expect(subject).to_not be_valid
		end
	end

	describe 'Associations' do
		it { should have_many(:comments).without_validating_presence }
	end

end
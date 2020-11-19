require 'rails_helper'

RSpec.describe Comment, type: :model do
	subject {
		described_class.new(
			article_id: 2,
			comment: 'test comment')
	}
	describe 'validations' do
		it "is valid with valid attributes" do
			expect(subject).to be_valid
		end

		it "is not valid without an article" do
			subject.article_id = nil
			expect(subject).to_not be_valid
		end

		it "is not valid without a comment" do
			subject.comment = nil
			expect(subject).to_not be_valid
		end
	end
	describe "Associations" do
		it { should belong_to(:article).without_validating_presence }
	end
end
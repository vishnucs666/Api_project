class Article < ApplicationRecord
	#associations
	has_many :comments
	#validations
	validates_presence_of :title
	validates_presence_of :author
end

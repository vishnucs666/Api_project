class Comment < ApplicationRecord
	belongs_to :article, optional: true
	#validations
	validates_presence_of :comment, :article_id
end

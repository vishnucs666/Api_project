require 'rails_helper'

RSpec.describe Api::ArticlesController, type: :controller do
	render_views
	describe 'POST /api/articles' do
		context 'with valid params' do
			let(:valid_params) do
				{
					article: {
						title: 'vishnu',
						author: 'vishnu_cs'
					}
				}
			end

			it 'creates new article' do
				expect {post :create, params: valid_params}.to change(Article, :count).by(+1)
				expect(response).to have_http_status(:created)
			end

			it 'creates a article with valid params' do
				post :create, params: valid_params
				expect(Article.last).to have_attributes valid_params[:article]
			end

		end
	end
end

RSpec.describe Api::ArticlesController, type: :controller do
	render_views
	let(:record) {FactoryBot.create_list(:article, 1)}

	it 'should return status 204' do
		expect {delete :destroy, params: {id: record.first.id}}.to change(Article, :count).by(0)
		expect(response.status).to eq 204
	end

end

RSpec.describe Api::ArticlesController, type: :controller do
	render_views

	describe 'POST /api/articles/:id/create_comment' do
		let(:comment_params) {FactoryBot.create_list(:comment, 1).map}

		it 'creates a new comment for an article' do
			expect {post :create_comment, params: {id: comment_params.first.article_id, comment: comment_params.first.comment}}.to change(Comment, :count).by(+2)
			expect(response.status).to eq 200
		end
	end
end
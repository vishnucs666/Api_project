require 'rails_helper'

RSpec.describe 'Api::ArticlesController', type: :request do
	# render_views
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
			let(:user) { FactoryBot.create_list(:user, 1)}
		
			let(:authorization) { 'Bearer ' + AUTH }

			it 'creates new article' do
				post "/signup", params: {user: {email: user.first.email, password: user.first.password, password_confirmation: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
				post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
				token_from_request = response.headers['Authorization'].split(' ').last
				binding.pry
				header = {"Authorization": "Bearer #{token_from_request}", "Accept": "application/json"} 
				request.headers.merge!(header)
				# request.headers['Authorization'] = token_from_request
				post '/api/articles', params: valid_params.to_json
				
				binding.pry
				expect(response.body).to change(Article, :count).by(+1)
				# expect {post :create, params: valid_params}.to change(Article, :count).by(+1)
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
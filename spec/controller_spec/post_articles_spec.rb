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
		
      before do
      	post "/signup", params: {user: {email: user.first.email, password: user.first.password, password_confirmation: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
				post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
				@token_from_request = response.headers['Authorization'].split(' ').last
      end

			it 'creates new article' do
				expect{post '/api/articles', params: valid_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}}.to change(Article, :count).by(+1)
				expect(response).to have_http_status(:created)
			end

			it 'creates a article with valid params' do
				post '/api/articles', params: valid_params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}
				expect(Article.last).to have_attributes valid_params[:article]
			end

		end
	end
end

RSpec.describe 'Create a comment for an article', type: :request do

		let(:comment_params) {FactoryBot.create_list(:comment, 1).map}
		let(:user) { FactoryBot.create_list(:user, 1) }

		before do
			post "/signup", params: {user: {email: user.first.email, password: user.first.password, password_confirmation: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
			post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
			@token_from_request = response.headers['Authorization'].split(' ').last
		end

		it 'creates a new comment for an article' do
			expect {post "/api/articles/#{comment_params.first.article_id}/create_comment", params: {id: comment_params.first.article_id, comment: comment_params.first.comment}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}}.to change(Comment, :count).by(+2)
			expect(response.status).to eq 200
		end

end
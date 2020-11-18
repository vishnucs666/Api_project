require 'rails_helper'
require 'json'

RSpec.describe "POST /login", type: :request do 
	let(:user) {User.create!(email: 'vishnucs477@gmail.com',
													 password: 'vishnu123',
													 password_confirmation: 'vishnu123')}
	let(:url) {'/login'}
	let(:params) do
		{
			user: {
				email: user.email,
				password: user.password
			}
		}
	end

	context 'when params are correct' do
		before do
			post url, params: params.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
		end

		it 'returns 200' do
			expect(response).to have_http_status(200)
		end

		it 'returns JWT token in authorization header' do
			expect(response.headers['authorization']).to be_present
		end

		it 'returns valid JWT token' do
			token_from_request = response.headers['Authorization'].split(' ').last
			decoded_token = JWT.decode(token_from_request, Rails.application.credentials.dig(:jwt_token), true)
			expect(decoded_token.first['sub']).to be_present
		end

	end

	context 'when login params are incorrect' do
		before { post url }

		it 'returns unauthorized status' do
			expect(response.status).to eq 401
		end
	end

end

RSpec.describe Api::ArticlesController, type: :controller do

	render_views
	let(:article) {FactoryBot.create_list(:article, 10)}

	it 'returns all articles' do
		get :index, format: :json
		expect(JSON.parse(response.body).size).to eq(1)
	end	

	it 'returns status code 200' do
		expect(response).to have_http_status(:success)
	end

end

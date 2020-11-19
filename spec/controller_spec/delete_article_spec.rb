RSpec.describe 'Delete an article', type: :request do
	let(:record) {FactoryBot.create_list(:article, 1)}
	let(:user) {FactoryBot.create_list(:user, 1)}

	before do
		post "/signup", params: {user: {email: user.first.email, password: user.first.password, password_confirmation: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
		post "/login", params: {user: {email: user.first.email, password: user.first.password}}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
		@token_from_request = response.headers['Authorization'].split(' ').last
	end

	it 'should return status 204' do
		expect {delete "/api/articles/#{record.first.id}", params: {id: record.first.id}.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json', 'Authorization' => "Bearer #{@token_from_request}"}}.to change(Article, :count).by(0)
		expect(response.status).to eq 204
	end

end
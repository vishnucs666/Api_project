module ApiHelper
	def authenticated_header(request, user)
		auth_headers = Devise::JWT::TestHelper.auth_headers({, user)
		request.headers.merge!(auth_headers)
	end
end
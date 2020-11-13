json.(user, :id, :email, :username)
json.token user.generate_auth_token
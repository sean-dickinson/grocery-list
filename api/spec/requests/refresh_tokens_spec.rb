require "rails_helper"

RSpec.describe "Refresh Tokens", type: :request do
  describe "POST /users/tokens" do
    it "creates a new token using the refresh token" do
      user = create(:user)
      expired_jwt, refresh_token = jwt_and_refresh_token(user, "user", expired: true)

      post user_tokens_path, headers: {Authorization: "Bearer #{expired_jwt}", "Refresh-Token": refresh_token}

      expect(response).to have_http_status(200)
      new_jwt = response.headers["Access-Token"]
      expect(new_jwt).to be_present
      expect(new_jwt).not_to eq(expired_jwt)
    end
  end
end

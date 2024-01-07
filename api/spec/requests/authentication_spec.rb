require "rails_helper"

RSpec.describe "Authentication", type: :request do
  describe "POST /users/sign_in" do
    it "successfully allows a user to sign in" do
      user = create(:user)

      post user_sign_in_path, params: {email: user.email, password: user.password}

      expect(response).to have_http_status(200)
      expect(response.headers["Access-Token"]).to be_present
    end

    it "rejects an incorrect password" do
      user = create(:user, password: "password")

      post user_sign_in_path, params: {email: user.email, password: "incorrect"}

      expect(response).to have_http_status(422)
    end

    it "rejects an incorrect email" do
      user = create(:user)

      post user_sign_in_path, params: {email: "incorrect", password: user.password}

      expect(response).to have_http_status(422)
    end
  end

  describe "DELETE /users/sign_out" do
    it "successfully allows a user to sign out" do
      user = create(:user)
      jwt, refresh_token = jwt_and_refresh_token(user, "user")

      delete user_sign_out_path, headers: {Authorization: "Bearer #{jwt}", "Refresh-Token": refresh_token}

      expect(response).to have_http_status(200)
      # TODO: test that the token in no longer valid by attempting to hit a protected endpoint once we have one
    end
  end
end

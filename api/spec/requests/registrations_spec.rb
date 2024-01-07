require "rails_helper"

RSpec.describe "user registration", type: :request do
  describe "POST /users/sign_up" do
    it "allows a new user to sign up" do
      valid_user_params = {
        email: "testuser@example.com",
        password: "test_password123",
        password_confirmation: "test_password123"
      }
      post user_sign_up_path, params: valid_user_params
      expect(response).to have_http_status(200)
      expect(response.headers["Access-Token"]).to be_present
    end

    it "rejects if the password does not match the password confirmation" do
      invalid_user_params = {
        email: "testuser@example.com",
        password: "test_password123",
        password_confirmation: "test_password1234"
      }
      post user_sign_up_path, params: invalid_user_params
      expect(response).to have_http_status(422)
    end

    it "rejects if the email is already taken" do
      user = create(:user)
      invalid_user_params = {
        email: user.email,
        password: "test_password123",
        password_confirmation: "test_password123"
      }
      post user_sign_up_path, params: invalid_user_params
      expect(response).to have_http_status(422)
    end
  end
end

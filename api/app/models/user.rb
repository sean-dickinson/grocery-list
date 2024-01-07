# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  api_guard_associations refresh_token: "refresh_tokens"
  has_many :refresh_tokens, dependent: :delete_all

  validates :email, presence: true, uniqueness: true
end

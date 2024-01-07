# == Schema Information
#
# Table name: refresh_tokens
#
#  id         :integer          not null, primary key
#  expire_at  :datetime
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_refresh_tokens_on_token    (token) UNIQUE
#  index_refresh_tokens_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :refresh_token do
    token { "MyString" }
    user { nil }
    expire_at { "2024-01-07 15:26:15" }
  end
end

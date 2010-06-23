require 'test_helper'

class UserTest < ActiveSupport::TestCase
end

# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  username          :string(255)
#  email             :string(255)
#  persistence_token :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  roles             :string(255)     default("--- []")
#


require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end

# == Schema Information
#
# Table name: reservations
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  press_id   :integer
#  date       :datetime
#  hour       :integer
#  created_at :datetime
#  updated_at :datetime
#


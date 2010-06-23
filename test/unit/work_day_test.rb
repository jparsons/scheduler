require 'test_helper'

class WorkDayTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: work_days
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  start_hour :integer
#  end_hour   :integer
#  created_at :datetime
#  updated_at :datetime
#  day_number :integer
#


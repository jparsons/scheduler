require 'test_helper'

class HolidayTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Holiday.new.valid?
  end
end

# == Schema Information
#
# Table name: holidays
#
#  id         :integer         not null, primary key
#  date       :date
#  name       :string(255)
#  note       :text
#  created_at :datetime
#  updated_at :datetime
#


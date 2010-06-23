class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :press
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


class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :press

  named_scope :current, :conditions=>["date >= ? and cancelled = ?", Date.today, false], :order=>'date, hour asc'
  named_scope :current_cancellations, :conditions=>["date >= ? and cancelled = ?", Date.today, true], :order=>'date, hour asc'

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


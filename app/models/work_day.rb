class WorkDay < ActiveRecord::Base
  
  def display_name
    WEEKDAYS.index(day_number)
  end
  
  def display_start_hour
    HOURS.index(start_hour)
  end
  
  def display_end_hour
    HOURS.index(end_hour)
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


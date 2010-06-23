# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def available_days
    @workdays = WorkDay.all 
    @workdays.map{|d| d.display_name}.join(",").to_json
  end
  
  def holidays
    @holidays = Holiday.all
    @holidays.map{|h| [h.date.month, h.date.day, h.date.year] }.to_json
  end
end

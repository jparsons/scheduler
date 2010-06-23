class Press < ActiveRecord::Base
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "50x50!" }
  has_many :reservations
  
end


# == Schema Information
#
# Table name: presses
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#


class User < ActiveRecord::Base
  acts_as_authentic

  has_many :reservations

  named_scope :unconfirmed, :conditions=>"role = 'unconfirmed'", :order => 'last_name'
  named_scope :confirmed, :conditions=>"role = 'confirmed'", :order => 'last_name'
  named_scope :suspended, :conditions=>"role = 'suspended'", :order => 'last_name'
  named_scope :administrator, :conditions=>"role = 'administrator'", :order => 'last_name'

  after_create :send_initial_email
  before_save :send_confirmation_email

  def send_initial_email
    UserMailer.deliver_welcome(self)
  end

  def send_confirmation_email
    # only send if role has been changed to confirmed
    if role == "confirmed" && role_was != "confirmed" && valid?
      UserMailer.deliver_confirmation(self)
    end
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end

  def send_reservations_email
    ReservationMailer.deliver_reservation_confirmation(self)
  end

  def admin?
    role == "administrator"
  end

  def current_reservations_list
    reservations.current.map{|res| "#{res.date.strftime("%m/%d/%Y")} - #{HOURS.index(res.hour)} - #{res.press.name}"}
  end

  def current_cancellations_list
    reservations.current_cancellations.map{|res| "#{res.date.strftime("%m/%d/%Y")} - #{HOURS.index(res.hour)} - #{res.press.name}"}
  end

end


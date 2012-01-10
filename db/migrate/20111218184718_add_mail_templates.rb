class AddMailTemplates < ActiveRecord::Migration
  def self.up
    MailTemplate.create!(:name => "confirmation", 
      :body => "Congratulations {{name}},\n\nYou are now a confirmed member of The Arm letterpress studio. Now you can reserve studio time using our online reservations system. Just go to the the site (http://thearmnyc.com) and click on the link that says \"Reserve Press Time\". Enter your e-mail address and password and  you can start reserving press time.\n\n\nThanks,\n\nThe Arm")

    MailTemplate.create!(:name => "password_reset_instructions", 
      :body => "A request to reset your password has been made.\n  If you did not make this request, simply ignore this email.\n  If you did make this request just click the link below:\n{{reset_url}}\nIf the above URL does not work try copying and pasting it into your browser.\nIf you continue to have problem please feel free to contact us.")

    MailTemplate.create!(:name => "welcome", 
      :body => "Hello {{name}},\n\nThank you for your interest in The Arm letterpress studio. We will be reviewing your request and will be in contact with you soon.\n\nThanks,The ArmA request to reset your password has been made.\n  If you did not make this request, simply ignore this email.\n  If you did make this request just click the link below:\n{{reset_url}}\nIf the above URL does not work try copying and pasting it into your browser.\nIf you continue to have problem please feel free to contact us.")

    MailTemplate.create!(:name => "reservation_confirmation", 
      :body => "{{name}},\n\nHere is a list of your recent reservation activity. Please check it carefully. If there are any mistakes you can correct them on our web site or e-mail us at dan@thearmnyc.com.\n{% if current_reservations.size > 0 %}\nhello{% for reservation in current_reservations %}\n{{ reservation.date.strftime(\%m/%d/%Y\") }} - {{ HOURS.index(reservation.hour) }} - {{ reservation.press.name }}\n{% endfor %}\n{% endif %}\nThanks,\n\nThe Arm")
    
  end

  def self.down
    MailTemplate.destroy_all
  end
end

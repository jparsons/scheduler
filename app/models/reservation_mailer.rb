class ReservationMailer < ActionMailer::Base

  def reservation_confirmation(user)
     @recipients    = user.email
     @from          = "The Arm <admin@thearmny.com>"  
     @subject       = "Your reservation activity"  
     @sent_on       = Time.now 
     @body          = { 
                         "name" => user.first_name, 
                         "current_reservations" => user.current_reservations_list,
                         "cancellations" => user.current_cancellations_list
                        }
  
  end
  
  def render_message(method_name, body)

    mail_template = MailTemplate.find_by_name(method_name)
    template = Liquid::Template.parse(mail_template.body)
    template.render body
  end  
  
end
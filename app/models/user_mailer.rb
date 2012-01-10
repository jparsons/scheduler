class UserMailer < ActionMailer::Base

  default_url_options[:host] = "thearmnyc.com"  

  def welcome(user)
     @recipients = user.email
     @cc         = "dan@thearmnyc.com"
     @from       = "The Arm <dan@thearmnyc.com>"  
     @subject    = "Welcome to The Arm"  
     @sent_on    = Time.now 
     @body       = {"name" => user.first_name}

  end  

  def password_reset_instructions(user)  
    @subject      =  "Password Reset Instructions"  
    @from         = "The Arm <dan@thearmnyc.com>"
    @recipients   =  user.email  
    @sent_on      =  Time.now  
    @body         =  {"reset_url" => edit_password_reset_url(user.perishable_token)} 
  end  


  def confirmation(user)
    @from       = "The Arm <dan@thearmnyc.com>"
    @recipients = user.email
    @subject    = "Congratulations, you have been confirmed"
    @body       = {"name" => user.first_name}
    @sent_on    = Time.now
    @headers    = {}
  end

  def render_message(method_name, body)

    mail_template = MailTemplate.find_by_name(method_name)
    template = Liquid::Template.parse(mail_template.body)
    template.render body
  end
end

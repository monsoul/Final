class HcdMailer < ActionMailer::Base
  default from: "478311864@qq.com"
  def confirm(email)
        @message = "Thank you for confirmation!"
        mail(:to => email, :subject => "Registered")  
  end  
end

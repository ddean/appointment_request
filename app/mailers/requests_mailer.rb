class RequestsMailer < ActionMailer::Base
  default from: "ddean@leaptide.net"
  default to: "ddean@leaptide.net"  # TODO: env setting
  
  def new_message(appointment)
    @appointment = appointment
    mail(:subject => appointment.subject)
  end
  
end

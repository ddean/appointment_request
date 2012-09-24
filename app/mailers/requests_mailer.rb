class RequestsMailer < ActionMailer::Base
  default from: "appointment-requests@parkcentrevets.com"
  default to: ENV['APPOINTMENT_REQUESTS_TO'].split(",")
  
  def new_message(appointment)
    @appointment = appointment
    mail(:subject => appointment.subject)
  end
  
end

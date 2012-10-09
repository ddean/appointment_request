class AppointmentsController < ApplicationController
  def new
    puts FBGraph::Canvas.parse_signed_request(AppointmentRequest::Application.config.FB_App_Secret, params[:signed_request]).inspect if params[:signed_request]
    @in_facebook = !!params[:signed_request]
    @appointment = Appointment.new
  end
  
  def create
    @appointment = Appointment.new(params.select {|k| Appointment.attribute_method?(k.to_sym)})
    
    if @appointment.valid?
      RequestsMailer.new_message(@appointment).deliver
      #redirect_to(root_path, :notice => "Appointment request was successfully sent.")
      render :json => {}, :status => 200
    else
      render :json => @appointment.errors.to_json, :status => 400
    end
  end
end

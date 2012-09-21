class AppointmentsController < ApplicationController
  def new
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

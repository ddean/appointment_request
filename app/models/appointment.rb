class Appointment
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :first_name, :last_name, :pet_name, :species, :patient_type, :phone, :email, :first_date, :first_time, :second_date, :second_time, :reason, :comments 

  validates_presence_of :first_name, :last_name, :pet_name, :species, :patient_type, :phone, :email, :first_date, :first_time, :reason
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_each :first_date, :second_date do |record, attr, value|
    if value == Date.new
      record.errors.add attr, "is not a valid date"     
    else
      record.errors.add attr, "is in the past" if value && value < Date.today
      record.errors.add attr, "is too far in the future" if value && value > (Date.today + 90.days)
    end
  end
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      if name.ends_with?("_date")
        value = Date.parse(value) rescue Date.new
      end 
      send("#{name}=", value)
    end
  end
  
  def subject
    # TODO: better impl
    "[PCAH Appointment Request] for \"#{pet_name}\" #{last_name} : #{dates_requested}"
  end

  def dates_requested
    s = []
    tomorrow = Date.today + 1.days
    
    [:first_date, :second_date].each do |dt_sym|
      dt = self.send(dt_sym)
      s << (dt == tomorrow ? dt.strftime("Tomorrow (%A), %B %-d, %Y") : dt.strftime("%A, %B %-d, %Y")) + " " + self.send((dt_sym.to_s.split("_")[0]+ "_time").to_sym) unless dt.nil?
    end
    
    s.join(", or ")
  end
  
  def persisted?
    false
  end
end

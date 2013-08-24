namespace :appointments do

	desc "ping"
	task :refresh_page => :environment do
	  uri = URI.parse("https://pcah-appointments.herokuapp.com")
	  Net::HTTP.get(uri)
	end
end
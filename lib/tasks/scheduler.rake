require 'open-uri'

namespace :appointments do

	desc "ping"
	task :refresh_page => :environment do
		open('http://pcah-appointments.herokuapp.com') {|f| f.read }
	end
end

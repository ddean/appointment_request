desc "called by Heroku Scheduler to keep dyno running"
task :refresh_page => :environment do
  uri = URI.parse("https://pcah-appointments.herokuapp.com")
  Net::HTTP.get(uri)
end
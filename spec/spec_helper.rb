require 'rspec'
require 'pg'
require 'doctor'

DB = PG.connect(:dbname => 'doctor_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

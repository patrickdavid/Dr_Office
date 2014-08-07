require 'rspec'
require 'pg'
require 'doctor'
require 'patient'
require 'pry'
require 'specialty'
require 'insurance'

DB = PG.connect(:dbname => 'doctor_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctor_patient *;")
    DB.exec("DELETE FROM specialties *;")
    DB.exec("DELETE FROM insurance *;")
    DB.exec("DELETE FROM doctor_specialty *;")
    DB.exec("DELETE FROM doctor_insurance *;")
  end
end

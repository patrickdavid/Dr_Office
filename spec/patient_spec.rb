require 'spec_helper'


describe 'Patient' do
  it'initializes the Patient class with a name' do
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01'})
    patient1.should be_an_instance_of Patient
  end

  it 'saves the Patient to the database' do
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'doctor_id' => 1})
    patient1.save
    expect(Patient.all).to eq [patient1]
  end

  it 'assigns a patient a doctor id' do
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'doctor_id' => 1})
    patient1.save
    expect(patient1.doctor_id).to eq 1
  end

  # it 'lists the patients who have the same doctor ID' do
  #   patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'doctor_id' => 1})
  #   patient1.save
  #   patient2 = Patient.new({'name'=>'Jane Smith', 'birthdate' => '1980-01-01', 'doctor_id' => 1})
  #   patient2.save
  #   expect(patient1.doctor_id).to eq 1
  # end


end

require 'spec_helper'


describe 'Patient' do
  it'initializes the Patient class with a name' do
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.should be_an_instance_of Patient
  end

  it 'saves the Patient to the database' do
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.save
    expect(Patient.all).to eq [patient1]
  end

end

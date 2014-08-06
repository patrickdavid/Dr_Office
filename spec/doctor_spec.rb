require 'spec_helper'


describe 'Doctor' do
  it'initializes the doctor class with a name' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang', 'specialty' => 'Optometry'})
    doctor1.should be_an_instance_of Doctor
  end

  it 'saves the doctor to the database' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang', 'specialty' => 'Optometry'})
    doctor1.save
    expect(Doctor.all).to eq [doctor1]
  end

  it 'lists all the doctors of the same specialty' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang', 'specialty' => 'Optometry'})
    doctor1.save
    doctor2 = Doctor.new({'name'=>'Dr. Smith', 'specialty' => 'Optometry'})
    doctor2.save
    doctor3 = Doctor.new({'name'=>'Dr. Williams', 'specialty' => 'Optometry'})
    doctor3.save
    expect(Doctor.specialty_doctors('Optometry')).to eq ['Dr. Wang', 'Dr. Smith', 'Dr. Williams']
  end
end

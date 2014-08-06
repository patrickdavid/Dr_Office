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
end

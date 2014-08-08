require 'spec_helper'

describe 'Appointment' do
  it 'will initialize the Appointment class with certain attributes' do
    new_appt = Appointment.new({ })
    expect(new_appt).to be_an_instance_of Appointment
  end

  it 'schedules a patient, a doctor, a date to an appointment' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.save
    patient2 = Patient.new({'name'=>'Jane Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient2.save
    appointment1 = Appointment.new({ 'patient_id'=>patient1.id, 'doctor_id'=> doctor1.id, 'date' => '2015-12-12 00:00:00'})
    appointment1.save
    doctor1.add_patient(patient1)
    doctor1.add_patient(patient2)
    # appointment1.add_patient(patient1)
    # appointment1.add_doctor(doctor1)
    # appointment1.add_date(date1)
    # results = DB.exec('SELECT * FROM appointments;')
    # expect(results.first['patient_id'].to_i).to eq patient1.id
    # expect(results.first['doctor_id'].to_i).to eq doctor1.id
    # expect(results.first['date']).to eq date1
    appointment2 = Appointment.new({ 'patient_id'=> patient2.id, 'doctor_id'=> doctor1.id, 'date' => '2015-12-12 00:00:00'})
    appointment2.save

    expect(Appointment.show_appt(doctor1)).to eq [appointment1, appointment2]
  end
end

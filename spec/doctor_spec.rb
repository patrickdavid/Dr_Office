require 'spec_helper'


describe 'Doctor' do
  it'initializes the doctor class with a name' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang'})
    doctor1.should be_an_instance_of Doctor
  end

  it 'saves the doctor to the database' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang'})
    doctor1.save
    expect(Doctor.all).to eq [doctor1]
  end

  it 'lists all doctors in the database' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang'})
    doctor1.save
    doctor2 = Doctor.new({'name'=>'Dr. Smith'})
    doctor2.save
    doctor3 = Doctor.new({'name'=>'Dr. Smang'})
    doctor3.save
    expect(Doctor.all).to eq [doctor1, doctor2, doctor3]
  end

  it 'adds a patient to a doctor' do
    doctor1 = Doctor.new({'name'=>'Dr. Wang'})
    doctor1.save
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.save
    doctor1.add_patient(patient1)
    results = DB.exec('SELECT * FROM doctor_patient;')
    expect(results.first['doctor_id'].to_i).to eq doctor1.id
    expect(results.first['patient_id'].to_i).to eq patient1.id
  end

  it 'adds a specialty to a doctor' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    specialty1 = Specialty.new({'specialty' => 'Optometry'})
    specialty1.save
    doctor1.add_spec(specialty1)
    results = DB.exec('SELECT * FROM doctor_specialty;')
    expect(results.first['doctor_id'].to_i).to eq doctor1.id
    expect(results.first['specialty_id'].to_i).to eq specialty1.id
  end

  it 'adds an insurance to a doctor' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    insurance1 = Insurance.new({'name' => 'Blue Cross'})
    insurance1.save
    doctor1.add_insurance(insurance1)
    results = DB.exec('SELECT * FROM doctor_insurance;')
    expect(results.first['doctor_id'].to_i).to eq doctor1.id
    expect(results.first['insurance_id'].to_i).to eq insurance1.id
  end

  it 'lists all the doctors of the same specialty' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    specialty1 = Specialty.new({'specialty' => 'Optometry'})
    specialty1.save
    doctor1.add_spec(specialty1)
    doctor2 = Doctor.new({'name' => 'Dr. Smith'})
    doctor2.save
    doctor2.add_spec(specialty1)
    Doctor.specialty_seek(specialty1)
    expect(Doctor.specialty_seek(specialty1)).to eq [doctor1.name, doctor2.name]
  end

  it 'lists all the doctors who take the same insurance' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    insurance1 = Insurance.new({'insurance'=>'Blue Cross'})
    insurance1.save
    doctor1.add_insurance(insurance1)
    doctor2 = Doctor.new({'name' => 'Dr. Smith'})
    doctor2.save
    doctor2.add_insurance(insurance1)
    Doctor.insurance_seek(insurance1)
    expect(Doctor.insurance_seek(insurance1)).to eq [doctor1.name, doctor2.name]
  end

  it 'lists all the patients a specific doctor sees' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.save
    patient2 = Patient.new({'name'=>'Jane Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient2.save
    doctor1.add_patient(patient1)
    doctor1.add_patient(patient2)
    Doctor.patient_seek(doctor1)
    expect(Doctor.patient_seek(doctor1)).to eq [patient1.name, patient2.name]
  end

  it 'deletes a doctor from the system' do
    doctor1 = Doctor.new({'name' => 'Dr. Wang'})
    doctor1.save
    doctor2 = Doctor.new({'name' => 'Dr. Smith'})
    doctor2.save
    patient1 = Patient.new({'name'=>'Joe Smith', 'birthdate' => '1980-01-01', 'insurance'=>'Blue Cross'})
    patient1.save
    doctor1.add_patient(patient1)
    doctor1.delete(doctor1)
    expect(Doctor.all).to eq [doctor2]
  end
end

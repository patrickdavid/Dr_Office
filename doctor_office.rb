require './lib/doctor'
require './lib/patient'
require 'pg'
DB = PG.connect({:dbname => 'doctor_test'})

def main_menu

  loop do
    puts "Press 'd' to add a doctor"
    puts "Press 'l' to list doctors with their specialties"
    puts "Press 'p' to add a patient"
    puts "Press 'q' to list all patients with their birthdays"
    puts "Press 'a' to assign a patient to a doctor"
    puts "Press 's' to list doctors by Specialty"
    puts "Press 'i' for insurance info"
    puts "Press 'x' to exit"

  user_input = gets.chomp.downcase

  case user_input
    when 'd'
      add_doctor
    when 'p'
      add_patient
    when 'a'
      assign_patient
    when 'q'
      list_patients
    when 'i'
      list_insurance_info
    when 'clear'
      DB.exec("DELETE FROM doctors *;")
      DB.exec("DELETE FROM patients *;")
    when 'l'
      list_doctors
    when 's'
      list_docs_special
    when 'x'
      puts "Goodbye"
      exit
    else
      puts "please enter a valid option"
    end
  end
end


def add_doctor
  puts "Please enter a doctor's name"
  doctor_name = gets.chomp
  new_doctor = Doctor.new({'name' => doctor_name})
  new_doctor.save
  # add_insurance_doc(new_doctor.id)
  puts "Doctor Added"
end

def list_doctors
  Doctor.all.each do |info|
    puts "#{info.name}" + " id: #{info.id}"
  end
end

def add_patient
  list_doctors
  puts "Please enter a patient's name"
  patient_name = gets.chomp
  puts "Please enter a patient's birthday, yyyy-mm-dd"
  patient_birthday= gets.chomp
  puts "Select a doctor ID"
  response = gets.chomp
  new_patient = Patient.new({'name' => patient_name, 'birthdate'=> patient_birthday, 'doctor_id'=>response})
  new_patient.save
  add_insurance(new_patient.doctor_id, new_patient.name)
  puts "patient Added"
end

# def add_insurance(doc_id, pat_name)
#   puts "Input Insurance Provider"
#   company = gets.chomp
#   DB.exec("INSERT INTO insurance (company_name, doctor_id, patient_name) VALUES ('#{company}', #{doc_id}, '#{pat_name}');")
# end

def add_insurance_doc(doc_id)
  puts "Input Insurance Provider"
  company = gets.chomp
  DB.exec("INSERT INTO insurance (company_name, doctor_id) VALUES ('#{company}', #{doc_id});")
end

def list_patients
  Patient.all.each do |info|
    puts "#{info.name}" + ' Birthday: ' + "#{info.birthdate}" + ' Doctor ID: ' + "#{info.doctor_id}"
  end
end

def list_insurance_info
  puts "for whom do you need insurance info (1: patient, 2: doctor)?"
  answ = gets.chomp.to_i
  if answ == 1
    puts 'what is the patient name?'
    patient_name = gets.chomp
    insurance_patient(patient_name)
  elsif answ == 2
    puts "which doctor would you like info for (ID)"
    list_doctors
    doctor_id = gets.chomp
    insurance_doctor(doctor_id)
  else
    puts 'please enter a valid option'
    main_menu
  end
end

def insurance_patient(pat_name)
  test = DB.exec("SELECT * FROM insurance WHERE (patient_name)= '#{pat_name}';")
  test.each do |hash|
    puts hash
  end
end

def insurance_doctor(name)
  test = DB.exec("SELECT * FROM insurance WHERE (doctor_id)= '#{name}';")
  test.each do |hash|
    puts hash
  end
end

def list_docs_special
  puts "Enter needed specialty"
  needed_specialty = gets.chomp
  Doctor.all.each do |doctor|
    if needed_specialty == doctor.specialty
      puts doctor.name
    end
  end
end

def assign_patient

end

main_menu

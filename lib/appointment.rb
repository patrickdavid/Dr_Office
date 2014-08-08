class Appointment
  attr_reader :id, :date, :patient_id, :doctor_id

  def initialize(attributes)
    @date = attributes['date']
    @id = attributes['id']
    @patient_id = attributes['patient_id'].to_i
    @doctor_id = attributes['doctor_id'].to_i
  end

  def save
    results = DB.exec("INSERT INTO appointments (date, doctor_id, patient_id) VALUES('#{@date}', '#{@doctor_id}', '#{@patient_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_appt)
    self.id == another_appt.id && self.patient_id == another_appt.patient_id && self.doctor_id == another_appt.doctor_id
  end

  def self.all
    results = DB.exec("SELECT * FROM appointments;")
    appointments = []
    results.each do |result|
      id = result['id'].to_i
      doctor_id = result['doctor_id'].to_i
      patient_id = result['patient_id'].to_i
      date = result['date']
      appointments << Appointment.new({'doctor_id'=> doctor_id, 'patient_id' =>patient_id, 'date'=> date, 'id'=>id})
    end
    appointments
  end

  def add_patient(input_patient)
    results = DB.exec("INSERT INTO appointments (patient_id) VALUES (#{input_patient.id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def add_doctor(input_doctor)
    results = DB.exec("UPDATE appointments SET doctor_id = #{input_doctor.id} WHERE id = @id;")
  end

  def add_date(input_date)
    results = DB.exec("UPDATE appointments SET date = '#{input_date}' WHERE id = @id;")
  end

  def self.show_appt(doctor_name)
    app_array =[]
    Appointment.all.each do |appointment|
      if appointment.doctor_id == doctor_name.id
        app_array << appointment
      end
    end
    app_array
  end


  # def ==(another_insurance)
  #   self.name == another_insurance.name
  # end

  # def self.delete(input_appointment)
  #   Appointment.all.each do |insurance|
  #     if input_insurance == insurance
  #       DB.exec("DELETE FROM insurance WHERE id = #{input_insurance.id};")
  #     end
  #   end
  # end
  def add_appt(input_appointment)
    DB.exec("INSERT INTO appointments (doctor_id, time, date, patient_id) VALUES (#{date}, );")
  end

end

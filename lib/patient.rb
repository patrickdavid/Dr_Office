class Patient

  attr_reader :name, :birthdate, :insurance, :id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate= attributes['birthdate']
    @insurance = attributes['insurance']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      id = result['id']
      birthdate = result['birthdate']
      insurance = result['insurance']
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'insurance' => insurance, 'id' =>id})
    end
    patients
  end

  def save
    results = DB.exec("INSERT INTO patients (name, birthdate, insurance) VALUES ('#{@name}', '#{@birthdate}', '#{@insurance}')RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_patient)
    self.name == another_patient.name
  end

    def Patient.assign_patient(user_doctor_choice)
    results = DB.exec("SELECT * FROM doctor_patient WHERE id = #{user_doctor_choice};")
    patient_ids = []
    results.each do |result|
      patient_ids << result
    end
    patient_ids
  end

  def self.delete(input_patient)
    Patient.all.each do |patient|
      if input_patient == patient
        DB.exec("DELETE FROM patients WHERE id = #{input_patient.id};")
      end
    end
  end


end

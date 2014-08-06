class Patient

  attr_reader :name, :birthdate, :doctor_id, :insurance, :patient_id

  def initialize(attributes)
    @name = attributes['name']
    @birthdate= attributes['birthdate']
    @doctor_id = attributes['doctor_id']
    @insurance = attributes['insurance']
    @patient_id = attributes['patient_id']
  end

  def self.all
    results = DB.exec("SELECT * FROM patients;")
    patients = []
    results.each do |result|
      name = result['name']
      id = result['name']
      birthdate = result['birthdate']
      doctor_id = result['doctor_id']
      patients << Patient.new({'name' => name, 'birthdate' => birthdate, 'doctor_id' => doctor_id})
    end
    patients
  end

  def save
    DB.exec("INSERT INTO patients (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id});")
  end

  def == (another_patient)
    self.name == another_patient.name
  end


end

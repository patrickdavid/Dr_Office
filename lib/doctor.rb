class Doctor

  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    @doctors = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      @doctors << Doctor.new({'name' => name, 'id' => id})
    end
    @doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_doctor)
    self.name == another_doctor.name
  end

  def add_patient(patient)
    DB.exec("INSERT INTO doctor_patient (doctor_id, patient_id) VALUES (#{@id}, #{patient.id});")
  end

  def add_spec(specialty)
    DB.exec("INSERT INTO doctor_specialty (doctor_id, specialty_id) VALUES (#{@id}, #{specialty.id});")
  end

  def add_insurance(insurance)
    DB.exec("INSERT INTO doctor_insurance (doctor_id, insurance_id) VALUES (#{@id}, #{insurance.id});")
  end
end

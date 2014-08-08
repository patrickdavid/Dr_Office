require'./lib/specialty.rb'
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

  def self.specialty_seek(specialty)
    puts specialty
    specialty_docs = []
    doctor_name = []
    Specialty.all.each do |index|
      # binding.pry
      if specialty.id == index.id.to_i
        spec_ids = DB.exec("SELECT * FROM doctor_specialty WHERE specialty_id = '#{specialty.id}';")
        # binding.pry
        spec_ids.each do |spec|
          specialty_docs << spec['doctor_id'].to_i
          # specialty_id = spec['specialty_id'].to_i
          # if specialty.id == specialty_id
            # specialty_docs << doctor_id
            # binding.pry
        end
        Doctor.all.each do |doctor|
          if specialty_docs.include?(doctor.id)
            doctor_name << doctor.name
          end
        end
      end
    end
    doctor_name
  end

  def self.insurance_seek(input_insurance)
    insurance_docs = []
    doctor_name = []
    Insurance.all.each do |insurance|
      if input_insurance.id == insurance.id.to_i
        ins_id = DB.exec("SELECT * FROM doctor_insurance WHERE insurance_id = '#{insurance.id}';")
        ins_id.each do |ins|
          insurance_docs << ins['doctor_id'].to_i
        end
        Doctor.all.each do |doctor|
          if insurance_docs.include?(doctor.id)
            doctor_name << doctor.name
          end
        end
      end
    end
    doctor_name
  end

  def add_spec(specialty)
    DB.exec("INSERT INTO doctor_specialty (doctor_id, specialty_id) VALUES (#{@id}, #{specialty.id});")
  end

  def add_insurance(insurance)
    DB.exec("INSERT INTO doctor_insurance (doctor_id, insurance_id) VALUES (#{@id}, #{insurance.id});")
  end
end

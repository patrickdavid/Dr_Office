class Doctor

  attr_reader :name, :specialty, :id

  def initialize(attributes)
    @name = attributes['name']
    @specialty = attributes['specialty']
    @id = attributes['id']

  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    @doctors = []
    results.each do |result|
      name = result['name']
      specialty = result['specialty']
      id = result['id'].to_i
      @doctors << Doctor.new({'name' => name, 'specialty' => specialty, 'id' => id})
    end
    @doctors
  end

  def save
    results = DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i
    spec_results = DB.exec("INSERT INTO specialties (id, specialty) VALUES (#{@id}, '#{@specialty}');")
  end

  def == (another_doctor)
    self.name == another_doctor.name
  end


  def Doctor.specialty_doctors(needed_specialty)
    doc_list = []
    @doctors.each do |doctor|
      p doctor.name
      if needed_specialty == doctor.specialty
        doc_list << doctor.name
      end
    end
    p doc_list
  end
end

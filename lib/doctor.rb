class Doctor

  attr_reader :name, :specialty

  def initialize(attributes)
    @name = attributes['name']
    @specialty = attributes['specialty']
  end

  def self.all
    results = DB.exec("SELECT * FROM doctors;")
    doctors = []
    results.each do |result|
      name = result['name']
      specialty = result['specialty']
      doctors << Doctor.new({'name' => name, 'specialty' => specialty})
    end
    doctors
  end

  def save
    DB.exec("INSERT INTO doctors (name, specialty) VALUES ('#{@name}', '#{@specialty}');")
  end

  def == (another_doctor)
    self.name == another_doctor.name
  end
end

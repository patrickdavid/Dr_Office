
class Specialty
  attr_reader :specialty, :id

  def initialize(attributes)
    @specialty = attributes['specialty']
    @id = attributes['id']
  end

  def save
    # DB.exec("UPDATE doctor_specialty SET specialty_id = #{@id} WHERE doctor_id = ")
    results = DB.exec("INSERT INTO specialties (specialty) VALUES('#{@specialty}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  # def save_specialties
  #   results = DB.exec("INSERT INTO doctor_specialty(specialty_id) VALUES('#{@id}');")
  # end

  def self.all
    results = DB.exec("SELECT * FROM specialties;")
    specialties = []
    results.each do |result|
      id = result['id']
      specialty = result['specialty']
      specialties << Specialty.new({'specialty' => specialty, 'id' => id})
    end
    specialties
  end

  def ==(another_specialty)
    self.specialty == another_specialty.specialty
  end

  def self.delete(input_specialty)
    Specialty.all.each do |specialty|
      if input_specialty == specialty
        DB.exec("DELETE FROM specialties WHERE id = #{input_specialty.id};")
      end
    end
  end
end

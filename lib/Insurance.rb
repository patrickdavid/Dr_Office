class Insurance
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def save
    results = DB.exec("INSERT INTO insurance (company_name) VALUES('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec("SELECT * FROM insurance;")
    insurances = []
    results.each do |result|
      id = result['id']
      insurance = result['name']
      insurances << Insurance.new({'company_name' =>insurance, 'id' => id})
    end
    insurances
  end

    def ==(another_insurance)
    self.name == another_insurance.name
  end
end

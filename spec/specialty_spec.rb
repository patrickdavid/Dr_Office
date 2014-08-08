require 'spec_helper'

describe 'Specialty' do
  it "saves a sepcialty" do
    new_specialty = Specialty.new({'specialty'=>'Podiatry'})
    new_specialty.save
    expect(Specialty.all).to eq [new_specialty]
  end

  it 'deletes a specialty from the system' do
    new_specialty = Specialty.new({'specialty'=>'Podiatry'})
    new_specialty.save
    new_specialty1 = Specialty.new({'specialty'=>'Surgery'})
    new_specialty1.save
    Specialty.delete(new_specialty1)
    expect(Specialty.all).to eq [new_specialty]
  end
end

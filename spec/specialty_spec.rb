require 'spec_helper'

describe 'Specialty' do
  it "saves a sepcialty" do
    new_specialty = Specialty.new({'specialty'=>'Podiatry'})
    new_specialty.save
    expect(Specialty.all).to eq [new_specialty]
  end
end

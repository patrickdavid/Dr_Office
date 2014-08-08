require 'spec_helper'

describe 'Insurance' do
  it'initializes the insurance class with a name' do
    insurance1 = Insurance.new({'name'=>'Blue Cross'})
    insurance1.should be_an_instance_of Insurance
  end


  it "saves an insurance" do
    insurance1 = Insurance.new({'insurance'=>'Blue Cross'})
    insurance1.save
    expect(Insurance.all).to eq [insurance1]
  end

  it 'deletes an insurance from the system' do
    insurance1 = Insurance.new({'insurance'=>'Blue Cross'})
    insurance1.save
    insurance2 = Insurance.new({'insurance'=>'Blue Shield'})
    insurance2.save
    Insurance.delete(insurance1)
    expect(Insurance.all).to eq [insurance2]
  end


end

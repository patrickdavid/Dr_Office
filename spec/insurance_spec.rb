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
end

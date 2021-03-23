require 'rails_helper'

RSpec.describe Strain, type: :model do
  
  subject { 
    described_class.new(
                name: 'Nombre',
                created_at: '23-03-2021',
                updated_at: '23-03-2021'

    )
  }

  it "name cant be blank" do
    subject.name = ""    
    expect(subject).to_not be_valid 
  end

  it "name cant be nil" do
    subject.name = nil    
    expect(subject).to_not be_valid 
  end

  it "name cant be blank" do
    subject.name = "Carmenere"    
    expect(subject).to be_valid 
  end

end

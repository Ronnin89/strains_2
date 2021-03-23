require 'rails_helper'

RSpec.describe "Wines", type: :request do
  
  it 'access to wine index' do
    get '/wines'

    expect(response).to render_template(:index) 
  end
  
  it 'access to wine edit' do
    get '/wines'

    expect(response).to render_template(:edit) 
  end

  it 'get almost one wine' do
    Wine.create(name: 'Trama')
    @wine = Wine.all

    expect(@wine.count).to_not equal(0)
  end
end

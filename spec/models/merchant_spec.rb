require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  before(:each) do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    @jori = Order.create!(name: "Jori", address: "12 Market St", city: "Denver", state: "CO", zipcode: "80021")
    @sejin = Order.create!(name: "Sejin", address: "12 Market St", city: "Las Vegas", state: "NV", zipcode: "80021")
    @jori.items << @ogre
    @sejin.items << @hippo
    @sejin.items << @ogre
  end

  # describe "validations" do
  #   it { should validate_presence_of :name }
  #   it { should validate_presence_of :address }
  #   it { should validate_presence_of :city }
  #   it { should validate_presence_of :state }
  #   it { should validate_presence_of :zipcode }
  # end

  describe '#merchant_orders' do
    it "should return an array of merchant ids within an order" do
      expect(@megan.merchant_orders.uniq).to eq([@megan.id])
    end
  end

  describe '#average_price' do
    it "should return average price of a merchant's items" do
      expect(@megan.average_price.to_f).to eq(35.0)
    end
  end

  describe '#cities' do
    it "should return an array of distinct cities from active orders" do
      expect(@megan.cities).to eq(["Denver", "Las Vegas"])
    end
  end
end

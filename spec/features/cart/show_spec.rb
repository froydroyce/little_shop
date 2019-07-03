require 'rails_helper'

RSpec.describe 'Cart Show Page' do
  describe "When I have added items to my cart and I visit my cart" do
    before(:each) do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
    end
    it 'I see all items added to my cart' do
      cart = Cart.new(nil)

      visit "/items/#{@ogre.id}"
      click_button "Add to Cart"

      visit "/items/#{@ogre.id}"
      click_button "Add to Cart"

      # visit "/items/#{@giant.id}"
      # click_button "Add to Cart"
      # save_and_open_page
      click_on "Cart(2)"

      expect(current_path).to eq('/cart')
      expect(page).to have_content(@ogre.name)
      # expect(page).to have_content(@ogre.image)
      expect(page).to have_content(@ogre.merchant.name)
      expect(page).to have_content(@ogre.price)
      expect(page).to have_content(cart.item_count(@ogre))
      expect(page).to have_content("$40.0")
      # expect(page).to have_content(cart.item_count(@ogre) * @ogre.price)

      #
      # expect(page).to have_content(@giant.name)
      # # expect(page).to have_content(@giant.image)
      # expect(page).to have_content(@giant.merchant.name)
      # expect(page).to have_content(@giant.price)
      # expect(page).to have_content(cart.item_count(@giant))
      # # expect(page).to have_content(cart.item_count(@giant) * @giant.price)
      # 
      # expect(page).to have_content("$70.00")
    end
  end
end
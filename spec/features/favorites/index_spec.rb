RSpec.describe "as a visitor", type: :feature do
  before :each do
    @shelter = Shelter.create(name: "Braun Farm")
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id, status: "adoptable" )

  end

  describe 'view favorites index' do
    it 'can see favorited pets if there are pets' do

      visit "/pets/#{@pet1.id}"

      click_on 'Add pet to favorites'
      expect(current_path).to eq("/pets/#{@pet1.id}")

      visit "/favorites"

      expect(page).to have_selector(:link_or_button, "Noodle")
      expect(page).to have_xpath("//img[@src = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg' and @alt='photo of pet']")

      within("#main-nav") do
        expect(page).to have_content('Favorites (1)')
      end
    end

    it 'sees no pets message if there are no pets' do

      visit "/favorites"
      expect(page).to have_content("You have no favorite pets.")

      within("#main-nav") do
        expect(page).to have_content('Favorites')
      end
    end

    it 'each pet has a link to remove from favorites, which redirects to /favorites' do

      visit "/pets/#{@pet1.id}"
      click_on 'Add pet to favorites'
      visit "/favorites"

      within(".pet-card") do
        expect(page).to have_link("Remove")
        click_on "Remove"
      end

      expect(current_path).to eq("/favorites")
      expect(page).to_not have_content("Noodle")
    end
  end
end

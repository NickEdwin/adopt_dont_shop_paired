RSpec.describe "as a visitor", type: :feature do
  before :each do
    @shelter = Shelter.create(name: "Braun Farm")
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id, status: "adoptable" )
    @pet2 = Pet.create(name: 'Yoda', approx_age: 4, sex: "female", description: "This is a cat.", image: "https://static.toiimg.com/photo/msid-67586673/67586673.jpg?3918697", shelter_id: @shelter.id, status: "adoptable" )

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

    it 'has a link to remove all favorite pets at once' do

      visit "/pets/#{@pet1.id}"
      click_on 'Add pet to favorites'

      visit "/pets/#{@pet2.id}"
      click_on 'Add pet to favorites'

      visit "/favorites"

      click_on 'Remove All Pets'

      expect(current_path).to eq("/favorites")
      expect(page).to_not have_content("Noodle")
      expect(page).to_not have_content("Yoda")
    end

    it 'shows option to adopt my favorited pets' do

      visit "/pets/#{@pet1.id}"
      click_on 'Add pet to favorites'
      visit "/pets/#{@pet2.id}"
      click_on 'Add pet to favorites'
      visit '/favorites'

      expect(page).to have_link("Adopt Favorited Pets")

      click_on 'Adopt Favorited Pets'

      expect(current_path).to eq("/applications/new")

      expect(page).to have_content("Noodle")
      expect(page).to have_content("Yoda")
      
        # Still cant get this!
        #I think we have to assign a CSS label boxes
        #And use that ref id as the label for clicking?

      page.check('1')

      fill_in 'Name', with: 'Timmy'
      fill_in 'Address', with: '123 Street St.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80218'
      fill_in 'Phone Number', with: '303-123-4567'
      fill_in :reason, with: 'Because I love animals!'

      click_on 'Submit Application'

      expect(page).to have_content("Your application has been submitted.")

      expect(current_path).to eq("/favorites")

      expect(page).to_not have_content("#{@pet1.name}")
      expect(page).to_not have_content("#{@pet2.name}")
      expect(page).to have_content("You have no favorite pets.")
    end
  end
end

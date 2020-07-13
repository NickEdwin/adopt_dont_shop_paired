RSpec.describe "as a visitor", type: :feature do
  before :each do
    @shelter = Shelter.create(name: "Braun Farm")
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id, status: "adoptable" )
    @application1 = Application.create(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')
    ApplicationPet.create(application_id: @application1.id, pet_id: @pet1.id)
  end

  describe 'view applications show' do
    it 'can see applicants and the pets they applied for' do

      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Timmy')
      expect(page).to have_content('123 Street St.')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('80218')
      expect(page).to have_content('303-123-4567')
      expect(page).to have_content('Adoption Reason: Because I love animals!')

      expect(page).to have_selector(:link_or_button, 'Noodle')
      click_on 'Noodle'
      expect(current_path).to eq("/pets/#{@pet1.id}")

    end

    it 'Can display link option to approve application' do

      visit "/applications/#{@application1.id}"

      expect(page).to have_selector(:link_or_button, 'Click here to approve application for Noodle')

      click_on 'Click here to approve application for Noodle'

      expect(current_path).to eq("/pets/#{@pet1.id}")
    end
  end
end

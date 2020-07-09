RSpec.describe 'as a visitor' do
  before :each do
    @shelter = Shelter.create(name: "Braun Farm")
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id, status: "adoptable" )
  end

  it 'when I visit /pets/:id I see the pet with that id including image, name, description, approximate age, sex, adoptable/pending adoption status' do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Noodle")
    expect(page).to have_content("description of noodle")
    expect(page).to have_content("3")
    expect(page).to have_content("male")
    expect(page).to have_xpath("//img[@src = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg' and @alt='photo of pet']")

    expect(page).to have_content("adoptable")

    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_selector(:link_or_button, 'Delete')
  end

  it 'when I visit /pets/:id I can favorite a pet' do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_selector(:link_or_button, 'Add pet to favorites')

    click_on "Add pet to favorites"

    expect(page).to have_content("Pet has been added to favorites list.")
  end

  it 'Favorites link changes to \'remove pet from favorites\'' do

    visit "/pets/#{@pet1.id}"

    expect(page).to have_selector(:link_or_button, 'Add pet to favorites')

    click_on "Add pet to favorites"
    expect(page).to have_content("Pet has been added to favorites list.")

    expect(page).to have_selector(:link_or_button, 'Remove pet from favorites')
  end

end

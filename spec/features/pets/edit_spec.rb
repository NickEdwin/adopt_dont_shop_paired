RSpec.describe "as a visitor", type: :feature do
  before :each do
    @shelter = Shelter.create!({name: "Braun Farm", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    @pet1 = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id)
  end

  it "uses 'update pet' link on pet show page to edit image, name, description, approx age, and sex with a form" do

    visit "/pets/#{@pet1.id}"
    click_on "Update"
    expect(current_path).to eq("/pets/#{@pet1.id}/edit")

    fill_in('name', with: 'Noodle Mendez')
    click_on('Save')
    expect(current_path).to eq("/pets/#{@pet1.id}")
    expect(page).to have_content('Noodle Mendez')
  end

  it 'shows flash message when user doesn\'t fill all fields' do

    visit "/pets/#{@pet1.id}"
    click_on "Update"

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")

    fill_in('name', with: nil)
    click_on('Save')

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    expect(page).to have_content('Name can\'t be blank')
  end
end

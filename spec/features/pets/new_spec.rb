RSpec.describe 'as a visitor' do
  before :each do
    @shelter = Shelter.create!({name: "Braun Farm", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
  end

  it 'when I visit shelter/pets index, use create pet link to fill in form with pet details and add new pet' do

    visit "/shelters/#{@shelter.id}/pets"
    click_on 'Create Pet'
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    name = "Bella"
    age = 1
    description = "Young and spunky ACD"
    image = "https://upload.wikimedia.org/wikipedia/commons/c/cc/ACD-blue-spud.jpg"
    sex = 'female'

    fill_in :name, with: name
    fill_in :approx_age, with: age
    fill_in :description, with: description
    fill_in :sex, with: sex
    fill_in :image, with: image
    # come back to this and create an upload interface

    click_on 'Save Pet'
    new_pet = Pet.last

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")

    expect(page).to have_content("Bella")
    expect(page).to have_content("Braun Farm")
  end

  it 'cant create new pet with missing name, age, description, sex, or image url' do

    visit "/shelters/#{@shelter.id}/pets"
    click_on 'Create Pet'
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    name = "Bella"
    age = 1
    description = "Young and spunky ACD"
    image = "https://upload.wikimedia.org/wikipedia/commons/c/cc/ACD-blue-spud.jpg"
    sex = 'female'

    fill_in :approx_age, with: age
    fill_in :description, with: description
    fill_in :image, with: image
    # come back to this and create an upload interface

    click_on 'Save Pet'

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")
    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Sex can\'t be blank')
  end
end

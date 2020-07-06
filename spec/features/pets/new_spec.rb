RSpec.describe 'as a visitor' do
  it 'when I visit shelter/pets index, use create pet link to fill in form with pet details and add new pet' do

    shelter = Shelter.create!(name: "Braun Farm")

    visit "/shelters/#{shelter.id}/pets"
    click_on 'Create Pet'
    expect(current_path).to eq("/shelters/#{shelter.id}/pets/new")

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

    expect(current_path).to eq("/shelters/#{shelter.id}/pets")

    expect(page).to have_content("Bella")
    expect(page).to have_content("Braun Farm")

  end
end

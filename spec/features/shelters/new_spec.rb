RSpec.describe "create new shelter", type: :feature do
  it "uses 'new shelter' link to visit /shelters/new, fill out form, save new shelter, and redirect to index" do

    visit "/shelters"
    click_link "New Shelter"
    expect(current_path).to eq("/shelters/new")

    fill_in('name', with: 'Shelter 4, new')
    fill_in('address', with: '4242 Granada Blvd.')
    fill_in('city', with: 'Miami')
    fill_in('state', with: 'Florida')
    fill_in('zip', with: 33703)

    click_on('Add Shelter')
    expect(current_path).to eq("/shelters")
    expect(page).to have_content('Shelter 4, new')
  end

  it 'cant create new shelter with missing information' do

    visit "/shelters"
    click_link "New Shelter"
    expect(current_path).to eq("/shelters/new")

    #By filling in no information we test for that things can't be missing

    click_on('Add Shelter')
    expect(current_path).to eq("/shelters/new")
    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Address can\'t be blank')
    expect(page).to have_content('City can\'t be blank')
    expect(page).to have_content('State can\'t be blank')
    expect(page).to have_content('Zip can\'t be blank')
  end
end

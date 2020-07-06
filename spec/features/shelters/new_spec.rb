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
end

RSpec.describe "update existing shelter", type: :feature do
  before :each do
    @shelter1 = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
  end

  it "uses 'update shelter' link to visit /shelters/id/edit, fill out form, and update shelter" do

    visit "/shelters/#{@shelter1.id}"
    click_on "Update"
    expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

    fill_in('name', with: 'Shelter 1b')
    fill_in('address', with: '1234 NW 10th St.')
    fill_in('city', with: 'Gainesville')
    fill_in('state', with: 'FL')
    fill_in('zip', with: 32609)

    click_on('Save')
    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    page.has_content?('Shelter 1b')
  end

    it "cannot edit a shelter and leave fields blank" do

      visit "/shelters/#{@shelter1.id}"
      click_on "Update"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      fill_in('name', with: nil)
      fill_in('address', with: nil)
      fill_in('city', with: nil)
      fill_in('state', with: nil)
      fill_in('zip', with: nil)

      click_on('Save')

      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Address can\'t be blank')
      expect(page).to have_content('City can\'t be blank')
      expect(page).to have_content('State can\'t be blank')
      expect(page).to have_content('Zip can\'t be blank')
  end
end

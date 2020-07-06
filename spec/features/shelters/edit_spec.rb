RSpec.describe "update existing shelter", type: :feature do
  it "uses 'update shelter' link to visit /shelters/id/edit, fill out form, and update shelter" do

    shelter1 = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters/#{shelter1.id}"
    click_on "Update"
    expect(current_path).to eq("/shelters/#{shelter1.id}/edit")

    fill_in('name', with: 'Shelter 1b')
    click_on('Save')
    expect(current_path).to eq("/shelters/#{shelter1.id}")
    page.has_content?('Shelter 1b')
  end
end

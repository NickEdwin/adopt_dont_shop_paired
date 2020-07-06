RSpec.describe "visit /shelters/id", type: :feature do
  it "show given shelter's name, address, city, state, zip" do
    shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters"
    click_link(shelter1.name)

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter1.address)
    expect(page).to have_content(shelter1.city)
    expect(page).to have_content(shelter1.state)
    expect(page).to have_content(shelter1.zip)

    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_selector(:link_or_button, 'Delete')
  end
end

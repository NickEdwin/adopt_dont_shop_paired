# As a visitor
# When I visit '/shelters'
# Then I see the name of each shelter in the system

RSpec.describe "visit /shelters index, see all", type: :feature do
  it "list of shelter names" do
    shelter1 = Shelter.create(name: "Shelter 1")
    shelter2 = Shelter.create(name: "Shelter 2")

    visit "/shelters"

    expect(page).to have_content(shelter1.name)
    expect(page).to have_content(shelter2.name)
    expect(page).to have_link(shelter1.name)
    expect(page).to have_link(shelter1.name)
    expect(page).to have_selector(:link_or_button, 'Edit')
    expect(page).to have_selector(:link_or_button, 'Delete')
  end
end

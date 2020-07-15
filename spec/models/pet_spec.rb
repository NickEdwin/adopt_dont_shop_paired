RSpec.describe Pet do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :approx_age }
    it { should validate_presence_of :sex }
    it { should validate_presence_of :shelter }
  end

  describe 'relationships' do
    it { should belong_to :shelter }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:applications).through(:application_pets) }
  end

  describe 'helper methods' do
    it 'checks pets status using #status' do
      shelter = Shelter.create!(name: "Braun Farm", address: '4242 Farm Rd.', city: 'Eustis', state: 'FL', zip: 33790)

      pet = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id)

      expect(pet.status).to eq(:adoptable)

      app1 = Application.create!(name: 'New Application', address: '1234 Tests', city: 'Mayo', state: 'FL', zip: 33499, phone_number: '333444999', reason: 'because')
      ApplicationPet.create(application_id: app1.id, pet_id: pet.id)

      app1.approve_for(pet)
      expect(pet.status).to eq(:pending)
    end
  end
end

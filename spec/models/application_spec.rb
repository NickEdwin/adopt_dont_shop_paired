RSpec.describe Application do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :reason }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe '#approve_app, #unapprove' do
    it 'can change approved status from the default of false, to true' do
      shelter = Shelter.create(name: "Braun Farm", address: '4242 Farm Rd.', city: 'Eustis', state: 'FL', zip: 33790)

      pet = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id, status: 'adoptable' )

      app1 = Application.create(name: 'New Application', address: '1234 Tests', city: 'Mayo', state: 'FL', zip: 33499)
      app2 = Application.create(name: 'Newest Application', address: '1234 Specs', city: 'Bronson', state: 'FL', zip: 33499)

      ap = ApplicationPet.create(application_id: app1.id, pet_id: pet.id)
      ap2 = ApplicationPet.create(application_id: app2.id, pet_id: pet.id)

      expect(ap.approve).to eq(false)
      ap.approve_app
      expect(ap.approve).to eq(true)
      ap.unapprove
      expect(ap.approve).to eq(false)
      ap.toggle_status
      expect(ap.approve).to eq(true)
      ap.toggle_status
      expect(ap.approve).to eq(false)
    end
  end

  describe '#can_be_approved?' do
    xit 'checks whether it can be approved for given pet by checking if given pet already has another approved application' do

      shelter = Shelter.create(name: "Braun Farm", address: '4242 Farm Rd.', city: 'Eustis', state: 'FL', zip: 33790)

      pet = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id, status: 'adoptable' )

      app1 = Application.create(name: 'New Application', address: '1234 Tests', city: 'Mayo', state: 'FL', zip: 33499)
      app2 = Application.create(name: 'Newest Application', address: '1234 Specs', city: 'Bronson', state: 'FL', zip: 33499)

      ap = ApplicationPet.create(application_id: app1.id, pet_id: pet.id)
      ap2 = ApplicationPet.create(application_id: app2.id, pet_id: pet.id)


    end
  end
end

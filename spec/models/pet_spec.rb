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
end

class Favorite
  attr_reader :pets

  def initialize(pet_list)
    @pets = pet_list || []
  end

  def add_pet(id)
    @pets << id
  end

  def remove_pet(id)
    @pets.delete(id)
  end

  def toggle(id)
    if @pets.include?(id)
      remove_pet(id)
    else
      add_pet(id)
    end
  end
  
end

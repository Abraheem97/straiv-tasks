class Navigation < ActiveRecord::Base
  before_create :set_position
  before_destroy :reorder_positions

  def set_position
    highest_position = Navigation.maximum(:position)
    self.position = highest_position + 1
  end

  def reorder_positions
    Navigation.where("position > ?", self.position).update_all("position = position - 1")
  end
end

class Navigation < ActiveRecord::Base
  before_create :set_position
  after_destroy :reorder_positions

  def set_position
    highest_position = Navigation.maximum(:position)
    self.position = highest_position ? highest_position + 1 : 1
  end

  def reorder_positions
    Navigation.where("position > ?", self.position).find_in_batches do |nav_batch|
      nav_batch.each do |nav|
        nav.update_column(:position, nav.position - 1)
      end
    end
end

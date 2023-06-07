# frozen_string_literal: true

class Navigation < ActiveRecord::Base
  before_create :assign_position
  after_destroy :reorder_positions

  def assign_position
    self.position = Navigation.maximum(:position).to_i + 1
  end

  def reorder_positions
    Navigation.where('position > ?', position).update_all('position = position - 1')
  end
end

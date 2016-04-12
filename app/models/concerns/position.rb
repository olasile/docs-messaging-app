module Position
  extend ActiveSupport::Concern

  included do
    scope :by_position, -> { order('position') }
  end

  module ClassMethods
    def update_positions(ids)
      ids.each_with_index do |id, index|
        model = self.where(id: id).first
        model.update(position: index) if model.present?
      end
    end
  end
end

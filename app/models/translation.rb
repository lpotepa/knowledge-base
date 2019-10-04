# frozen_string_literal: true

class Translation < ApplicationRecord
  enum status: { pending: 'pending', completed: 'completed', error: 'error' }

  belongs_to :translatable, polymorphic: true,
                            foreign_key: :translatable_id, optional: true
  belongs_to :language

  validates :language_id, uniqueness: { scope: :translatable_id }
end

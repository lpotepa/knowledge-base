# frozen_string_literal: true

class Language < ApplicationRecord
  validates :name, uniqueness: true
  validates :iso, uniqueness: true
end

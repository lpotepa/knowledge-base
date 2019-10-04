# frozen_string_literal: true

module Translatable
  extend ActiveSupport::Concern
  included do
    has_many :translations, dependent: :destroy, foreign_key: :translatable_id
    accepts_nested_attributes_for :translations
  end
end

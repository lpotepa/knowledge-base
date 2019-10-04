# frozen_string_literal: true

class Article < ApplicationRecord
  has_one :question, dependent: :destroy
  has_one :answer, dependent: :destroy

  accepts_nested_attributes_for :question, :answer, update_only: true

  def translations
    question.translations + answer.translations
  end
end

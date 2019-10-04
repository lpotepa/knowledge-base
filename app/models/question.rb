# frozen_string_literal: true

class Question < ApplicationRecord
  include Translatable
  include Contentable

  belongs_to :article, optional: true
end

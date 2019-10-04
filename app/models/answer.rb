# frozen_string_literal: true

class Answer < ApplicationRecord
  include Translatable
  include Contentable

  belongs_to :article, optional: true
end

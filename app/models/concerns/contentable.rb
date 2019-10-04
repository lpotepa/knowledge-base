# frozen_string_literal: true

module Contentable
  extend ActiveSupport::Concern
  included do
    validates :content, presence: true
  end
end

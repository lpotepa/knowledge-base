# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'content is empty' do
    it 'is invalid ' do
      question = Question.new(content: nil)
      expect(question).to be_invalid
    end
  end
end

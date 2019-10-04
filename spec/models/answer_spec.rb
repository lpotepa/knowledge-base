# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  context 'content is empty' do
    it 'is invalid ' do
      answer = Answer.new(content: nil)
      expect(answer).to be_invalid
    end
  end
end

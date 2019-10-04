# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Translation, type: :model do
  context 'There is already a translation with this language and resource' do
    it 'returns a validaiton error when trying to create a duplicate name' do
      question = Question.new(content: 'Abc')
      language = create(:language)
      Translation.create(translatable: question, language: language)
      translation = Translation.create(
        translatable: question,
        language: language
      )
      expect(translation).to be_invalid
    end
  end
end

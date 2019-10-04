# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Language, type: :model do
  context 'There is already a language with such name' do
    it 'returns a validaiton error when trying to create a duplicate name' do
      create(:language)
      language = Language.create(name: 'German', iso: 'abc')
      expect(language).to be_invalid
    end
  end

  context 'There is already a language with such iso' do
    it 'returns a validaiton error when trying to create a duplicate iso' do
      create(:language)
      language = Language.create(name: 'Abcdef', iso: 'de')
      expect(language).to be_invalid
    end
  end
end

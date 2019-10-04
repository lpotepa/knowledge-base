# frozen_string_literal: true

require 'rails_helper'
require 'httparty'
require './spec/support/article.rb'

RSpec.describe MicrosoftTranslator do
  before do
    create(:language)
  end
  context '200 response' do
    it 'returns a processed body' do
      stub_request(
        :any, /api.cognitive.microsofttranslator.com/
      ).to_return(status: 200, body: response_200_body)
      expect(MicrosoftTranslator.new(
        'Good example',
        Language.all.pluck(:iso)
      ).translate).to eq response_200
    end
  end
  context 'non-200 response' do
    it 'return false' do
      stub_request(
        :any, /api.cognitive.microsofttranslator.com/
      ).to_return(status: 403)
      expect(MicrosoftTranslator.new(
        'Good example',
        Language.all.pluck(:iso)
      ).translate).to eq false
    end
  end
end

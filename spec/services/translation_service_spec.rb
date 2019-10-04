# frozen_string_literal: true

require 'rails_helper'
require './spec/support/microsoft_translator.rb'

RSpec.describe TranslationService do
  before do
    create(:language)
  end

  context 'valid article with translations and 200 response' do
    let(:article) { create(:article_with_translations) }
    it 'updates the translations for article resources' do
      allow_any_instance_of(
        MicrosoftTranslator
      ).to receive(:translate) { response_200 }
      TranslationService.new(article).call
      all_translated = article.reload.translations.all? do |translation|
        translation.content == response_200[0]['text']
      end
      expect(all_translated).to eq true
      all_completed = article.reload.translations.all? do |translation|
        translation.status == 'completed'
      end
      expect(all_completed).to eq true
    end
  end

  context 'valid article with translations and other than 200 response' do
    let(:article) { create(:article_with_translations) }
    it 'updates the translations for article resources' do
      allow_any_instance_of(
        MicrosoftTranslator
      ).to receive(:translate) { false }
      TranslationService.new(article).call
      all_translated = article.reload.translations.all? do |translation|
        translation.content == response_200[0]['text']
      end
      expect(all_translated).to eq false
      all_translations_error = article.reload.translations.all? do |translation|
        translation.status == 'error'
      end
      expect(all_translations_error).to eq true
    end
  end
end

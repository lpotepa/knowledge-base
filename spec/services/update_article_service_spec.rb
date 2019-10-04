# frozen_string_literal: true

require 'rails_helper'
require './spec/support/article.rb'
require 'sidekiq/testing'

RSpec.describe UpdateArticleService do
  before do
    create(:language)
    Sidekiq::Testing.fake!
  end
  context 'valid params' do
    let(:article) { create(:article_with_translations) }
    it 'updates a record and sets its translation objects to pending status' do
      UpdateArticleService.new(article, valid_params).call
      all_translations_pending = article.translations.all?(&:pending?)
      expect(all_translations_pending).to eq true
      expect(TranslationWorker.jobs.size).to eq 1
    end
  end
  context 'invalid params' do
    let(:article) { create(:article_with_translations) }
    it 'does not update a record' do
      UpdateArticleService.new(article, invalid_params).call
      all_translations_pending = article.translations.all?(&:pending?)
      expect(all_translations_pending).to eq false
      expect(TranslationWorker.jobs.size).to eq 0
    end
  end
end

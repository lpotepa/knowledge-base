# frozen_string_literal: true

require 'rails_helper'
require './spec/support/article.rb'

RSpec.describe CreateArticleService do
  before do
    create(:language)
    Sidekiq::Testing.fake!
  end
  context 'valid params' do
    subject { CreateArticleService.new(valid_params).call }
    it 'creates a record and translation objects' do
      expect { subject }.to change {
        Article.count
      }.by(1).and change { Translation.count }.by(2)
      expect(TranslationWorker.jobs.size).to eq 1
    end
  end
  context 'invalid params' do
    subject { CreateArticleService.new(invalid_params).call }
    it 'does not create a record and its translation objects' do
      expect { subject }.to change {
        Article.count
      }.by(0).and change { Translation.count }.by(0)
      expect(TranslationWorker.jobs.size).to eq 0
    end
  end
end

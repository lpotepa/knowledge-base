# frozen_string_literal: true

class CreateArticleService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    article = Article.create(params)
    create_translations(article) if article.persisted?
    article
  end

  private

  def create_translations(article)
    languages = Language.all
    languages.each do |language|
      Translation.create!(translatable: article.question,
                          language: language, status: 'pending')
      Translation.create!(translatable: article.answer,
                          language: language, status: 'pending')
    end
    TranslationWorker.perform_async(article.id)
  end
end

# frozen_string_literal: true

class TranslationWorker
  include Sidekiq::Worker

  def perform(article_id)
    article = Article.includes(
      question: [translations: [:language]],
      answer: [translations: [:language]]
    ).find(article_id)
    TranslationService.new(article).call
  end
end

# frozen_string_literal: true

class UpdateArticleService
  attr_reader :article, :params

  def initialize(article, params)
    @article = article
    @params = params
  end

  def call
    article.update(params)
    if article.valid?
      article.translations.each do |translation|
        translation.update!(status: 'pending')
      end
      TranslationWorker.perform_async(article.id)
    end
    article
  end
end

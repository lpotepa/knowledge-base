# frozen_string_literal: true

class ArticleRepresenter
  class << self
    def one(article)
      {
        id: article.id,
        created_at: article.created_at,
        question: ContentRepresenter.one(article.question),
        answer: ContentRepresenter.one(article.answer)
      }
    end

    def collection(articles)
      articles.map do |article|
        one(article)
      end
    end
  end
end

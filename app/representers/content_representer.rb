# frozen_string_literal: true

class ContentRepresenter
  class << self
    def one(resource)
      {
        content: resource.content,
        created_at: resource.created_at,
        translations: TranslationRepresenter.collection(resource.translations)
      }
    end
  end
end

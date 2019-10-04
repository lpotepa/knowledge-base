# frozen_string_literal: true

class TranslationRepresenter
  class << self
    def one(translation)
      {
        content: translation.content,
        language: translation.language,
        status: translation.status
      }
    end

    def collection(translations)
      translations.map do |translation|
        one(translation)
      end
    end
  end
end

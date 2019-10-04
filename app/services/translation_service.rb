# frozen_string_literal: true

class TranslationService
  attr_accessor :article, :languages

  def initialize(article)
    @article = article
    @languages = Language.all.reduce({}) do |acc, el|
      acc[el.iso] = el.id
      acc
    end
  end

  def call
    translate
  end

  private

  def translate
    [article.question, article.answer].each do |resource|
      process_translated_data(resource,
                              translations(resource, languages.keys))
    end
  end

  def translations(resource, languages)
    MicrosoftTranslator.new(resource.content, languages).translate
  end

  def update_translation(data, resource)
    translation = Translation.joins(:language).where(
      translatable_id: resource.id, language_id: @languages[data['to']]
    ).first_or_initialize
    translation.content = data['text']
    translation.status = 'completed'
    translation.save
  end

  def process_translated_data(resource, translated_data)
    if translated_data
      translated_data.each do |data|
        update_translation(data, resource)
      end
    else
      resource.translations.update_all(status: 'error')
    end
  end
end

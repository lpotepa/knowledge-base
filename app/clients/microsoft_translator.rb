# frozen_string_literal: true

class MicrosoftTranslator
  include HTTParty

  base_uri 'https://api.cognitive.microsofttranslator.com'
  format :json

  def initialize(text, languages)
    @languages = languages
    @options = {
      body: ["Text": text].to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Ocp-Apim-Subscription-Key' => api_key
      }
    }
  end

  def translate
    response = self.class.post(
      "/translate?api-version=3.0#{language_params}", @options
    )
    return false unless response.code == 200

    JSON.parse(response.body).first['translations']
  rescue StandardError => e
    puts e.inspect
    false
  end

  private

  def api_key
    return ENV['MICROSOFT_TRANSLATE_KEY'] if Rails.env.production?
    YAML.load_file("#{Rails.root}/config/translate.yml")[Rails.env]['api_key']
  end

  def language_params
    @languages.map { |lang| "&to=#{lang}" }.join
  end
end

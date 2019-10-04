# frozen_string_literal: true

def response_200
  [{ 'text' => 'Gutes Beispiel', 'to' => 'de' }]
end

def response_200_body
  [{ "detectedLanguage":
    { "language": 'en', "score": 1.0 },
     "translations":
    [{ "text": 'Gutes Beispiel', "to": 'de' }] }].to_json
end

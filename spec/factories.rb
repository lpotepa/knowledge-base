# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  factory :article do
    association :question, factory: :question
    association :answer, factory: :answer
  end

  factory :article_with_translations, parent: :article do
    association :question, factory: :question_with_translations
    association :answer, factory: :answer_with_translations
  end

  factory :question do
    content { 'Example question' }
  end

  factory :answer do
    content { 'Example answer' }
  end

  factory :question_with_translations, parent: :question do
    translations { build_list :translation, 1 }
  end

  factory :answer_with_translations, parent: :answer do
    translations { build_list :translation, 1 }
  end

  factory :translation do
    content { 'eine Beispielübersetzung' }
    status { 'error' }
    language { find_or_create_language }
  end

  factory :language do
    name { 'German' }
    iso { 'de' }
  end
end

def find_or_create_language
  Language.any? ? Language.first : Language.create(name: 'German', iso: 'de')
end

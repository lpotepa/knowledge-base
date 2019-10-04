# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  it 'is invalid when one of its relations is invalid' do
    article = Article.new(
      question_attributes: { content: nil }, answer_attributes: { content: '' }
    )
    expect(article).to be_invalid
  end
end

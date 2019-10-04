# frozen_string_literal: true

require 'rails_helper'
require './spec/support/article.rb'

RSpec.describe Api::V1::ArticlesController, type: :request do
  describe 'GET /api/v1/articles' do
    it 'returns article list' do
      10.times { create(:article_with_translations) }
      get '/api/v1/articles'
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result.length).to eq 10
    end
  end

  describe 'GET /api/v1/articles/:id' do
    context 'article present' do
      it 'returns a single article' do
        article = create(:article_with_translations)
        get "/api/v1/articles/#{article.id}"
        expect(response.status).to eq 200
      end
    end

    context 'article not present' do
      it 'returns a 404' do
        get '/api/v1/articles/12345'
        expect(response.status).to eq 404
      end
    end
  end

  describe 'POST /api/v1/articles' do
    context 'valid params' do
      it 'returns status 200' do
        post '/api/v1/articles', params: valid_params
        expect(response.status).to eq 200
      end
    end
    context 'invalid params' do
      it 'returns status 422' do
        post '/api/v1/articles', params: invalid_params
        expect(response.status).to eq 422
      end
    end
  end

  describe 'PUT /api/v1/articles/:id' do
    context 'valid params' do
      let(:article) { create(:article_with_translations) }
      it 'updates an article' do
        put "/api/v1/articles/#{article.id}", params: valid_params
        expect(response.status).to eq 200
      end
    end
    context 'invalid params' do
      let(:article) { create(:article_with_translations) }
      it 'returns status 422' do
        put "/api/v1/articles/#{article.id}", params: invalid_params
        expect(response.status).to eq 422
      end
    end
    context 'article not present' do
      it 'returns a 404' do
        put '/api/v1/articles/12345'
        expect(response.status).to eq 404
      end
    end
  end

  describe 'DELETE /api/v1/articles' do
    context 'article present' do
      let(:article) { create(:article_with_translations) }
      it 'returns status 200' do
        delete "/api/v1/articles/#{article.id}"
        expect(response.status).to eq 200
      end
    end
    context 'article not present' do
      it 'returns status 200' do
        delete '/api/v1/articles/12345'
        expect(response.status).to eq 404
      end
    end
  end
end

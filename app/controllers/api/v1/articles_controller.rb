# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        articles = Article.includes(preloads).order("created_at desc")
        render json: ArticleRepresenter.collection(articles)
      end

      def show
        article = Article.includes(preloads).find_by_id(params[:id])
        unless article
          return render json: { error: 'Not found' }, status: :not_found
        end

        render json: ArticleRepresenter.one(article)
      end

      def create
        article = CreateArticleService.new(permitted_params).call
        if article.persisted?
          render json: article
        else
          render json: article.errors.full_messages.join(', '), status: 422
        end
      end

      def update
        article = Article.find_by_id(params[:id])
        unless article
          return render json: { error: 'Not found' }, status: :not_found
        end

        article = UpdateArticleService.new(article, permitted_params).call
        if article.valid?
          render json: article
        else
          render json: article.errors.full_messages.join(', '), status: 422
        end
      end

      def destroy
        article = Article.find_by_id(params[:id])
        unless article
          return render json: { error: 'Not found' }, status: :not_found
        end

        if article.destroy
          render json: article
        else
          render json: article.errors.full_messages.join(', '), status: 422
        end
      end

      private

      def permitted_params
        params.permit(
          question_attributes: :content,
          answer_attributes: :content
        )
      end

      def preloads
        { question:
          [translations: :language],
          answer: [translations: :language] }
      end
    end
  end
end

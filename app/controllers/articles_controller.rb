# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_languages
  def index; end

  def show; end

  private

  def set_languages
    @languages = Language.all
  end
end

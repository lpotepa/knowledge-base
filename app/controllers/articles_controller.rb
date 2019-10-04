# frozen_string_literal: true

class ArticlesController < ApplicationController
  def index; end

  def show
    @languages = Language.all
  end
end

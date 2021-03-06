# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions, id: :uuid do |t|
      t.text :content
      t.references :article, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

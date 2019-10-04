# frozen_string_literal: true

class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations, id: :uuid do |t|
      t.text :content
      t.references :language, null: false, foreign_key: true, type: :uuid
      t.uuid :translatable_id
      t.uuid :translatable_type
      t.timestamps
    end
    add_index :translations, %i[translatable_id translatable_type]
    add_index :translations, %i[translatable_id language_id], unique: true
  end
end

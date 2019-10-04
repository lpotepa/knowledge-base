# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages, id: :uuid do |t|
      t.string :name
      t.string :iso
      t.timestamps
    end
    add_index :languages, :name, unique: true
    add_index :languages, :iso, unique: true
  end
end

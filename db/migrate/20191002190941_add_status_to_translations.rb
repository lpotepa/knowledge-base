# frozen_string_literal: true

class AddStatusToTranslations < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE translation_status AS ENUM ('pending', 'completed', 'error');
    SQL
    add_column :translations, :status, :translation_status
    add_index :translations, :status
  end

  def down
    remove_column :translations, :status
    execute <<-SQL
      DROP TYPE translation_status;
    SQL
  end
end

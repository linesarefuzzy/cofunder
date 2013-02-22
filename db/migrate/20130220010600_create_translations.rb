class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.references :Language
      t.string :RemoteTable
      t.int :RemoteID
      t.string :RemoteColumnName
      t.text :TranslatedContent

      t.timestamps
    end
    add_index :translations, :Language_id
  end
end

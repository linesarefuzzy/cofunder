class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :Code
      t.string :Name
      t.int :Priority

      t.timestamps
    end
  end
end

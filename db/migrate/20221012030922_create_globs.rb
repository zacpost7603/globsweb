class CreateGlobs < ActiveRecord::Migration[7.0]
  def change
    create_table :globs do |t|
      t.string :title
      t.text :summary
      t.string :author

      t.timestamps
    end
  end
end

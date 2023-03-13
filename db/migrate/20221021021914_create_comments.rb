class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :contributor
      t.string :contact
      t.integer :glob_id

      t.timestamps
    end
  end
end

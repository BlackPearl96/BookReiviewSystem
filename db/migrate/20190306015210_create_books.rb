class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :category, foreign_key: true
      t.string :title
      t.text :content
      t.text :description
      t.string :author
      t.string :publisher
      t.float :rate_points
      t.integer :number_pages

      t.timestamps
    end
  end
end

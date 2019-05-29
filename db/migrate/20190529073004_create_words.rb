class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.integer :word_type
      t.string :body
      t.string :string

      t.timestamps
    end
  end
end

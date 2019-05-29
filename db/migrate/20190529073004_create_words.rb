class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.string :type
      t.string :integer
      t.string :body
      t.string :string

      t.timestamps
    end
  end
end

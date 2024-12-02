class CreateNannies < ActiveRecord::Migration[7.1]
  def change
    create_table :nannies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :photo_url
      t.string :description
      t.float :hour_rate

      t.timestamps
    end
  end
end

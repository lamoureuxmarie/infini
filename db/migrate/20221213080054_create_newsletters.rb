class CreateNewsletters < ActiveRecord::Migration[7.0]
  def change
    create_table :newsletters do |t|
      t.string :name
      t.text :email

      t.timestamps
    end
  end
end

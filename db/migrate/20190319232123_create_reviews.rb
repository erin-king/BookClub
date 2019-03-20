class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :rating
      t.string :review_text
      t.string :username

      
      t.timestamps
    end
  end
end

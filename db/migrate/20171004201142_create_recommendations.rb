class CreateRecommendations < ActiveRecord::Migration[5.1]
  def change
    create_table :recommendations do |t|
      t.string :model
      t.string :manufacturer
      t.string :style

      t.timestamps
    end
  end
end

class AddingCategoryTemperDifficultyToCallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :category, :string
    add_column :challenges, :temper, :string
    add_column :challenges, :difficulty, :string
  end
end

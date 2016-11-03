class CreatePuzzles < ActiveRecord::Migration[5.0]
  def change
    create_table :puzzles do |t|
    	t.string :board, null: false

      t.timestamps
    end
  end
end

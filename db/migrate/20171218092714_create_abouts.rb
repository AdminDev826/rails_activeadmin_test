class CreateAbouts < ActiveRecord::Migration[5.1]
  def change
    create_table :abouts do |t|
      t.string :option
      t.string :settings

      t.timestamps
    end
  end
end

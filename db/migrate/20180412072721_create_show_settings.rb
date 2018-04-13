class CreateShowSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :show_settings do |t|

      t.timestamps
    end
  end
end

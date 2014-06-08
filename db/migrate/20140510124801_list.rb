class List < ActiveRecord::Migration
  def change

    create_table :lists do |t|
      t.string :name

      t.timestamps
    end
  	add_column :messages, :list_id, :string
  end
end

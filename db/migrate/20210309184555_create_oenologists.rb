class CreateOenologists < ActiveRecord::Migration[5.2]
  def change
    create_table :oenologists do |t|
      t.string :name
      t.integer :age
      t.string :nationality
      t.boolean :editor, default: false
      t.boolean :writer, default: false
      t.boolean :reviewer, default: false

      t.timestamps
    end
  end
end

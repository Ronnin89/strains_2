class CreateMagazineOenologists < ActiveRecord::Migration[5.2]
  def change
    create_table :magazine_oenologists do |t|
      t.references :magazine, foreign_key: true
      t.references :oenologist, foreign_key: true
      t.string :position

      t.timestamps
    end
  end
end

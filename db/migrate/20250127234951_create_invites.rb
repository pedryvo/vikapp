class CreateInvites < ActiveRecord::Migration[8.0]
  def change
    create_table :invites do |t|
      t.references :admin, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.datetime :deactivated_at

      t.timestamps
    end
  end
end

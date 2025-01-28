class AddNameToInvite < ActiveRecord::Migration[8.0]
  def change
    add_column :invites, :name, :string
  end
end

class UserBalancePrecision < ActiveRecord::Migration
  def up
    change_column :users, :balance, :decimal, {:precision => 12, :scale => 2}
  end

  def down
    change_column :users, :balance, :decimal, {:precision => 10, :scale => 0}
  end
end

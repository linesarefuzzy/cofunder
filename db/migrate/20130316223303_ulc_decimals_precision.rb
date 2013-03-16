class UlcDecimalsPrecision < ActiveRecord::Migration
  def up
    change_column :user_loan_contributions, :amount, :decimal, {:precision => 12, :scale => 2}
    change_column :user_loan_contributions, :balance, :decimal, {:precision => 12, :scale => 2}
  end

  def down
    change_column :user_loan_contributions, :amount, :decimal, {:precision => 10, :scale => 0}
    change_column :user_loan_contributions, :balance, :decimal, {:precision => 10, :scale => 0}
  end
end

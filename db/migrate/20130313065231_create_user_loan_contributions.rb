class CreateUserLoanContributions < ActiveRecord::Migration
  def change
    create_table :user_loan_contributions do |t|
      t.references :user
      t.references :loan
      t.decimal :amount
      t.decimal :balance

      t.timestamps
    end
    add_index :user_loan_contributions, :user_id
    add_index :user_loan_contributions, :loan_id
  end
end

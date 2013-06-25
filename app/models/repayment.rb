class Repayment < ActiveRecord::Base
  include Legacy, TranslationModule
  
  belongs_to :loan, :foreign_key => 'LoanID'
  attr_accessible :AmountDue, :AmountPaid, :DateDue, :DatePaid, :DateRefinanced, :InterestSinceLastPayment
  
  def paid; self.date_paid ? true : false; end
  
  def status
    if self.paid
      'paid'
    elsif self.date_due < Date.today
      'overdue'
    else
      'due'
    end
  end
  
  def status_date
    format = "%B %e, %Y"
    if self.paid
      'Paid ' + self.date_paid.strftime(format)
    else
      'Due ' + self.date_due.strftime(format)
    end
  end
  
  def amount_formatted
    if self.date_paid
      amount = self.amount_paid
    else
      amount = self.amount_due
    end
    currency_format(amount, self.loan.country)
  end
end

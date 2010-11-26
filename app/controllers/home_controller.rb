class HomeController < ApplicationController
  before_filter :login_required
  layout "application"

  def index
  end

  def income    
    @income = Income.new(params[:income])
    if request.post?
      @last_balance_record = BalanceBook.all
      if @income.save
        @balance_book = BalanceBook.new
        @balance_book.income_id = @income.id
        @balance_book.credit_amount = @income.amount
        if @last_balance_record.size == 0
          @balance_book.balance_amount = @income.amount
        else
          @balance_book.balance_amount = @last_balance_record.last.balance_amount + @income.amount
        end
        if @balance_book.save
          redirect_to root_path
        end
      end
    end
    @all_income = Income.all
  end

  def expense
    @expense = Expense.new(params[:expense])
    if request.post?
      if @expense.save
        @last_book_record = BalanceBook.all
        @balance_book = BalanceBook.new
        @balance_book.expense_id = @expense.id
        @balance_book.debit_amount = @expense.amount
        @balance_book.balance_amount = @last_book_record.last.balance_amount - @expense.amount
        if @balance_book.save
          redirect_to root_path
        end
        
      end
    end
    @all_expense = Expense.all
  end

  def view_balance_book
    @all_records = BalanceBook.all        
  end

end

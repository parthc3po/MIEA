class HomeController < ApplicationController
  before_filter :login_required
  layout "application", :except=>"pdf_create"
  prawnto :prawn => { :top_margin => 75 }


  def index
  end

  def income
    @income = Income.new(params[:income])
    if request.post?
      @income.created_at = params[:created_at].to_datetime
      if @income.save
        @last_balance_record = BalanceBook.all
        @balance_book = BalanceBook.new
        @balance_book.income_id = @income.id
        @balance_book.credit_amount = @income.amount
        if @last_balance_record.size == 0
          @balance_book.balance_amount = @income.amount
        else
          @balance_book.balance_amount = @last_balance_record.last.balance_amount + @income.amount
        end
        @balance_book.created_at = @income.created_at
        if @balance_book.save
          flash[:notice] = "Data Saved !"
          redirect_to root_path
        end
      end
    end
    @all_income = Income.all
#    render :text=>@all_income.inspect and return false
  end

  def expense
    @expense = Expense.new(params[:expense])
    if request.post?
      
      redirect_to root_path
      @expense.created_at = params[:created_at].to_datetime
      if @expense.save
        @last_book_record = BalanceBook.all
        @balance_book = BalanceBook.new
        @balance_book.expense_id = @expense.id
        @balance_book.debit_amount = @expense.amount
        @balance_book.balance_amount = @last_book_record.last.balance_amount - @expense.amount
        @balance_book.created_at = @expense.created_at

        if @balance_book.save
          flash[:notice] = "Data Saved !"
          redirect_to root_path
        end

      end
    end
    @all_expense = Expense.all
  end

  def view_balance_book
    @all_records = BalanceBook.all
    
  end

  def report_data

    if request.post?

      tmps_date = params[:start_date].to_date.to_s
      tmpe_date = params[:end_date].to_date.to_s

      if tmps_date < tmpe_date
#        render :text=>"Dates are valid" and return false
        @bb = BalanceBook.all(:conditions=>"Date(created_at) between '#{tmps_date}' and '#{tmpe_date}'")

#        render :text=>@bb.first.created_at.to_date.inspect and return false
#        render :text=>@bb.inspect and return false
        render :action=>"view_report"

      else
        render :text=>"Ending date should me higher then starting date" and return false
      end
      
    end
    
  end

  def view_report
#    render :text=>params[:par1].inspect and return false
  end

  def pdf_create

    @incomes = Income.all
#    @id = 1
#    @incom = Income.first(:select=>"amount", :conditions=>"id=#{@id}").map(&:amount)
#    render :text=>@incom.inspect and return false
    respond_to do |format|
      format.pdf { render :layout => false }
    end
        
  end
  
end
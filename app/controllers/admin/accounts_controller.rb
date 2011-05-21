class Admin::AccountsController < Admin::AdminController

  def index
    @accounts = Account.all
  end

  def show

  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice]='Account updated successfully'
      redirect_to :action=>:index
    else
      render :action=>:edit
    end
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new
    if @account.update_attributes(params[:account])
      flash[:notice]='Account created successfully'
      redirect_to :action=>:index
    else
      render :action=>:new
    end
  end

  def destroy
    account = Account.find(params[:id])
    if account.destroy
      flash[:notice]="Account #{account.email} deleted successfully"
    else
      flash[:error]='Error: delete account failed'
    end
    redirect_to :action=>:index
  end
end

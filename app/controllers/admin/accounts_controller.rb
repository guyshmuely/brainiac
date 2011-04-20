class Admin::AccountsController < Admin::AdminController

  def index
    @accounts = Account.all
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

end

class Admin::AdminController < ApplicationController

  layout 'admin'

  before_filter :authenticate_account!

  def dashboard

  end

end

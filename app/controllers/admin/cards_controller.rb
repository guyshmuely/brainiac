class Admin::CardsController < ApplicationController

  def index
    @cards = Course.find(params[:course_id]).cards
    respond_to do |format|
      format.html
      format.json {render :json=> @cards.to_json(:only=>[:content])}
      format.mobile { render :layout => false }
    end
  end

  def show

  end  

end

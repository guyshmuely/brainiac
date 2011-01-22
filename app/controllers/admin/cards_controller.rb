class Admin::CardsController < ApplicationController

  def index
    @course = Course.find(params[:course_id])
    @cards = @course.cards
    respond_to do |format|
      format.html
      format.json {render :json=> @cards.to_json(:only=>[:content])}
      format.mobile { render :layout => false }
    end
  end

  def show

  end

  def new
    @course = Course.find(params[:course_id])
    @card = Card.new
  end

  def create
    course = Course.find(params[:course_id])
    card = Card.create params[:card]
    course.cards << card
    redirect_to :action=>:index
  end

  def edit
    @course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
  end

  def update
    course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
    @card.update_attributes(params[:card])
    redirect_to admin_course_cards_path(:course_id=>course)
  end

  def destroy
    course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
    @card.destroy
    redirect_to admin_course_cards_path(:course_id=>course)
  end

end

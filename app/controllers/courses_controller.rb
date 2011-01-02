class CoursesController < ApplicationController

  def index
    @courses = Course.all
    respond_to do |format|
      format.html
      format.json {render :json=> @courses.to_json(:only=>[:id,:title])}
      format.mobile { render :layout => false }
    end
  end

  def show
    puts params[:id].inspect
    @course = Course.where(:title=>params[:id])
    #@course = Course.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render :json=> @course.to_json(:only=>[:id,:title], :methods => [:number_of_cards])}
      format.mobile { render :layout => false }
    end
  end

end

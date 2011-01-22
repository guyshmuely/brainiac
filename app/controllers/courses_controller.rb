class CoursesController < ApplicationController

  def index
    @courses = Course.limit(25)
    respond_to do |format|
      format.html
      format.json {render :json=> Course.all.to_json(:only=>[:id,:title])}
      format.mobile { render :layout => false }
    end
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html
      format.json {
        puts "asdsdasdadasdads"
        @course = Course.where(:title=>params[:id])
        render :json=> @course.to_json(:only=>[:id,:title], :methods => [:number_of_cards])
      }
      format.mobile { render :layout => false }
    end
  end

end

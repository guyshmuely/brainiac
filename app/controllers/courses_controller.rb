class CoursesController < ApplicationController

  def index
    @courses = Course.all
    respond_to do |format|
      format.html
      format.mobile { render :layout => false }
    end
  end

  def show
    @course = Course.find(params[:id])
    respond_to do |format|
      format.html
      format.mobile { render :layout => false }
    end
  end

end

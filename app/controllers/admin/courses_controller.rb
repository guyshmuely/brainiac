class Admin::CoursesController < ApplicationController

  def index
    @courses = Course.all
  end

  def show

  end

  def new
    @course = Course.new
  end

  def create
    course = Course.create params[:course]
    redirect_to :action=>:index
  end

  def edit

  end

  def update
    
  end

end

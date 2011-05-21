class Admin::CoursesController < Admin::AdminController

  def index
    @courses = Course.all
  end

  def show

  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:notice]='Course updated successfully'
      redirect_to :action=>:index
    else
      render :action=>:edit
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new
    if @course.update_attributes(params[:course])
      flash[:notice]='Course created successfully'
      redirect_to :action=>:index
    else
      render :action=>:new
    end
  end

  def destroy
    course = Course.find(params[:id])
    if course.destroy
      flash[:notice]="Course #{course.title} deleted successfully"
    else
      flash[:error]='Error: delete course failed'
    end
    redirect_to :action=>:index
  end

end

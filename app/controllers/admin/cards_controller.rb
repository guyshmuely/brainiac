class Admin::CardsController < Admin::AdminController

  def index
    @course = Course.find(params[:course_id])
    @cards = @course.cards
    respond_to do |format|
      format.html
      format.json {render :json=> @cards.to_json(:only=>[:content])}
      format.mobile { render :layout => false }
      format.xls do
        data = @course.export_cards_to_excel
        send_data(data, :filename => "#{@course.title}_cards.xls")
      end
    end
  end

  def show

  end

  def new
    @course = Course.find(params[:course_id])
    @card = Card.new
  end

  def create
    @course = Course.find(params[:course_id])
    @card = Card.new
    if @card.update_attributes(params[:card])
      flash[:notice]='Card created successfully'
      @course.cards << @card
      redirect_to :action=>:index
    else
      render :action =>:new
    end
  end


  def edit
    @course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
  end

  def update
    course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
    if @card.update_attributes(params[:card])
      flash[:notice]='Card updated successfully'
      redirect_to admin_course_cards_path(:course_id=>course)
    else
      render :action =>:edit
    end
  end

  def destroy
    course = Course.find(params[:course_id])
    @card = Card.find(params[:id])
    if @card.destroy
      flash[:notice]="Card deleted successfully"
    else
      flash[:error]='Error: delete card failed'
    end
    redirect_to admin_course_cards_path(:course_id=>course)
  end

  def import
    course = Course.find(params[:course_id])
    if (number_of_imported_cards = course.import_cards_from_excel(params[:cards])) > 0
      flash[:notice] = "imported #{number_of_imported_cards} cards"
    else
      flash[:error] = "cards couldn't be imported"
    end

    redirect_to :action => :index
  end

end

class HolidaysController < ApplicationController
  layout "admin"
  before_filter :admin_required

  def index
    @holidays = Holiday.all(:order => "date desc")
  end
  
  def show
    @holiday = Holiday.find(params[:id])
  end
  
  def new
    @holiday = Holiday.new
  end
  
  def create
    @holiday = Holiday.new(params[:holiday])
    if @holiday.save
      flash[:notice] = "Successfully created holiday."
      redirect_to @holiday
    else
      render :action => 'new'
    end
  end
  
  def edit
    @holiday = Holiday.find(params[:id])
  end
  
  def update
    @holiday = Holiday.find(params[:id])
    if @holiday.update_attributes(params[:holiday])
      flash[:notice] = "Successfully updated holiday."
      redirect_to @holiday
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy
    flash[:notice] = "Successfully destroyed holiday."
    redirect_to holidays_url
  end
end

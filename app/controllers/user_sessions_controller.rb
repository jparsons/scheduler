class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_url
    else

      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      @holiday = Holiday.find_by_date(@date)
      day_of_the_week = @date.wday + 1
      @studio_hours = WorkDay.find_by_day_number(day_of_the_week)
      @work_days = WorkDay.all(:order=>"day_number asc")
      @presses = Press.find :all, :include => [:reservations]
      flash[:error] = "Email or password incorrect"
      render 'reservations/index'

    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You have been logged out."
    redirect_to :root
  end

end

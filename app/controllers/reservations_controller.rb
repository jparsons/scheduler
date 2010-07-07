class ReservationsController < ApplicationController
  # GET /reservations
  # GET /reservations.xml
  def index
  
   @date = params[:date] ? Date.parse(params[:date]) : Date.today
   @holiday = Holiday.find_by_date(@date)
   day_of_the_week = @date.wday + 1 
   @studio_hours = WorkDay.find_by_day_number(day_of_the_week)
   @presses = Press.find :all, :include => [:reservations]
   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @reservations }
     format.js { render :layout => false }
   end
  end

  # GET /reservations/1
  # GET /reservations/1.xml
  def show
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reservation }
    end
  end

  # GET /reservations/new
  # GET /reservations/new.xml
  def new
    @reservation = Reservation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reservation }
    end
  end

  # GET /reservations/1/edit
  def edit
    @reservation = Reservation.find(params[:id])
  end

  # POST /reservations
  # POST /reservations.xml
  def create
    params[:reservation].each do |reservation|
      r = Reservation.find_or_initialize_by_date_and_hour_and_press_id_and_user_id(Date.parse(reservation[:date]), reservation[:hour], reservation[:press_id], reservation[:user_id])
      r.cancelled = reservation[:cancelled]
      r.save
    end
    @current_reservations = current_user.reservations.find(:all, :conditions=>["date >= ? and cancelled = ?", Date.today, false], :order=>'date, hour asc')
    @cancellations = current_user.reservations.find(:all, :conditions=>["date >= ? and cancelled = ?", Date.today, true], :order=>'date, hour asc')
    #ReservationMailer.deliver_confirmation(current_user, @current_reservations, @cancellations)
    
    respond_to do |format|
      format.html { redirect_to(reservations_path(:date=>params[:reservation][0][:date])) }
      format.js {
        @date = Date.parse(params[:reservation][0][:date])
        @holiday = Holiday.find_by_date(@date)
        day_of_the_week = @date.wday + 1 
        @studio_hours = WorkDay.find_by_day_number(day_of_the_week)
        @presses = Press.find :all, :include => [:reservations]
        render :action=> :create, :format=>"js"
      }
    end
    
    
    # TODO: add error handling
  end

  # PUT /reservations/1
  # PUT /reservations/1.xml
  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        flash[:notice] = 'Reservation was successfully updated.'
        format.html { redirect_to(@reservation) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reservation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.xml
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to(reservations_url) }
      format.xml  { head :ok }
    end
  end
end

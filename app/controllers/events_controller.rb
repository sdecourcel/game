class EventsController < ApplicationController

  def index
      search = params[:search]
      if search.present?
          if search["game"].empty? && search["address"].empty? && search["date"].empty?
            @location = current_user.address
            @events = Event.include_address(@location).exclude_user(current_user)
          elsif search["game"].present? && search["address"].present? && search["date"].present?
            @location = search["address"]
            @game = search["game"]
            @date = Date.parse(search["date"])
            @formated_date = @date.strftime("%F")
            @events = Event.game_name(@game.capitalize).event_date(@formated_date).include_address(@location).exclude_user(current_user)
          elsif search["address"].present? && search["game"].present?
            @location = search["address"]
            @game = search["game"]
            @events = Event.game_name(@game.capitalize).include_address(@location).exclude_user(current_user)
          elsif search["address"].present? && search["date"].present?
            @location = search["address"]
            @date = Date.parse(search["date"])
            @formated_date = @date.strftime("%F")
            @events = Event.include_address(@location).event_date(@formated_date).exclude_user(current_user)
          elsif search["game"].present? && search["date"].present?
            @location = current_user.address
            @date = Date.parse(search["date"])
            @formated_date = @date.strftime("%F")
            @game = search["game"]
            @events = Event.include_address(@location).event_date(@formated_date).game_name(@game.capitalize).exclude_user(current_user)
          elsif search["date"].present?
            @location = current_user.address
            @date = Date.parse(search["date"])
            @formated_date = @date.strftime("%F")
            @events = Event.include_address(@location).event_date(@formated_date).exclude_user(current_user)
          elsif search["game"].present?
            @location = current_user.address
            @game = search["game"]
            @events = Event.include_address(@location).game_name(@game.capitalize).exclude_user(current_user)
          else search["address"].present?
            @location = search["address"]
            @events = Event.include_address(@location).exclude_user(current_user)
          end
      else
        # @events = Event.where.not(latitude: nil, longitude: nil)
        @location = current_user.address
        @events = Event.include_address(@location).exclude_user(current_user)

      end
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
      marker.lat event.latitude
      marker.lng event.longitude
    end
  end

  def show
    @event = Event.find(params[:id])
    # @participation = @event.participations.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
     redirect_to event_path(@event),  notice: "Event created! Here is your recap :)"
   else
     render :new , alert: "Ooooops, something missing! Please try again"
   end
    #ne pas oublier de formater les dates et les noms de villes en capitalise
  end

  def edit
    @event = Event.find(params[:id])
  end


  def update
  @event = Event.find(params[:id])
  @event.update(event_params)
  if @event.save
      redirect_to event_path(@event), notice: "Event updated"
      else
      redirect_to event_path(@event), alert: "something went wrong"
      end
  end

  def destroy
   @event = Event.find(params[:id])
    @event.canceled_at = Date.today
      if @event.save
      redirect_to event_path(@event), notice: "Event cancelled"
      else
      redirect_to event_path(@event), alert: "something went wrong"
      end
  end


  def myevents
    @events = current_user.events.where(canceled_at: nil)
    @cancelled_events = current_user.events.where.not(canceled_at: nil)
    @participations = current_user.participations
    @hash = Gmaps4rails.build_markers(@events) do |event, marker|
    marker.lat event.latitude
    marker.lng event.longitude
    end
  end


  def event_params
   params.require(:event).permit(:game, :title, :description, :happen_at, :address, photos: [])
  end

end



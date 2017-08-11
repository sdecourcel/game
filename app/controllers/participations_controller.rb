class ParticipationsController < ApplicationController

  # def new
  #   participation = @event.participations.build
  # end

  def create
    @participation = Participation.new(participation_params)
    @event = Event.find(params[:id])
    @participation.event = @event
    @participation.user = current_user
    if @participation.save
      flash[:notice] = 'Invitation sent'
    else
      flash[:alert] = 'Something went wrong'
    end
    redirect_to event_path(@event)
  end


  def update
      @participation = Participation.find(params[:id])
      @event = Event.find(params[:id])
      # @user = @event.participations.find(params[:user_id])

    if @participation.update(participation_params)

      flash[:notice] = 'Invitation sent'
    else
      flash[:alert] = 'Something went wrong'
    end
      redirect_to event_path(@participation.event)
  end

  private

  def participation_params
    params.require(:participation).permit(:status, :user_id, :event)
  end

end

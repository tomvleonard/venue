class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event, only: [:destroy, :edit, :update]

  def index
    @future_events, @past_events = Event.order(:event_date).partition { |e| e.event_date.future? }
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Successfully deleted event.'
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: 'Event successfully updated.'
    else
      # Redirect back to the edit form with error messages
      flash[:alert] = 'There were errors updating the event. Please check the form below.'
      redirect_to edit_event_path(@event) 
    end
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:performer, :event_date, :content) 
  end
end



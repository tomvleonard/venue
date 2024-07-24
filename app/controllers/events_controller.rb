class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_event, only: [ :destroy ]

  def index
    @future_events, @past_events = Event.order(:when).partition { |e| e.when.future? }
  end

  def destroy
    #@event.destroy
    redirect_to events_path, notice: 'Successfully deleted event.'
  end

  private

  def get_event
    @event = Event.find(params[:id])
  end
end

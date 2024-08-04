class HomeController < ApplicationController
  def index
    @events = Event.where('event_date > ?', Time.now)
  end
end




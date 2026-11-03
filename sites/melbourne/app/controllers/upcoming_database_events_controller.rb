module Melbourne
  class UpcomingDatabaseEventsController < ApplicationController
    def index
      @events = DatabaseEvent.upcoming
    end
  end
end

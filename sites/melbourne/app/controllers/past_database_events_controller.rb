module Melbourne
  class PastDatabaseEventsController < ApplicationController
    def index
      @events = DatabaseEvent.past
    end
  end
end

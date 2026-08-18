# frozen_string_literal: true

module Melbourne
  class DatabaseEventsHomeController < ApplicationController
    def show
      melbourne_and_national_events = DatabaseEvent.by_region_and_national(:melbourne)

      @next_event = melbourne_and_national_events.upcoming(1).includes(:venue).first
      @past_events = melbourne_and_national_events.past(4)
    end
  end
end

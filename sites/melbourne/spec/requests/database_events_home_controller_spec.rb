require "rails_helper"

RSpec.describe Melbourne::DatabaseEventsHomeController, type: :request do
  before do
    host! "melbourne.example.com"
  end

  describe "show" do
    let!(:last_national_event) { FactoryBot.create(:database_event, :conference, :sydney, date: 2.months.ago) }
    let!(:last_melbourne_event) { FactoryBot.create(:database_event, :meetup, :melbourne, date: 1.month.ago) }
    let!(:last_sydney_event) { FactoryBot.create(:database_event, :meetup, :sydney, date: 10.days.ago) }
    let!(:current_event) { FactoryBot.create(:database_event, :meetup, :melbourne, date: 1.day.from_now) }

    it "displays the home page" do
      get melbourne_database_events_home_path
      expect(response.status).to eq(200)
      expect(response.body).to include("Ruby Melbourne")
    end

    it 'only shows melbourne or national events' do
      get melbourne_database_events_home_path

      past_events = assigns(:past_events)
      expect(past_events).to include(last_national_event)
      expect(past_events).to include(last_melbourne_event)
      expect(past_events).not_to include(current_event)
      expect(past_events).not_to include(last_sydney_event)

      next_event = assigns(:next_event)
      expect(next_event).to eq(current_event)
    end

    it 'displays events in correct order' do
      get melbourne_database_events_home_path

      past_events = assigns(:past_events)
      expect(past_events).to eq([last_melbourne_event, last_national_event])
    end
  end
end

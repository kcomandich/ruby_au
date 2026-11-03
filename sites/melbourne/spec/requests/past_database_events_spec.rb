require "rails_helper"

RSpec.describe Melbourne::PastDatabaseEventsController, type: :request do
  before do
    host! "melbourne.example.com"
  end

  describe "index" do
    let(:events) do
      [
        DatabaseEvent.new(name: "test event-1", start_datetime: Time.zone.today - 2, slug: "test-1 for controller", description: "past controller test-1"),
        DatabaseEvent.new(name: "test event-1", start_datetime: Time.zone.today - 4, slug: "test-1 for controller", description: "past controller test-2")
      ]
    end

    before do
      allow(DatabaseEvent).to receive(:past).and_return(events)
    end

    it "displays the past events" do
      get melbourne_past_database_events_path

      expect(response.status).to eq(200)
    end

    it "renders the index view" do
      get melbourne_past_database_events_path
      events.each do |event|
        expect(response.body).to include(event.description.to_plain_text)
      end
    end
  end
end

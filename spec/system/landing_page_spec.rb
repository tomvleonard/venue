require 'rails_helper'

RSpec.describe 'Landing Page', :system do
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  
  describe 'when a user navigates to root' do
    it 'renders home#index' do
      visit root_path
      expect(page).to have_content('Calendar of Upcoming Events')
    end
  end

  describe 'Calendar Of Events', type: :system do
    before do
      driven_by(:rack_test) 
      @future_event = FactoryBot.create(:event, event_date: 1.day.from_now)
      @past_event = FactoryBot.create(:event, event_date: 1.day.ago)
    end

    it 'displays expected future event information' do
      visit root_path 
      
      within 'table tbody tr' do
        expect(page).to have_content(@future_event.event_date.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
        expect(page).to have_content(@future_event.performer)
        expect(page).to have_content(@future_event.content)
        
        # Ensure past events are not listed
        expect(page).not_to have_content(@past_event.event_date.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
        expect(page).not_to have_content(@past_event.performer)
        expect(page).not_to have_content(@past_event.content)
      end
    end
  end

end
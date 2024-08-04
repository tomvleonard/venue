require 'rails_helper'

RSpec.describe 'Events', type: :system do
  before do
    @events = {
      future: FactoryBot.create(:event, event_date: DateTime.current + 1.week),
      past: FactoryBot.create(:event, event_date: DateTime.current - 1.week)
    }
    @user = FactoryBot.create :user
    visit new_user_session_path
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: 'secret'
    click_on 'Submit'
  end

  describe '#index' do
    it 'displays expected future event information' do
      visit events_path
      within 'table.future tbody tr' do
        expect(page).to have_content(@events[:future].event_date.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
        expect(page).to have_content(@events[:future].performer)
        expect(page).to have_content(@events[:future].content)
      end
    end

    it 'displays expected past event information' do
      visit events_path
      within 'table.past tbody tr' do
        expect(page).to have_content(@events[:past].event_date.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
        expect(page).to have_content(@events[:past].performer)
        expect(page).to have_content(@events[:past].content)
      end
    end
  end

  describe '#destroy' do
    it 'successfully deletes a future event' do
      visit events_path
      within 'table.future tbody tr' do
        expect {
          click_on 'Delete'
          sleep 0.25
        }.to change(Event, :count).by(-1)
      end
    end

    it 'does not show delete link for past events' do
      past_event = FactoryBot.create(:event, event_date: 1.day.ago)
      visit events_path
      expect(page).not_to have_link('Delete', href: event_path(past_event))
    end
  end

  describe '#update' do
    let(:event) { FactoryBot.create(:event) }

    it 'successfully updates an event with valid data' do
      visit edit_event_path(event)
      fill_in 'Performer', with: 'Updated Performer'
      fill_in 'Content', with: 'Updated Content'
      fill_in 'Event date', with: '2024-08-10 14:00'
      click_on 'Update Event'
      expect(page).to have_current_path(events_path)
      expect(page).to have_text('Event successfully updated.')
      #expect(page).to have_text('Updated Performer')
      #expect(page).to have_text('Updated Content')
    end

    it 'shows an error message with invalid data' do
      visit edit_event_path(event)
      fill_in 'Performer', with: '' # Invalid data
      click_on 'Update Event'
      expect(page).to have_current_path(edit_event_path(event))
      expect(page).to have_text('There were errors updating the event. Please check the form below.')
      #expect(page).to have_text("Performer can't be blank") # Adjust this line if needed
    end
  end

end

require 'rails_helper'

RSpec.describe 'Events', type: :system do
  before do
    @events = {
      future: FactoryBot.create(:event, when: DateTime.current + 1.week),
      past: FactoryBot.create(:event, when: DateTime.current - 1.week)
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
        expect(page).to have_content(@events[:future].when.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
        expect(page).to have_content(@events[:future].performer)
        expect(page).to have_content(@events[:future].content)
      end
    end

    it 'displays expected past event information' do
      visit events_path
      within 'table.past tbody tr' do
        expect(page).to have_content(@events[:past].when.in_time_zone('Eastern Time (US & Canada)').strftime('%m/%d/%Y %I:%M %p'))
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

    xit 'should not allow past events to be deleted'
  end
end

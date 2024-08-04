require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    before do
      @event = FactoryBot.build :event
    end
    
    it 'is valid when all attributes are present' do
      expect(@event.valid?).to eq true
    end

    context 'given that the performer attribute is missing' do
      before do
        @event.performer = nil
      end

      it 'is invalid' do
        expect(@event.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @event.valid?
        expect(@event.errors[:performer].to_a).to eq expected
      end
    end

    context 'given that the content attribute is missing' do
      before do
        @event.content = nil
      end

      it 'is invalid' do
        expect(@event.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @event.valid?
        expect(@event.errors[:content].to_a).to eq expected
      end
    end

    context 'given that the event_date attribute is missing' do
      before do
        @event.event_date = nil
      end

      it 'is invalid' do
        expect(@event.valid?).to eq false
      end

      it 'has expected error message' do
        expected = [ "can't be blank" ]
        @event.valid?
        expect(@event.errors[:event_date].to_a).to eq expected
      end
    end
  end
end

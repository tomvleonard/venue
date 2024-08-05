class Event < ApplicationRecord
 [ :performer, :content, :event_date ].each do |attr|
    validates attr, presence: true
  end
end

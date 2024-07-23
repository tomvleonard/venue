class Event < ApplicationRecord
 [ :performer, :content, :when ].each do |attr|
    validates attr, presence: true
  end
end

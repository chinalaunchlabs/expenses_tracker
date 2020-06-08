class Record < ApplicationRecord
  belongs_to :user
  belongs_to :category

  enum record_type: {
    income: 0,
    expense: 1
  }

  scope :on_day, ->(date) { where('Date(date) = ?', date.to_date) }
end

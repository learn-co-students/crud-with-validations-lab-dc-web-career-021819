class Song < ApplicationRecord
  require 'date'
  validates :title, {presence: true}
  validate :release_date_must_exist_when_released
  validate :release_date_cannot_be_in_future

  def release_date_must_exist_when_released
    if released && release_year.present? == false
      errors.add(:release_date, "must exist if song is released")
    end
  end

  def release_date_cannot_be_in_future
    if release_year
      if release_year > Date.today.year
        errors.add(:release_date, "must not be in the future")
      end
    end
  end
end

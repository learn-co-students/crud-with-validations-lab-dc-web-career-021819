class Song < ApplicationRecord
  require 'date'
  validates :title, {presence: true}
  validate :release_date_must_exist_when_released
  validate :release_date_cannot_be_in_future
  validate :song_cannot_be_released_song

  def release_date_must_exist_when_released
    if released && release_year.present? == false
      errors.add(:release_date, "must exist if song is released")
    end
  end

  def song_cannot_be_released_song
    duplicate_song = Song.find_by(title: self.title)
    if duplicate_song
      if duplicate_song.release_year == self.release_year
        errors.add(:release_year, "cannot contain more than one instance of a song")
      end
    end
  end

  def release_date_cannot_be_in_future
    if release_year
      if release_year > Date.today.year
        errors.add(:release_year, "must not be in the future")
      end
    end
  end
end

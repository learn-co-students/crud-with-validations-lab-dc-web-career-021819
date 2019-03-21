class Song < ApplicationRecord
  validates :title, :artist_name, presence: true
  validates :title, uniqueness: { scope: :release_year}
  validates :release_year, presence: true, if: :released
  validate :release_year_cannot_be_in_the_future

  def release_year_cannot_be_in_the_future
    if release_year
      if release_year > Date.today.year
        errors.add(:release_year, "can't be in the future")
      end
    end
  end
end

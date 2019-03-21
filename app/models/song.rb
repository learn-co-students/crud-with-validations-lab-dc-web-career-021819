class Song < ApplicationRecord
  validates :title, :artist_name, presence: true
  validates :title, uniqueness: { scope: %i[release_year artist_name]}
  validates :released, inclusion: { in: [true, false] }
  validates :release_year, presence: true, if: :released
  validate :release_year_cannot_be_in_the_future

  def release_year_cannot_be_in_the_future
    if release_year
      if release_year > Date.today.year
        errors.add(:release_year, "can't be in the future")
      end
    end
  end

  # with_options if: :released? do |song|
  #   song.validates :release_year, presence: true
  #   song.validates :release_year, numericality: {
  #     less_than_or_equal_to: Date.today.year
  #   }
  # end
  #
  # def released?
  #   released
  # end
end

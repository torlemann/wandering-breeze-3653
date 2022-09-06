class Contestant < ApplicationRecord
  validates_presence_of :name, :age, :hometown, :years_of_experience

  has_many :contestant_projects
  has_many :projects, through: :contestant_projects

  def self.average_xp
    pluck(:years_of_experience).sum.to_f / count
  end
end
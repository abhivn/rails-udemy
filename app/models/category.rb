class Category < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name

  has_many :article_categories
  has_many :articles, through: :article_categories

end

class Book < ApplicationRecord
  validates_presence_of :title,
                        :number_of_pages,
                        :publish_year

  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :reviews, dependent: :destroy

  def self.top_books
    joins(:reviews)
    .select("books.*, AVG(reviews.rating) AS avg_rating")
    .group(:id)
    .order("avg_rating DESC")
    .limit(3)
  end

  def self.worst_books
    joins(:reviews)
    .select("books.*, AVG(reviews.rating) AS avg_rating")
    .group(:id)
    .order("avg_rating")
    .limit(3)
  end

  def self.sort_by_ascending_pages
    order(number_of_pages: :ASC)
  end

  def self.sort_by_descending_pages
    order(number_of_pages: :DESC)
  end

  def average_rating
    reviews.average(:rating) || 0
  end

  def total_reviews
    reviews.count
  end

  def top_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    reviews.order(:rating).limit(3)
  end

  def max_rating
    reviews.maximum(:rating) || 0
  end

  def min_rating
    reviews.minimum(:rating) || 0
  end

  def co_author(author)
    authors.where.not(name: author.name)
  end

  def top_book_review
    reviews.order(:rating).last
  end

end

require "rails_helper"

RSpec.describe "user_index", type: :feature do
  before :each do
    @book_1 = Book.create(title: "In Search Of Lost Time", number_of_pages: 4215, publish_year: 1913, cover: "https://images.penguinrandomhouse.com/cover/9780679645689")
    @author_1 = @book_1.authors.create(name: "Marcel Proust")
    @book_2 = Book.create(title: "Don Quixote", number_of_pages: 928, publish_year: 1605, cover: "https://i.pinimg.com/originals/2e/42/d2/2e42d25ee87ad6bb5f512bd86e099233.jpg")
    @author_2 = @book_2.authors.create(name: "Miguel de Cervantes")
    @book_3 = Book.create(title: "Ulysses", number_of_pages: 730, publish_year: 1922, cover: "https://images-na.ssl-images-amazon.com/images/I/51wTLf4JVwL._SX384_BO1,204,203,200_.jpg")
    @author_3 = @book_3.authors.create(name: "James Joyce")
    @book_4 = Book.create(title: "The Talisman", number_of_pages: 921, publish_year: 1984, cover: "https://images-na.ssl-images-amazon.com/images/I/81muDiETxIL.jpg")
    @author_4 = @book_4.authors.create(name: "Peter Straub, Stephen King")

    @review_1 = @book_1.reviews.create(title: "Review Title 1", rating: 1, review_text: "This is the 1st review.", username: "UserYou1")
    @review_2 = @book_1.reviews.create(title: "Review Title 2", rating: 3, review_text: "This is the 2nd review.", username: "UserYou2")
    @review_3 = @book_1.reviews.create(title: "Review Title 3", rating: 5, review_text: "This is the 3rd review.", username: "UserYou3")
    @review_4 = @book_1.reviews.create(title: "Review Title 4", rating: 2, review_text: "This is the 4th review.", username: "UserYou4")

    @review_5 = @book_2.reviews.create(title: "Review Title 5", rating: 1, review_text: "This is the 1st review.", username: "UserYou3")
    @review_6 = @book_2.reviews.create(title: "Review Title 6", rating: 3, review_text: "This is the 2nd review.", username: "UserYou2")
    @review_7 = @book_2.reviews.create(title: "Review Title 7", rating: 4, review_text: "This is the 3rd review.", username: "UserYou1")

    @review_8 = @book_3.reviews.create(title: "Review Title 8", rating: 3, review_text: "This is the 1st review.", username: "UserYou1")
    @review_9 = @book_3.reviews.create(title: "Review Title 8", rating: 3, review_text: "This is the 1st review.", username: "UserYou2")
  end

  it 'user_can_see_all_books' do

    visit books_path

    within "#book-#{@book_1.id}" do
      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.number_of_pages)
    end
  end

  it 'user can see average book rating and total number of reviews' do

    visit books_path

    within "#book-#{@book_2.id}" do
      expect(page).to have_content("Average Rating: #{@book_2.average_rating.round(2)}")
      expect(page).to have_content("Total Reviews: #{@book_2.total_reviews}")
    end

    within "#book-#{@book_1.id}" do

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_1.number_of_pages)
      expect(page).to have_content("Marcel Proust")
      expect(page).to have_content(@book_1.publish_year)
      expect(page).to have_css("img[src*='#{@book_1.cover}']")
    end
  end

  it 'user can click title of book and go to showpage for book 1' do
    visit books_path

    within "#book-#{@book_1.id}" do
      click_on @book_1.title
    end

    expect(page).to have_content 'In Search Of Lost Time'
    expect(page).to have_content 'Author(s): Marcel Proust'
    expect(page).to have_css("img[src*='#{@book_1.cover}']")
  end

  it 'user can click title of book and go to showpage for book 1' do
    visit books_path

    within "#book-#{@book_2.id}" do
      click_on @book_2.title
    end

    expect(page).to have_content 'Don Quixote'
    expect(page).to have_content 'Author(s): Miguel de Cervantes'
    expect(page).to have_css("img[src*='#{@book_2.cover}']")

  end

  it 'user can see statistics for top three rated books' do

    visit books_path

    within "#stats-bar-highest" do
      expect(page.all('li')[0]).to have_content(@book_3.title)
      expect(page.all('li')[0]).to have_content(@book_3.max_rating)
      expect(page.all('li')[1]).to have_content(@book_1.title)
      expect(page.all('li')[1]).to have_content(@book_1.max_rating)
      expect(page.all('li')[2]).to have_content(@book_2.title)
      expect(page.all('li')[2]).to have_content(@book_2.max_rating)
    end
  end

  it 'user can see statistics for worst three rated books' do

    visit books_path

    within "#stats-bar-worst" do
      expect(page.all('li')[0]).to have_content(@book_2.title)
      expect(page.all('li')[0]).to have_content(@book_2.min_rating)
      expect(page.all('li')[1]).to have_content(@book_1.title)
      expect(page.all('li')[1]).to have_content(@book_1.min_rating)
      expect(page.all('li')[2]).to have_content(@book_3.title)
      expect(page.all('li')[2]).to have_content(@book_3.min_rating)
    end
  end

  it 'user can see top three review users and their review count' do

    visit books_path

    within "#top-three-users-and-review-count" do
      expect(page.all('li')[0]).to have_content("UserYou2")
      expect(page.all('li')[0]).to have_content("3")
      expect(page.all('li')[1]).to have_content("UserYou4")
      expect(page.all('li')[1]).to have_content("1")
      expect(page.all('li')[2]).to have_content("UserYou3")
      expect(page.all('li')[2]).to have_content("2")
    end
  end
end

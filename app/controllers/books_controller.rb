class BooksController < ApplicationController
  def new
    @book = Books.new
  end

  def index
    matching_books = Books.all

    @books = matching_books.order( created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @books
      end

      format.html
    end
  end

  def show
    @book = Books.find(params.fetch(:id))
  end

  def create
    book_attributes = params.require(:book).permit(:title, :description)
    @book = Books.new(book_attributes)

    if @book.valid?
      @book.save
      redirect_to books_url, notice: "Book created successfully."
    else
      render template: "new"
    end
  end

  def edit
    @book = Books.find(params.fetch(:id))
  end

  def update
    
    
    @book = Books.find(params.fetch(:id))

    @book.title = params.fetch("title")
    @book.description = params.fetch("description")

    if @book.valid?
      @book.save
      redirect_to book_url(@book), notice: "Book updated successfully."
    else
      redirect_to book_url(@book), alert: "Book failed to update successfully." 
    end
  end

  def destroy
    @book = Books.find(params.fetch(:id))

    @book.destroy

    redirect_to movies_url, notice: "Book deleted successfully."
  end
end
class BooksController < ApplicationController
 before_action :is_matching_login_user, only: [:edit, :update]
 
  def create
     @book = Book.new(books_params)
     @book.user_id = current_user.id
    if @book.save
      flash[:notice]="Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end
  
  def index
    @book = Book.new
     @books = Book.all
     @user=current_user
     
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy 
    flash[:notice] ="Book was successfully destroyed."
    redirect_to '/books'
  end
  
  def update
    @book = Book.find(params[:id])
   if @book.update(books_params)
    flash[:notice] ="Book was successfully updated."
    redirect_to book_path(@book.id)  
     else
      render:edit
   end
  end 
  
   private
   
  def books_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    user = User.find(params[:id])
   unless user.id == current_user.id
      redirect_to books_path
   end
  end
end

class TextbooksController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :set_textbook, only: [:destroy, :update, :edit]

  def welcome
  end

  def index
    if params[:q]
      @textbooks = Textbook.search((params[:q].present? ? params[:q] : '*')).records
    else
      @textbooks = Textbook.all.order('created_at DESC')
    end
  end

  def new
    @textbook = current_user.textbooks.build
  end

  def create
    @textbook = current_user.textbooks.build(textbook_params)

    respond_to do |format|
      if @textbook.save
        format.html { redirect_to textbooks_path, notice: 'Texbook entry was successfully created.' }
        format.json { render :show, status: :created, location: @textbook }
      else
        format.html { render :new }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @textbook.update[textbook_params]
        format.html { redirect_to textbooks_path, notice: 'Texbook entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @textbook }
      else
        format.html { render :edit }
        format.json { render json: @textbook.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @textbook.destroy
    respond_to do |format|
      format.html { redirect_to textbooks_path, notice: "Textbook entry was successfully destroy." }
      format.json { head :no_content }
    end
  end

  private
    def set_textbook
      @textbook = Textbook.find(params[:id])
    end

    def textbook_params
      params.require(:textbook).permit(:title, :author, :isbn, :price)
    end
end

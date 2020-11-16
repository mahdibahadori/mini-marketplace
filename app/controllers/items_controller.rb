class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    if params[:search].present?  
       @items = Item.where('name ILIKE ? OR description ILIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      #I want to show the user that his search did not reaturn any item
      @items = Item.all 
    end
  end 

  def show    
  end  

  def new
    @item = Item.new
  end

  def create 
    @item = current_user.items.new(item_params)   
    if @item.save
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      redirect_to new_item_path, notice: 'This item could not be created'
    end
  end

  def edit    
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: 'Item was successfully updated.'
    else
      redirect_to edit_item, notice: 'This item was not updated.'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully destroyed.'
  end


  private 

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :location, :price, :category, :picture)
  end

  
end

class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :authenticate_user!, except: [:show]


  def index
    @items = current_user.items
  end

  def new
    @item = current_user.items.build
  end

  def create
    # @item = current_user.items.build(item_params)
    @item = current_user.items.build
    @item.save(validate: false)
    redirect_to item_list_step_path(@item, Item.form_steps.first)
    # if @item.save
    #   redirect_to item_show_path(@item), notice: "Save..."
    # else
    #   render :new, notice: "Something went wrong... Please try again."
    # end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Saved..."
    else
      flash[:notice] = "Something went wrong... Please try again."
    end
    redirect_back(fallback_location: request.referer)
  end

  def show
  end

  def destroy
    @item.destroy!
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_name, :item_photo, :description, :price_daily, :price_weekly, :price_monthly, :post_code)
  end
end

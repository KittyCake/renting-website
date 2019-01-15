class Item::ListStepsController < ApplicationController
  include Wicked::Wizard
  steps *Item.form_steps

  def show
    @item = Item.find(params[:item_id])
    # @item = current_user.items.build(params[:item_id])
    render_wizard
  end

  def update
    @item = Item.find(params[:item_id])
    # byebug
    @item.update(item_params(step))
    render_wizard @item
  end

  private

  def item_params(step)
    # params.require(:item).permit(:item_name, :item_photo, :description, :price_worth, :price_daily, :price_monthly, :post_code, :active)
    permitted_attributes = case step
      when "new_name_photo"
        [:item_name, :item_photo]
      when "new_cat_des"
        [:description]
      when "new_worth"
        [:price_worth]
      when "new_price_loca"
        [:price_daily, :price_weekly, :price_monthly, :post_code]
      end

    params.require(:item).permit(permitted_attributes).merge(form_step: step)
  end
end

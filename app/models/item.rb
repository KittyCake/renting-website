class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  accepts_nested_attributes_for :category

  # validates :item_name, presence: true, length: {minimum: 10, maximum: 50}
  # validates :item_photo, presence: true
  # validates :description, presence: true, length: {minimum: 10, maximum: 400}
  # validates :price_worth, presence: true
  # validates :price_daily, presence: true
  # validates :price_weekly, presence: true
  # validates :price_monthly, presence: true
  # validates :post_code, presence: true

  cattr_accessor :form_steps do
    %w(new_name_photo new_cat_des new_worth new_price_loca)
  end

  attr_accessor :form_step

  validates :item_name, :item_photo, presence: true, if: -> { required_for_step?(:new_name_photo) }
  validates :item_name, length: { minimum: 10, maximum: 50 }, if: -> { required_for_step?(:new_name_photo) }

  validates :description, :category_id, presence: true, if: -> { required_for_step?(:new_cat_des) }
  validates :description, length: { minimum: 10, maximum: 400 }, if: -> { required_for_step?(:new_cat_des) }

  validates :price_worth, presence: true, if: -> { required_for_step?(:new_worth) }

  validates :price_daily, :price_weekly, :price_monthly, :post_code, presence: true, if: -> { required_for_step?(:new_price_loca) }


  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
    # All fields from previous steps are required if the
    # step parameter appears before or we are on the current step
    return true if self.form_steps.index(step.to_s) <= self.form_steps.index(form_step)
  end
end

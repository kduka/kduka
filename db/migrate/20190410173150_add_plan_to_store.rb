class AddPlanToStore < ActiveRecord::Migration[5.0]
  def change
    add_reference :stores, :plan, foreign_key: true
  end
end

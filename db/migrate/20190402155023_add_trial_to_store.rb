class AddTrialToStore < ActiveRecord::Migration[5.0]
  def change
    add_column :stores, :trial, :boolean
    add_column :stores, :trial_start, :date
    add_column :stores, :trial_end, :date
  end
end

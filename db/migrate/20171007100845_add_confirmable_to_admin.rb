class AddConfirmableToAdmin < ActiveRecord::Migration[5.0]
  def change
    add_column :admins, :confirmation_token, :string
    add_column :admins, :confirmed_at, :datetime
    add_column :admins, :confirmation_sent_at, :datetime
    # add_column :admins, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :admins, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # admins as confirmed, do the following
    User.all.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :admins, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :admins, :unconfirmed_email # Only if using reconfirmable
  end
end


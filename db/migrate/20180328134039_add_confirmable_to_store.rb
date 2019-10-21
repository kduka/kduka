class AddConfirmableToStore < ActiveRecord::Migration[5.0]
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :stores, :confirmation_token, :string
    add_column :stores, :confirmed_at, :datetime
    add_column :stores, :confirmation_sent_at, :datetime
    # add_column :stores, :unconfirmed_email, :string # Only if using reconfirmable
    add_index :stores, :confirmation_token, unique: true
    # User.reset_column_information # Need for some types of updates, but not for update_all.
    # To avoid a short time window between running the migration and updating all existing
    # stores as confirmed, do the following
    Store.all.update_all confirmed_at: DateTime.now
    # All existing user accounts should be able to log in after this.
  end

  def down
    remove_columns :stores, :confirmation_token, :confirmed_at, :confirmation_sent_at
    # remove_columns :stores, :unconfirmed_email # Only if using reconfirmable
  end
end

# NOTE: We save the external id in this table since we decided
# to make the email addresses unique accross the guests table instead

# NOTE: Status can vary accross different services. Hence, it's
# necessary to have a service object that manages statuses.

class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :guest, index: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :adults, default: 1, null: false
      t.integer :children, default: 0, null: false
      t.integer :infants, default: 0, null: false
      t.string :guest_external_id, null: false
      t.string :status, null: false
      t.decimal :security_price
      t.decimal :total_price
      t.decimal :payout_price
      t.string :currency

      t.timestamps
    end
  end
end

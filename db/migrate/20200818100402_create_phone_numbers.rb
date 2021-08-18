class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.references :guest, index: true
      t.string :type, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end

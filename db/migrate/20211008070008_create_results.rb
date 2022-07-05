class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :user, null: false, foreign_key: true
      t.references :exam, null: false, foreign_key: true
      t.integer :score, default: 0 # điểm
      t.integer :status, default: 0 #pending, failed, passed
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

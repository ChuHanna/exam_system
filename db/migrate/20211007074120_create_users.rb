class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name # tên user
      t.string :email, unique: true # email của user
      t.integer :role, default: 0 # phân quyền trainee, trainer, admin
      t.integer :status, default: 2
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.string :name # tên chủ đề
      t.string :description # mô tả chủ đề
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

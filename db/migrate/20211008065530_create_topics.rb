class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :topics do |t|
      t.string :name # tên chủ đề
      t.string :description # mô tả chủ đề
      t.integer :duration, default: 0 # thời gian làm bài thi
      t.references :user, null: false, foreign_key: true # người tạo topic
      t.references :subject, null: false, foreign_key: true # topic thuộc về môn học nào
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

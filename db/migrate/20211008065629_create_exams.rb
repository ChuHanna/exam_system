class CreateExams < ActiveRecord::Migration[6.0]
  def change
    create_table :exams do |t|
      t.references :topic, null: false, foreign_key: true # chủ đề đề thi
      t.references :user, foreign_key: true # người tạo đề thi
      t.datetime :time_start # thời gian bắt đầu làm bài
      t.datetime :time_end # thời gian kết thúc làm bài
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

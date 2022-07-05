class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :description # mô tả câu hỏi
      t.integer :question_type, default: 0 # kiểu câu hỏi chọn nhiều, chọn 1, tự luận
      t.integer :level, default: 0 # 0: dễ, 1: trung bình, 2: khố
      t.references :topic, null: false, foreign_key: true # chủ đề câu hỏi
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

class CreateQuestionsExams < ActiveRecord::Migration[6.0]
  def change
    create_table :questions_exams do |t|
      t.references :exam, null: false, foreign_key: true # mã đề thi
      t.references :question, null: false, foreign_key: true # mã câu hỏi
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

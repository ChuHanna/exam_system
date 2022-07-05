class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :description # mô tả câu trả lời
      t.boolean :check # đúng hay sai
      t.references :question, null: false, foreign_key: true
      t.datetime :deleted_at, null: true

      t.timestamps
    end
  end
end

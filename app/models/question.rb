class Question < ApplicationRecord
  QUESTION_PARAMS = [:topic_id, :description, :level, :question_type,
    answers_attributes: [:id, :question_id, :description, :check, :_destroy]].freeze

  belongs_to :topic
  has_many :answers, dependent: :destroy
  has_many :questions_exams, dependent: :destroy
  has_many :exams, through: :questions_exams

  validates :description, presence: true


  accepts_nested_attributes_for :answers,
                                reject_if: :all_blank,
                                allow_destroy: true

  enum level: {easy:0, medium: 1, difficult: 2}, _prefix: :level
  enum question_type: {single_choice: 0, multiple_choice: 1, essay: 2}, _prefix: :question_type
  scope :sort_by_date, ->{order(created_at: :desc)}
  scope :get_list, ->{select(:id, :description)}

  class << self
    def import file
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        row[:subject_id] = (Subject.find_by name: row["subject"]).id
        row[:topic_id] = (Topic.find_by(subject_id: row[:subject_id], name: row["topic"])).id
        row["question type"] = if row["question type"] == "single"
                                 "single_choice"
                               elsif row["question type"] == "multiple"
                                 "multiple_choice"
                               else
                                 "essay"
                               end
        handel_excel row["answers"]
        row[:options_attributes] = @options_attributes
        row.delete "answers"
        row.delete "topic"
        row.delete "question type"
        Question.create! row
      end
    end

    def open_spreadsheet file
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    rescue StandardRecord
      Rails.logger = Logger.new "Unknown file type"
    end

    protected

    def handel_excel row
      @options_attributes = []
      row.split(",").each do |option|
        option_hash = Hash.new
        arr_option = option.split(":")
        option_hash[:description] = arr_option[0]
        option_hash[:status] = arr_option[1]
        @options_attributes.push option_hash
      end
    end
  end
end

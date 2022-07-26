class StaticPagesController < ApplicationController
  def home; end

  def dashboard
    @avg_point_by_subject = []
    @exams = []
    @points = {"0-5"=>0, "5-7"=>0, "7-10"=>0}
    Subject.all.each do |s|
      total = 0
      count = 0
      diem = 0
      s.topics.each do |t|
        t.exams.each do |exam|
          diem = tinh_diem exam
          total += diem
          count +=1
          if diem < 5
            @points["0-5"] +=1
          elsif diem <7
            @points["5-7"] +=1
          else
            @points["7-10"] +=1
          end
        end
      end
      if count == 0
        @avg_point_by_subject << [s.name, 0]
      else
        @avg_point_by_subject << [s.name, (total.to_f/count)]
        @exams << [s.name, count]
      end
    end
    puts @avg_point_by_subject

  end
# ok `vao Db sâ sang crome
  private
  def tinh_diem exam
    return 0 if (!exam.result || exam.questions_exams.count == 0)

    ((10/exam.questions_exams.count)*exam.result.score).round(2)
  end
end

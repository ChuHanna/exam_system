if !User.find_by email: "admin@gmail.com"
  User.create!(
    email: "admin@gmail.com",
    name: "Admin",
    role: "admin",
    status: "active",
    password: "123456",
    password_confirmation: "123456"
  )
end

if !User.find_by email: "trainee@gmail.com"
  User.create!(
    email: "trainee@gmail.com",
    name: "Trainee",
    role: "trainee",
    status: "active",
    password: "123456",
    password_confirmation: "123456"
  )
end


if !User.find_by email: "trainer@gmail.com"
  User.create!(
    email: "trainer@gmail.com",
    name: "Trainer",
    role: "trainer",
    status: "active",
    password: "123456",
    password_confirmation: "123456"
  )
end

if !Subject.find_by description: "Object-oriented programming"
  s = Subject.create!(
    name: "Object-oriented programming",
    description: "Object-oriented programming",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    subject_id: s.id,
    user_id: 1
  )
end

if !Subject.find_by description: "Computer Architecture"
  s = Subject.create!(
    name: "Computer Architecture",
    description: "Computer Architecture",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )
end

if !Subject.find_by description: "Software Engineering"
  s = Subject.create!(
    name: "Software Engineering",
    description: "Software Engineering",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )
end

if !Subject.find_by description: "Project"
  s = Subject.create!(
    name: "Project",
    description: "Project",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )
end

if !Subject.find_by description: "Software testing"
  s = Subject.create!(
    name: "Software testing",
    description: "Software testing",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )
end

if !Subject.find_by description: "Linear Algebra"
  s = Subject.create!(
    name: "Linear Algebra",
    description: "Linear Algebra",
    user_id: 1
  )
  Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )
end

if !Subject.find_by description: "Data Structure and Algorithms"
  s = Subject.create!(
    name: "Data Structure and Algorithms",
    description: "Data Structure and Algorithms",
    user_id: 1
  )
  t = Topic.create!(
    name: "15 minutes test",
    description: "quick test",
    duration: 15,
    user_id: 1,
    subject_id: s.id
  )

  Exam.create!(
    topic_id: t.id,
    user_id: 1,
  )
end

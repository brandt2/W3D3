# == Schema Information
#
# Table name: courses
#
#  id            :bigint(8)        not null, primary key
#  name          :string
#  prereq_id     :integer
#  instructor_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Course < ApplicationRecord
    validates :name, presence: true
    validates :prereq_id, presence: true
    validates :instructor_id, presence: true

    has_many(:enrollments, {
        primary_key: :id,
        foreign_key: :course_id,
        class_name: 'Enrollment'
    })

    has_many(:enrolled_students, {
        primary_key: :id,
        foreign_key: :student_id,
        class_name: 'Enrollment'
    })
    
    has_many(:prerequisite, {
        primary_key: :id,
        foreign_key: :prereq_id,
        class_name: 'Course'
    })

    belongs_to(:instructor, {
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: 'User'
    })

end

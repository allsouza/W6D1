Employee Table

Departments Table

Use SQL => given a department name, find employee
    `name`s that are in that department.

>2 To find Emp names, start FROM employees table since you know you'll be selecting Emp names (column on that table)
>1 Set up SELECT to return employees.names
>3a Need to Join in Department
>3b Join based on Emp's foreign_key for dept lining up Dept's primary key
> Then you can filter by GIVEN(?) dept

<<- SQL (?)
SELECT
    employees.name
FROM
    employees
JOIN
    deptartments ON deptartments.id = employees.dept_id
WHERE
    departments.name = ?


2.  Next find the name of the employees that don't belong to any department

> same start > find name from Employees
> if they don't belong to any dept, they have NULL in that column
> LEFT OUTER JOIN instead of inner join to capture NULL alignments
>return where their dept "IS NULL"

SELECT
    employees.name
FROM
    employees
<!-- LEFT OUTER JOIN
    deptartments ON deptartments.id = employees.dept_id -->
WHERE
    employees.dept_id IS NULL



__________________________________________________________________________

What are the disavantages of adding an index to a table column in a db?
-It takes up extra storage in the computer
-Every add/remove requires a re-index


Given the following table write belongs_to and has_many


<!-- 
# == Schema Information
#
# Table name: users
#
#  id   :integer                not null, primary key
#  name :string                 not null


# Table name: enrollments
#
#  id   :integer                not null, primary key
#  course_id :integer           not null
#  student_id :integer          not null


# Table name: courses
#
#  id   :integer                not null, primary key
#  course_name :string          not null
#  professor_id :integer        not null
#  prereq_course_id :integer    not null
``` -->

enrollments
class Enrollment < ApplicationRecord

    belongs_to :student,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :User

    belongs_to :course,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Course

end

users
class User < ApplicationRecord

    has_many :enrollments,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment

    has_many :courses,
        primary_key: :id,
        foreign_key: :professor_id,
        class_name: :Course

end

courses
class Course < ApplicationRecord

    belongs_to :professor,
        primary_key: :id,
        foreign_key: :professor_id,
        class_name: :User

    belongs_to :prereq_course,
        primary_key: :id,
        foreign_key: :prereq_course_id,
        class_name: :course,
        optional: true

    has_many :enrollments,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Enrollment
    
end

__________________________________________________________________________

Describe the differences between a primary key and a foreign key.

> Primary Key is included in every table, it is a unique id column that assigns a unique number per row in that column

> Foreign Key is pointing to a primary_key in another table and is useful for joining those tables on that unique identifier

__________________________________________________________________________

`belongs_to` and `has_many` **and**
`has_many through` associations for models based on the below table
(`Physician`, `Appointment`, and `Patient`)

```ruby
# == Schema Information
#
# Table name: physicians
#
#  id   :integer          not null, primary key
#  name :string           not null


# Table name: appointments
#
#  id   :integer           not null, primary key
#  physician_id :integer   not null
#  patient_id :integer     not null


# Table name: patients
#
#  id   :integer           not null, primary key
#  name :string            not null
#  primary_physician_id :integer


class Physician < ApplicationRecord

    has_many :appointments,
        primary_key: :id,
        foreign_key: :physician_id,
        class_name: :Appointment

    has_many :primary_care_patients,
        primary_key: :id,
        foreign_key: :primary_physician_id,
        class_name: :Patient

    has_many :other_patients,
        through: :appointments,
        source: :patient

    has_many :primary_care_appointments,
        through: :primary_care_patients,
        source: :appointments
end

class Appointment < ApplicationRecord

    belongs_to :physician,
        primary_key: :id,
        foreign_key: :physician_id,
        class_name: :Physician

    belongs_to :patient,
      primary_key: :id,
      foreign_key: :patient_id,
      class_name: :Patient

end

class Patient < ApplicationRecord

    has_many :appointments,
      primary_key: :id,
      foreign_key: :patient_id,
      class_name: :Appointment

    belong_to :primary_physician,
        primary_key: :id,
        foreign_key: :primary_physician_id,
        class_name: :Physician
end


__________________________________________________________________________

Given all possible SQL commands order by order of query execution. 
(SELECT,
DISTINCT, FROM, JOIN, WHERE, GROUP BY, HAVING, LIMIT/OFFSET, ORDER).

FROM, JOIN, WHERE, GROUP BY, HAVING, SELECT, DISTINCT, ORDER, LIMIT/OFFSET

In which years was the Physics prize awarded, but no Chemistry prize?
# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string


SELECT DISTINCT
    yr
FROM
    nobels
WHERE
    yr IN (
        SELECT
            yr
        FROM   
            nobels
        WHERE
            subject = 'Physics' )
    AND subject != 'Chemistry'
------

SELECT DISTINCT
    yr
FROM
    nobels
WHERE
    (subject = 'Physics' AND yr NOT IN (
    SELECT
        yr
    FROM
        nobels
    WHERE
        subject = 'Chemistry'
    ))


__________________________________________________________________________

Paraphrase the advantages of using an ORM (like ActiveRecord).

Object Relational Model >>  modeling how objects relate to the database as an object as well as one another through associations built into the ActiveRecord underlying program
>>less database overall access code
>> translate rows from SQL to Ruby objects

**Answer**: Using an ORM (Object Relational Model) allows you to interact with
database information in an OOP way. An ORM like ActiveRecord will translate rows
from your SQL tables into Ruby objects on fetch, and translates your Ruby
objects back to rows on save resulting in less overall database access code.

--

When are model validations run?

model validations are run BEFORE database constraints, so upon the calling of a models method (initialize or save)

--

# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

Write two SQL Queries:

1.  List the films where 'Harrison Ford' has appeared - but not in the star role.

SELECT
    movies.title
FROM
    movies
JOIN
    castings ON movies.id = castings.movie_id
JOIN
    actors ON actors.id = castings.actor_id
WHERE
    actors.name = 'Harrison Ford' AND ord != 1


2.  Obtain a list in alphabetical order of actors whove had at least 15  starring roles.

SELECT
    actors.name
FROM
    actors
JOIN
    castings ON actors.id = castings.actor_id
GROUP BY
    actors.name
HAVING
    COUNT(castings.ord = 1) >= 15  /*would it work or need a WHERE clause for ord separately?
ORDER BY
    actors.name

--

Identify the difference between a `has_many through` and a `has_one` association?


if a class can be associated with many instances of another class, then it will have a "has_many" association, if it can only be associated with one instance of the other class, then a 'has_one'

>`has_many` when a primary key is referred to by a foreign key in the associated records, and can be 2+ times.

__________________________________________________________________________

What is the purpose of a database migration?
Allows us to make changes to the db using ruby language and to keep track of all the changes made to our database, making it easier to understand it and to take somewhere.
A migration can be used to create, delete tables or columns, add_indexes,...
--

What is the difference between Database Constraints and Active Record Validations?
DB contrainsts are defined on migrations especially when creating tables, this will throws SQL db errors, ugly
ARV are defined in the models, this will throw ruby errors which are easier to interpret
--

Given the following table write all the `belongs_to` and `has_many` associations for models based on the below table (`User`, `Game`, and `Score`)

# == Schema Information
#
# Table name: user
#  id   :integer          not null, primary key
#  name :string           not null

# Table name: score
#  id   :integer           not null, primary key
#  number :integer         not null
#  user_id :integer        not null
#  game_id :integer        not null

# Table name: game
#  id   :integer           not null, primary key
#  name :string            not null
#  game_maker_id :integer  not null


class User < ApplicationRecord

    has_many :scores,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Score

    has_many :games_made,
        primary_key: :id,
        foreign_key: :game_maker_id,
        class_name: :Game,
        optional: true

end

class Score < ApplicationRecord

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :game,
        primary_key: :id,
        foreign_key: :game_id,
        class_name: :Game

end

class Game < ApplicationRecord

    has_many :scores,
        primary_key: :id,
        foreign_key: :game_id,
        class_name: :Score

    belongs_to :game_maker,
        primary_key: :id,
        foreign_key: :game_maker_id,
        class_name: :User

end
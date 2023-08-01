/*
Stage 1: Adult and smart

Description
We need students to help defend the school. 
In this stage, find the 3rd-year students who 
have passed the courses of the semester with the best grades.

Objectives
Find students who are in 3rd grade and have 5 points for all their courses. 
The output should consist of the student names only in alphabetical order.

Hint:
Grade and semester columns show the year of the students. 
Result column shows the student's grade in the course. 
*/

WITH result_avg AS (
    SELECT 
        student_id,
        AVG(result) AS score_avg
    FROM 
        Student_Subject
    GROUP BY 
        student_id
    HAVING 
        score_avg = 5.0 AND
        semester = 3
    )
SELECT 
    name
FROM 
    Students
WHERE 
    student_id IN (
        SELECT student_id
        FROM result_avg
        )
ORDER BY 
    name ASC;

/*
Stage 2: Best students

Description
The student efforts were insufficient to defend the school, so we need more students. 
To find them, you need to consider the student achievements. 
They need you to calculate them!

Objectives
Find four students with the most achievement points and 
list their names in alphabetical order with their scores. 
The student's year is not critical. 
The output should have only the name and the bonus point column. 
The output should be in descending order of the bonus point column.
*/

SELECT 
    Students.name, 
    SUM(Achievement.bonus) AS 'bonus point'
FROM 
    Students
INNER JOIN Student_Achievement
    ON Students.student_id = Student_Achievement.student_id
INNER JOIN Achievement
    ON Student_Achievement.achievement_id = Achievement.achievement_id
GROUP BY 
    Students.name
ORDER BY 
    SUM(Achievement.bonus) DESC, 
    Students.name
LIMIT 4;

/*
Stage 3: More students

Description
We've successfully repelled the attack, but the second wave is coming, and the students are tired. 
We need new students! Of course, it is you who must find these students.

Objectives
If the student's average is over 3.5 points for courses, output above average in the best column. 
Otherwise, print below average. Order the results in alphabetical order by name.
*/

WITH avg_result AS (
    SELECT 
        student_id,
        AVG(result) AS score_avg
    FROM 
        Student_Subject
    GROUP BY 
        student_id
    )
    SELECT 
        name, 
        CASE 
            WHEN avg_result.score_avg > 3.5 THEN 'above average'
            ELSE 'below average'
            END AS 'best'
    FROM
        Students
    INNER JOIN avg_result
        ON Students.student_id = avg_result.student_id
    ORDER BY
        name ASC;
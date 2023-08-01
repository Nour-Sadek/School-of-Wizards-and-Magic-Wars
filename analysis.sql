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

/* 2023/02/21 */

/* HR계정 서브쿼리 문제 */
SELECT * FROM employees;
SELECT * FROM departments;

-- 1. EMPLOYEES 테이블에서 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력
SELECT department_id, MIN(salary)
    FROM employees
    GROUP BY department_id
        HAVING MIN(salary) > (SELECT MIN(salary) 
                                FROM employees 
                                GROUP BY department_id 
                                    HAVING department_id = 100);
-- 강사님 답
SELECT department_id, MIN(salary)
    FROM employees
    GROUP BY department_id
        HAVING MIN(salary) > (SELECT MIN(salary)
                                FROM employees
                                WHERE department_id = 100);

--2. EMPLOYEES 와 DEPARTMENTS 테이블에서 업무가 SA_MAN 사원의 정보를 성명, 업무, 부서명, 근무지를 출력
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as NAME, job_id, department_name, location_id
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE job_id = (SELECT job_id
                        FROM employees
                        GROUP BY job_id
                            HAVING job_id = 'SA_MAN'); -- 서브쿼리 필요 없이 그냥 'SA_MAN'해도 됨! 
-- 강사님 답
SELECT e.first_name || ' ' || e.last_name AS "성명", e.job_id, d.department_id, d.location_id
    FROM employees e JOIN departments D
    ON e.department_id = d.department_id
    WHERE e.job_ID = 'SA_MAN';


--3. EMPLOYEES 테이블에서 (가장 많은 사원)을 갖는 MANAGER의 사원번호를 출력
SELECT manager_id
    FROM employees
    GROUP BY manager_id
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) -- 블로그에서 봤는데, 강사님 답 처럼 = 보다 IN을 쓰는게 더 낫다고 했음 !
                                FROM employees
                                GROUP BY manager_id);   
-- 강사님 답
SELECT manager_id, COUNT(*)
    FROM employees
    GROUP BY manager_id
        HAVING COUNT(*) IN (SELECT MAX(COUNT(*))
                                FROM employees
                                GROUP BY manager_id); 


-- 4. EMPLOYEES 테이블에서 (가장 많은 사원이 속해있는 부서번호)와 사원수를 출력
SELECT department_id, COUNT(*)
    FROM employees
    GROUP BY department_id
        HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                             FROM employees
                             GROUP BY department_id);
-- 강사님 답
    -- = 대신 IN! 

-- 5. 직업(JOB)별로 최소급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력 (직업별로 내림차순)
    -- [참고] IN 연산자를 사용해 job_id와 급여가 해당 job_id 중 최소 급여와 일치하는 직원만 필터링
SELECT e.employee_id, e.first_name, e.job_id, d.department_name
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE(job_id, salary) IN (SELECT job_id, MIN(salary)
                                  FROM employees
                                  GROUP BY job_id)
    ORDER BY job_id DESC;                              


-- 6. EMPLOYEES 테이블서 (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 는 사원의 사원번호, 이름, 업무, 입사일자, 급여, 부서번호를 출력 (단, 50번은 제외)
SELECT employee_id, first_name, job_id, hire_date, salary, department_id
    FROM employees
    WHERE salary > (SELECT MAX(salary)
                        FROM employees
                        GROUP BY department_id
                            HAVING department_id = 50)
    AND department_ID != 50;






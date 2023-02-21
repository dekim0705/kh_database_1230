/* 2023/02/21 */

/* HR���� �������� ���� */
SELECT * FROM employees;
SELECT * FROM departments;

-- 1. EMPLOYEES ���̺��� 100�� �μ��� �ּ� �޿����� �ּ� �޿��� ���� �ٸ� ��� �μ��� ���
SELECT department_id, MIN(salary)
    FROM employees
    GROUP BY department_id
        HAVING MIN(salary) > (SELECT MIN(salary) 
                                FROM employees 
                                GROUP BY department_id 
                                    HAVING department_id = 100);
-- ����� ��
SELECT department_id, MIN(salary)
    FROM employees
    GROUP BY department_id
        HAVING MIN(salary) > (SELECT MIN(salary)
                                FROM employees
                                WHERE department_id = 100);

--2. EMPLOYEES �� DEPARTMENTS ���̺��� ������ SA_MAN ����� ������ ����, ����, �μ���, �ٹ����� ���
SELECT CONCAT(first_name, CONCAT(' ', last_name)) as NAME, job_id, department_name, location_id
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE job_id = (SELECT job_id
                        FROM employees
                        GROUP BY job_id
                            HAVING job_id = 'SA_MAN'); -- �������� �ʿ� ���� �׳� 'SA_MAN'�ص� ��! 
-- ����� ��
SELECT e.first_name || ' ' || e.last_name AS "����", e.job_id, d.department_id, d.location_id
    FROM employees e JOIN departments D
    ON e.department_id = d.department_id
    WHERE e.job_ID = 'SA_MAN';


--3. EMPLOYEES ���̺��� (���� ���� ���)�� ���� MANAGER�� �����ȣ�� ���
SELECT manager_id
    FROM employees
    GROUP BY manager_id
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) -- ��α׿��� �ôµ�, ����� �� ó�� = ���� IN�� ���°� �� ���ٰ� ���� !
                                FROM employees
                                GROUP BY manager_id);   
-- ����� ��
SELECT manager_id, COUNT(*)
    FROM employees
    GROUP BY manager_id
        HAVING COUNT(*) IN (SELECT MAX(COUNT(*))
                                FROM employees
                                GROUP BY manager_id); 


-- 4. EMPLOYEES ���̺��� (���� ���� ����� �����ִ� �μ���ȣ)�� ������� ���
SELECT department_id, COUNT(*)
    FROM employees
    GROUP BY department_id
        HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                             FROM employees
                             GROUP BY department_id);
-- ����� ��
    -- = ��� IN! 

-- 5. ����(JOB)���� �ּұ޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ��� (�������� ��������)
    -- [����] IN �����ڸ� ����� job_id�� �޿��� �ش� job_id �� �ּ� �޿��� ��ġ�ϴ� ������ ���͸�
SELECT e.employee_id, e.first_name, e.job_id, d.department_name
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    WHERE(job_id, salary) IN (SELECT job_id, MIN(salary)
                                  FROM employees
                                  GROUP BY job_id)
    ORDER BY job_id DESC;                              


-- 6. EMPLOYEES ���̺� (50�� �μ��� �ְ� �޿�)�� �޴� ��� ���� ���� �޿��� �� ����� �����ȣ, �̸�, ����, �Ի�����, �޿�, �μ���ȣ�� ��� (��, 50���� ����)
SELECT employee_id, first_name, job_id, hire_date, salary, department_id
    FROM employees
    WHERE salary > (SELECT MAX(salary)
                        FROM employees
                        GROUP BY department_id
                            HAVING department_id = 50)
    AND department_ID != 50;






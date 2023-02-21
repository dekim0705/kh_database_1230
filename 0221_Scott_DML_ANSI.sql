/* 2023/02/21 */
/* DML(Data Manipulation Language) 
    CRUD : Create, Read/Retried, Update, Delete/Destroy
    SQL  : INSERT, SELECT,       UPDATE, DELETE
    ���� : ����,    �б�/����,     ����,    ����,�ı�     */
    
/* ������ ���̺� �����ϱ�, ���� ���̺��� ���� �ؼ� ��� */
CREATE TABLE dept_temp
    AS SELECT * FROM dept; -- dept ���̺��� �����ؼ� dept_temp ���̺��� ����
    
/* ������ ���̺� �����ϱ�, ���� ���̺��� ���������� ������ �������� ���� */    
CREATE TABLE emp_temp
    AS SELECT * FROM emp
        WHERE 1 != 1; 
        
        
/* ���̺� ���� */
DROP TABLE dept_temp; -- ���̺� ��ü�� ������ **�����ؾ� ��**



/* INSERT : ���̺� �����͸� �߰��ϴ� INSERT ��. 2���� ����� ����
          : INSERT INTO ���̺��̸� (��1, ��2, ......) VALUES(����  �ش��ϴ� ������,...) */
          
/* INSERT 1. ���̺� ��ϰ� �߰� �� ���� ��� ǥ���ϴ� ��� */
INSERT INTO dept_temp(deptno, dname, loc) VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO dept_temp(loc, deptno) VALUES('BUSAN', 60); -- ���ϴ� ���� ���� ���� 

/* INSER 2. ���̺� ���� ���� ��Ͼ��� ���� ǥ��, �� ��Ͽ� ���� ��� ���� ���ʴ�� ���� �� */
INSERT INTO dept_temp VALUES(70, 'DEVELOPER', 'SUWON');
INSERT INTO dept_temp VALUES(80, 'GUEST', 'INCHEON');

/* INSERT NULL : ���̺� NULL ������ �Է� �ϱ� */
INSERT INTO dept_temp VALUES(90, 'WEB', NULL);
INSERT INTO dept_temp VALUES(91, 'MOBILE', NULL);
INSERT INTO dept_temp(deptno, loc) VALUES(92, 'ULSAN');

-- emp_temp ���̺� Ȱ��
/* ��¥������ �Է� : 4���� ��� */
    -- ��¥������ �Է�1: YYYY/MM/DD����
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES(9001, '������', 'PRESIDENT', NULL, '2020/01/01', 9900, 1000, 10);
    -- ��¥������ �Է�2: YYYY-MM-DD����
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '������', 'MANAGER', 9999, '2020-04-05', 5500, 800, 20);
    -- ��¥������ �Է�3: TO_DATE �Լ� ���
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '�̹�', 'MANAGER', 9999, TO_DATE('2020-04-05', 'YYYY/MM/DD'), 5500, 800, 20);
    -- ��¥������ �Է�4: SYSDATE ���
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '������', 'MANAGER', 9999, SYSDATE, 5500, 800, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '�̿���', 'MANAGER', 9999, SYSDATE, 7000, 500, 20);

/* UPDATE : ���̺� �ִ� �����͸� �����ϴ� INSERT��
          : UPDATE [������ ���̺�] SET [������ ��] = [������ ������],... WHERE ����*/
UPDATE dept_temp 
    SET loc = 'SEOUL'; -- ��� loc�� SEOUL�� ����
UPDATE dept_temp
    SET loc = 'BUSAN'
    WHERE dname = 'WEB'; -- WHERE�� ����Ͽ� WEB�� loc�� ����
UPDATE dept_temp
    SET dname = 'ANDROID', 
        loc = 'DAEGU'
    WHERE deptno = 60; -- 2���̻��� SET
UPDATE dept_temp
    SET (dname, loc) = (SELECT dname, loc
                            FROM dept
                            WHERE deptno = 40) -- SET�� ��������
    WHERE deptno = 40;                        
-- dept_temp�� �ִ� deptno�� 40���� dname�� loc�� dept���̺��ִ� deptno�� 40�� dname�� loc���� ����

/* DELETE : ���̺� �ִ� �����͸� �����ϴ� DELETE�� */
CREATE TABLE emp_temp2 AS SELECT * FROM emp; -- ���̺����
SELECT * FROM emp_temp2; -- ������ ���̺� Ȯ��
DELETE FROM emp_temp2; -- emp_temp2���̺� ���� ������ ��� ���� 
DROP TABLE emp_temp2; -- ���̺���ü�� ����
 
DELETE FROM emp_temp2
    WHERE job = 'MANAGER'; -- job�� MANAGER�� �� ����
    
/* ���������� ����Ͽ� ������ ���� �ϱ� */
DELETE FROM emp_temp2
    WHERE empno IN (SELECT e.empno
                        FROM emp_temp2 e, salgrade s
                        WHERE e.sal BETWEEN s.losal AND s.hisal
                        AND s.grade = 3
                        AND deptno = 30);
SELECT * FROM EMP_TEMP2;





/* DELETE : ���̺��� �����͸� �����ϴ� DELETE ��    */
DELETE FROM dept_temp
    WHERE deptno = 50;

-- Ȯ�ο�
SELECT * FROM emp_temp;
SELECT * FROM dept_temp;
DESCRIBE dept_temp;
DESC emp_temp;
DESC dept_temp;

/* DML �������� */
CREATE TABLE ex_emp 
    AS SELECT * FROM emp;
CREATE TABLE ex_dept
    AS SELECT * FROM dept;
CREATE TABLE ex_salgrade
    AS SELECT * FROM salgrade;

-- 1. ex.dept ���̺� 50,60,70,80�� ����ϴ� SQL�� �ۼ�
SELECT * FROM ex_dept;
INSERT INTO ex_dept(deptno, dname, loc) VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO ex_dept VALUES(60, 'SQL', 'ILSAN');
INSERT INTO ex_dept VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO ex_dept VALUES(90, 'DML', 'BUNDANG');

-- 2. ex_emp���̺� ���� 8���� ��� ������ ����ϴ� SQL�� �ۼ�
SELECT * FROM ex_emp;
INSERT INTO ex_emp VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02', 4500, NULL, 50);
INSERT INTO ex_emp VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21', 1800, NULL, 50);
INSERT INTO ex_emp VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11', 3400, NULL, 60);
INSERT INTO ex_emp VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31', 2700, 300, 60);
INSERT INTO ex_emp VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20', 2600, NULL, 70);
INSERT INTO ex_emp VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08', 2600, NULL, 70);
INSERT INTO ex_emp VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28', 2300, NULL, 80);
INSERT INTO ex_emp VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, '2018/03/09', 1200, NULL, 80);

-- 3. ex_emp�� ���� ��� �� 50�� �μ����� �ٹ��ϴ� ������� ��� �޿����� ���� �޿��� �ް� �ִ� �������
    -- 70�� �μ��� �ű�� SQL���� �ۼ� �ϼ���.
SELECT AVG(sal)
    FROM ex_emp
    GROUP BY deptno
        HAVING deptno = 50;

UPDATE ex_emp
    SET deptno = 70
    WHERE sal > (SELECT AVG(sal)
                    FROM ex_emp
                    WHERE deptno = 50);
                    
-- 4. ex_emp�� ���� ��� ��, 60�� �μ��� ��� �߿� �Ի����� ���� ���� ������� �ʰ� �Ի��� ����� �޿���
    -- 10% �λ��ϰ� 80���μ��� �ű�� SQL�� �ۼ�
SELECT MIN(hiredate)
    FROM ex_emp
    WHERE deptno = 60;
    
SELECT ename, hiredate, sal, sal*1.1
    FROM ex_emp
    WHERE hiredate > (SELECT MIN(hiredate)
                        FROM ex_emp
                        WHERE deptno = 60);
                        
UPDATE ex_emp
    SET sal = sal*1.10, 
        deptno = 80
    WHERE hiredate > (SELECT MIN(hiredate)
                        FROM ex_emp
                        WHERE deptno = 60);

-- 5. ex_emp�� ���� ��� ��, �޿� ����� 5�� ����� �����ϴ� SQL�� �ۼ�
SELECT * FROM ex_salgrade;

SELECT ename, sal, grade FROM ex_emp e, ex_salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal AND grade = 5;
SELECT ename, sal, grade FROM ex_emp e JOIN ex_salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE grade = 5;

DELETE FROM ex_emp
    WHERE empno IN (SELECT e.empno
                        FROM ex_emp e, ex_salgrade s
                        WHERE e.sal BETWEEN s.losal AND s.hisal
                        AND s.grade = 5);


        



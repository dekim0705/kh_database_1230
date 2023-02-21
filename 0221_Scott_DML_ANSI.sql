/* 2023/02/21 */
/* DML(Data Manipulation Language) 
    CRUD : Create, Read/Retried, Update, Delete/Destroy
    SQL  : INSERT, SELECT,       UPDATE, DELETE
    조작 : 생성,    읽기/인출,     갱신,    삭제,파괴     */
    
/* 연습용 테이블 생성하기, 기존 테이블을 복사 해서 사용 */
CREATE TABLE dept_temp
    AS SELECT * FROM dept; -- dept 테이블을 복사해서 dept_temp 테이블을 만듬
    
/* 연습용 테이블 생성하기, 기존 테이블을 복사하지만 내용은 복사하지 않음 */    
CREATE TABLE emp_temp
    AS SELECT * FROM emp
        WHERE 1 != 1; 
        
        
/* 테이블 삭제 */
DROP TABLE dept_temp; -- 테이블 자체를 삭제함 **조심해야 함**



/* INSERT : 테이블에 데이터를 추가하는 INSERT 문. 2가지 방법이 있음
          : INSERT INTO 테이블이름 (열1, 열2, ......) VALUES(열에  해당하는 데이터,...) */
          
/* INSERT 1. 테이블 목록과 추가 할 값을 모두 표기하는 방법 */
INSERT INTO dept_temp(deptno, dname, loc) VALUES(50, 'DATABASE', 'SEOUL');
INSERT INTO dept_temp(loc, deptno) VALUES('BUSAN', 60); -- 원하는 값만 삽입 가능 

/* INSER 2. 테이블 열에 대한 목록없이 값만 표기, 열 목록에 대한 모든 값이 차례대로 들어가야 함 */
INSERT INTO dept_temp VALUES(70, 'DEVELOPER', 'SUWON');
INSERT INTO dept_temp VALUES(80, 'GUEST', 'INCHEON');

/* INSERT NULL : 테이블에 NULL 데이터 입력 하기 */
INSERT INTO dept_temp VALUES(90, 'WEB', NULL);
INSERT INTO dept_temp VALUES(91, 'MOBILE', NULL);
INSERT INTO dept_temp(deptno, loc) VALUES(92, 'ULSAN');

-- emp_temp 테이블 활용
/* 날짜데이터 입력 : 4가지 방법 */
    -- 날짜데이터 입력1: YYYY/MM/DD형식
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES(9001, '나영석', 'PRESIDENT', NULL, '2020/01/01', 9900, 1000, 10);
    -- 날짜데이터 입력2: YYYY-MM-DD형식
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '이은지', 'MANAGER', 9999, '2020-04-05', 5500, 800, 20);
    -- 날짜데이터 입력3: TO_DATE 함수 사용
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '미미', 'MANAGER', 9999, TO_DATE('2020-04-05', 'YYYY/MM/DD'), 5500, 800, 20);
    -- 날짜데이터 입력4: SYSDATE 사용
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '안유진', 'MANAGER', 9999, SYSDATE, 5500, 800, 20);
INSERT INTO emp_temp(empno, ename, job, mgr, hiredate, sal, comm, deptno)
        VALUES (9002, '이영지', 'MANAGER', 9999, SYSDATE, 7000, 500, 20);

/* UPDATE : 테이블에 있는 데이터를 수정하는 INSERT문
          : UPDATE [변경할 테이블] SET [변경할 열] = [변경할 데이터],... WHERE 조건*/
UPDATE dept_temp 
    SET loc = 'SEOUL'; -- 모든 loc이 SEOUL로 변경
UPDATE dept_temp
    SET loc = 'BUSAN'
    WHERE dname = 'WEB'; -- WHERE절 사용하여 WEB의 loc만 변경
UPDATE dept_temp
    SET dname = 'ANDROID', 
        loc = 'DAEGU'
    WHERE deptno = 60; -- 2개이상의 SET
UPDATE dept_temp
    SET (dname, loc) = (SELECT dname, loc
                            FROM dept
                            WHERE deptno = 40) -- SET에 서브쿼리
    WHERE deptno = 40;                        
-- dept_temp에 있는 deptno가 40번인 dname과 loc을 dept테이블에있는 deptno가 40인 dname과 loc으로 변경

/* DELETE : 테이블에 있는 데이터를 삭제하는 DELETE문 */
CREATE TABLE emp_temp2 AS SELECT * FROM emp; -- 테이블생성
SELECT * FROM emp_temp2; -- 생성된 데이블 확인
DELETE FROM emp_temp2; -- emp_temp2테이블 안의 내용을 모두 삭제 
DROP TABLE emp_temp2; -- 테이블자체를 삭제
 
DELETE FROM emp_temp2
    WHERE job = 'MANAGER'; -- job이 MANAGER인 행 삭제
    
/* 서브쿼리를 사용하여 데이터 삭제 하기 */
DELETE FROM emp_temp2
    WHERE empno IN (SELECT e.empno
                        FROM emp_temp2 e, salgrade s
                        WHERE e.sal BETWEEN s.losal AND s.hisal
                        AND s.grade = 3
                        AND deptno = 30);
SELECT * FROM EMP_TEMP2;





/* DELETE : 테이블에서 데이터를 삭제하는 DELETE 문    */
DELETE FROM dept_temp
    WHERE deptno = 50;

-- 확인용
SELECT * FROM emp_temp;
SELECT * FROM dept_temp;
DESCRIBE dept_temp;
DESC emp_temp;
DESC dept_temp;

/* DML 연습문제 */
CREATE TABLE ex_emp 
    AS SELECT * FROM emp;
CREATE TABLE ex_dept
    AS SELECT * FROM dept;
CREATE TABLE ex_salgrade
    AS SELECT * FROM salgrade;

-- 1. ex.dept 테이블에 50,60,70,80을 등록하는 SQL문 작성
SELECT * FROM ex_dept;
INSERT INTO ex_dept(deptno, dname, loc) VALUES(50, 'ORACLE', 'BUSAN');
INSERT INTO ex_dept VALUES(60, 'SQL', 'ILSAN');
INSERT INTO ex_dept VALUES(70, 'SELECT', 'INCHEON');
INSERT INTO ex_dept VALUES(90, 'DML', 'BUNDANG');

-- 2. ex_emp테이블에 다음 8명의 사원 정보를 등록하는 SQL문 작성
SELECT * FROM ex_emp;
INSERT INTO ex_emp VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016/01/02', 4500, NULL, 50);
INSERT INTO ex_emp VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016/02/21', 1800, NULL, 50);
INSERT INTO ex_emp VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016/04/11', 3400, NULL, 60);
INSERT INTO ex_emp VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016/05/31', 2700, 300, 60);
INSERT INTO ex_emp VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016/07/20', 2600, NULL, 70);
INSERT INTO ex_emp VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016/09/08', 2600, NULL, 70);
INSERT INTO ex_emp VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016/10/28', 2300, NULL, 80);
INSERT INTO ex_emp VALUES(7208, 'TEST_USER8', 'STUDENT', 7201, '2018/03/09', 1200, NULL, 80);

-- 3. ex_emp에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고 있는 사원들을
    -- 70번 부서로 옮기는 SQL문을 작성 하세요.
SELECT AVG(sal)
    FROM ex_emp
    GROUP BY deptno
        HAVING deptno = 50;

UPDATE ex_emp
    SET deptno = 70
    WHERE sal > (SELECT AVG(sal)
                    FROM ex_emp
                    WHERE deptno = 50);
                    
-- 4. ex_emp에 속한 사원 중, 60번 부서의 사원 중에 입사일이 가장 빠른 사원보다 늦게 입사한 사원의 급여를
    -- 10% 인상하고 80번부서로 옮기는 SQL문 작성
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

-- 5. ex_emp에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문 작성
SELECT * FROM ex_salgrade;

SELECT ename, sal, grade FROM ex_emp e, ex_salgrade s WHERE e.sal BETWEEN s.losal AND s.hisal AND grade = 5;
SELECT ename, sal, grade FROM ex_emp e JOIN ex_salgrade s ON e.sal BETWEEN s.losal AND s.hisal WHERE grade = 5;

DELETE FROM ex_emp
    WHERE empno IN (SELECT e.empno
                        FROM ex_emp e, ex_salgrade s
                        WHERE e.sal BETWEEN s.losal AND s.hisal
                        AND s.grade = 5);


        



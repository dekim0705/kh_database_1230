/* 2022/02/17 금요일 */
    
/* 집합 연산자 : 두 개 이상의 쿼리 결과를 하나로 결합하는 연산자
    UNION     : 합집합, 중복 제거
    UNION ALL : 합집합, 중복제거 하지 않음
    MINUS     : 차집합
    INTERSECT : 교집합
                                                            */   
/* UNION(합집합) : 중복 제거*/
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 20;
        
-- UNION : 열의 개수나 자료가 다르면 안됨 
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION    
SELECT ename, empno, deptno, sal
    FROM emp
    WHERE deptno = 10;

/* UNION ALL(합집합) : 중복제거 없음 */
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION ALL
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE ENAME = 'FORD';
    
/* INTERSECT(교집합) 두개의 쿼리문에 모두 포함되어 있는 데이터를 표시 */
SELECT empno, ename, sal
    FROM emp
    WHERE sal > 1000
INTERSECT
SELECT empno, ename, sal
    FROM emp
    WHERE SAL < 2000;
    
/* MINUS(차집합) : 앞의 쿼리문 결과에서 뒤의 쿼리문 결과를 뺀 것 */
SELECT empno, ename, sal
    FROM emp
MINUS
SELECT empno, ename, sal
    FROM emp
    WHERE sal > 2000;


/* JOIN : 두 개 이상의 테이블에서 데이터를 가져와서 PK와 FK값을 사용하여 조인 */    
/* 테이블 식별 값 Primary Key : IS NOT NULL, unique
   테이블 간 공통 값 Foreign Key : PK of a table */
/* INNER JOIN : 두 테이블에서 일치하는 데이터만 선택
   LEFT JOIN  : 왼쪽 테이블의 모든 데이터와 오른쪽 데이터에서 일치하는 데이터를 선택
   RIGHT JOIN : 오른쪽 테이블의 모든 데이터와 왼쪽 테이블에서 일치하는 데이터를 선택 */


/* CROSS JOIN (카테시안 곱) : 조인 조건이 정해져있지 않아서 두 개의 테이블의 모든열이 결합되어 테이터 * 데이터 만큼의 결과가 표시됨   */
SELECT * 
    FROM emp, dept; -- emp * dept

/* INNER JOIN */
SELECT *
    FROM emp, dept
    WHERE emp.deptno = dept.deptno; -- emp의 FK, dept의 PK

/* 테이블에 별칭 주기 */
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc -- deptno 중복 X
-- SELECT문에는 별칭이 없어도 되지만 deptno가 두 테이블에서 중복이 되기때문에 deptno는 별칭을 줘야 함 !
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;


/* 등가 조인 : 테이블을 연결한 후에 출력 행을 각 테이블의 특정 열에 일치한 테이터 기준으로 선정하는 바식
            : 1)ANSI JOIN, 2)ORACLE JOIN   
            : ANSI JOIN이 ORACLE JOIN보다 JOIN상태를 알려주는 가독성이 좋음*/ 
            
/* ANSI JOIN (American National Standard Institute) : 오라클 10g 부터 사용 가능 */            
SELECT empno, ename, job, e.deptno, dname, loc 
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno  
    WHERE job = 'MANAGER';
/* ORACLE JOIN : 오라클 9i 까지는 오라클 조인만 사용 가능 했었음 */    
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
    FROM emp e, dept d
    WHERE job = 'MANAGER' 
    AND e.deptno = d.deptno;


-- ANSI와 ORACLE 방식으로 emp와 dept테이블을 조인하고 급여가 3000이상인 사원 정보 출력 (사원번호, 이름, 급여, 입사일, 부서번호, 부서이름
-- ORACLE
SELECT empno 사원번호, ename 이름, sal 급여, hiredate 입사일, e.deptno 부서번호, dname 부서이름
    FROM emp e, dept d
    WHERE e.deptno = d.deptno 
    AND sal >= 3000;
-- ANSI
SELECT empno 사원번호, ename 이름, sal 급여, hiredate 입사일, e.deptno 부서번호, dname 부서이름
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno 
    WHERE sal >= 3000;    
    
-- EMP 테이블 별칭을 E로, DEPT 테이블 별칭은 D로 하여 다음과 같이 등가 조인을 했을 때,
-- 급여가 2500 이하이고 사원 번호가 9999 이하인 사원의 정보가 출력되도록 작성
SELECT empno, ename, sal, d.deptno, dname, loc
    FROM emp E JOIN dept D
    ON E.deptno = D.deptno
    WHERE sal <= 2500 AND empno <= 9999;

SELECT empno, ename, sal, D.deptno, dname, loc
    FROM emp E, dept D
    WHERE E.deptno = D.deptno
    AND sal <= 2500 
    AND empno <= 9999;
    

/* 비등가조인 : 동일 열이 아닌 다른 조건을 사용하여 조인 할 때 사용되며, 자주 사용되지 않음 */
-- 급여에 대한 등급을 표시 하기 위해서는 급여의 금액이 일치 할 수 없으므로 최소와 최대 급여 사이에 있어야 함. 이런경우 BETWEEN a AND b 연산자를 사용하면 처리 가능

SELECT * FROM emp;
SELECT * FROM salgrade;
-- ORACLE JOIN
SELECT ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal AND s.hisal;
-- ANSI JOIN 
SELECT ename, sal, grade
    FROM emp e JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal;


/* 자체 조인 : 같은 테이블을 두번 사용하는 것 */
SELECT e1.empno, e1.ename, e1.mgr,
        e2.empno AS MGR_EMPNO,
        e2.ename AS MGR_ENAME
    FROM emp e1, emp e2
    WHERE e1.mgr = e2.empno;

SELECT e1.empno, e1.ename, e1.mgr,
        e2.empno AS MGR_EMPNO,
        e2.ename AS MGR_ENAME
    FROM emp e1 JOIN emp e2
    ON e1.mgr = e2.empno;

/* OUTER JOIN(외부조인)  : INNER JOIN 또는 동등 조인의 경우 한쪽의 컬럼(열)에 값이 없다면 조회 불가
                        : 외부조인은 공통되지 않은 열도 표시 함*/
-- 동등 조인
SELECT ename, e.deptno, dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno;
    
/* RIGHT OUTER JOIN : 합치기에 사용한 두 테이블 중 오른쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN */
-- ANSI JOIN
SELECT ename, e.deptno, dname
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno; -- dname 'OPERATIONS'가 마지막 줄에 나타남 : dept 테이블에 deptno=40 으로 있는 OPERATIONS! 
-- ORACLE JOIN
SELECT ename, e.deptno, dname
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno
    ORDER BY e.deptno;

/* LEFT OUTER JOIN : 합치기에 사용한 두 테이블 중 왼쪽에 기술된 테이블의 컬럼 수를 기준으로 JOIN */    
-- ANSI JOIN
SELECT ename, e.deptno, dname
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno; -- emp 테이블에 추가로 있는 값이 없어서 추가 행이
-- ORACLE JOIN
SELECT ename, e.deptno, dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno(+)
    ORDER BY e.deptno;


    
/* 연습문제 */
-- 1. 사원번호가 7499인 사원의 이름, 입사일 부서번호 출력
SELECT ename, hiredate, deptno
    FROM emp
    WHERE empno = 7499;

-- 2. 이름이 ALLEN인 사원의 모든 정보 출력
SELECT *
    FROM emp
    WHERE ename = 'ALLEN';
    
-- 3. 이름이 K보다 큰 글자로 시작하는 사원의 모든 정보 출력
SELECT *
    FROM emp
    WHERE SUBSTR(ename, 1, 1) > 'K';
-- 강사님 답
SELECT *
    FROM emp
    WHERE ename > 'K';
    
-- 4. 입사일이 81년 4월2일 보다 늦고, 82년 12월9일 보다 빠른 사원의 이름, 급여, 부서번호 출력
SELECT ename, sal, deptno, hiredate
    FROM emp
    WHERE hiredate > TO_DATE('1981/04/02', 'YYYY,MM,DD') 
    AND hiredate < TO_DATE('1982/12/09', 'YYYY,MM,DD');
-- 강사님 답
SELECT ename, sal, deptno, hiredate
    FROM emp
    WHERE hiredate > '81/04/02' AND hiredate < '82/12/09';
    
-- 5. 급여가 1,600 보다 크고, 3000보다 작은 사원의 이름, 직무, 급여를 출력
SELECT ename, job, sal
    FROM emp
--    WHERE sal > 1600
--    AND sal < 3000;
    WHERE sal BETWEEN 1601 AND 2999;
                    
-- 6. 입사일이 81년 이외에 입사한 사원의 모든 정보 출력
SELECT *
    FROM emp
    WHERE EXTRACT(YEAR FROM hiredate) != '1981';

-- 7. 직업이 MANAGER와 SALESMAN인 사원의 모든 정보를 출력     
SELECT *
    FROM emp
    WHERE job IN ('MANAGER', 'SALESMAN'); 
    
-- 8. 부서가 20번, 30번을 제외한 모든 사원의 이름, 사원번호, 부서번호를 출력
SELECT ename, empno, deptno
    FROM emp
    WHERE deptno NOT IN (20, 30); 
    
-- 9. 이름이 S로 시작하는 사원의 사원번호, 이름, 부서번호 출력
SELECT empno, ename, deptno
    FROM emp
    WHERE SUBSTR(ename, 1, 1) = 'S';
-- 강사님 답
SELECT empno, ename, deptno
    FROM emp
    WHERE ename LIKE 'S%';
    
-- 10. 처음 글자는 관계없고, 두 번째 글자가 A인 사원의 모든 정보를 출력
SELECT *
    FROM emp
    WHERE ename LIKE '_A%';

-- 11. 커미션이 NULL이 아닌 사원의 모든 정보를 출력
SELECT *
    FROM emp
    WHERE comm IS NOT NULL;
    
-- 12. 이름이 J자로 시작하고 마지막 글자가 S인 사원의 모든 정보를 출력
SELECT *
    FROM emp
    WHERE ename LIKE 'J%' 
    AND ename LIKE '%S';
-- 강사님 답
SELECT *
    FROM emp
    WHERE ename LIKE 'J%S';

-- 13. 급여가 1500이상이고, 부서번호가 30번인 사원 중 직무가 MANAGER인 사원의 모든 정보 출력
SELECT *
    FROM emp
    WHERE sal >= 1500
    AND deptno = 30
    AND job = 'MANAGER';

-- 14. 모든 사원의 이름, 급여, 커미션, 총액(급여+커미션)을 구하여 총액이 많은 순서로 출력 
--     (단, 커미션이 null인 사원도 0으로 포함)
SELECT ename, sal, NVL(comm, 0), NVL(sal+comm, sal+0) 총액
    FROM emp
    ORDER BY 4 DESC;
-- 강사님 답    
SELECT ename, sal, NVL(comm, 0), sal+NVL(comm,0) AS "총액"
    FROM emp
    ORDER BY "총액" DESC;    

-- 15. 10번 부서의 모든 사원에게 급여의 13%를 보너스로 지불하기로 하였다. 
--     10번 부서 사원들의 이름, 급여, 보너스, 부서번호 출력
SELECT ename, sal, sal*1.13 보너스, deptno
    FROM emp
    WHERE deptno = 10;

-- 16. 모든 사원에 대해 입사한 날로 부터 60일이 지난 후의 ‘월요일’에 대한 년,월,일를 구하여 
--     이름, 입사일, 60일 후의 ‘월요일’ 날짜를 출력    
SELECT ename, hiredate, TO_CHAR(NEXT_DAY(hiredate+60, 2), 'YYYY/MM/DD')
    FROM emp;
-- 강사님 답
SELECT ename, hiredate, NEXT_DAY(hiredate+60, 2) DDAY
    FROM emp;
-- 형식 넣고 싶으면 TO_CHAR, 아니면 그냥 NEXT_DAY로 들어가면 됨 !     
SELECT NEXT_DAY(SYSDATE + 60, 2) FROM dual;    

-- 17. 이름의 글자수가 6자 이상인 사원의 이름을 앞에서 3자만 구하여 소문자로 이름만 출력
SELECT LOWER(SUBSTR(ename, 1, 3)) 
    FROM emp
    WHERE LENGTH(ename) >= 6;

-- 18. 사원들의 사원 번호와 급여, 커미션, 연봉((comm+sal)*12)을 연봉이 많은 순서로 출력
SELECT empno, sal, NVL(comm, 0), NVL(sal*12+comm, sal*12+0)
    FROM emp
    ORDER BY 4 DESC;
-- 강사님 답 (노션, 커미션이 달마다 들어감)   
SELECT empno, sal, NVL(comm, 0), NVL((comm+sal)*12, (0+sal)*12)
    FROM emp
    ORDER BY 4 DESC;    
-- 강사님 답    
SELECT empno, sal, NVL(comm, 0)"커미션", SAL*12+NVL(comm,0)"연봉"
    FROM emp
    ORDER BY "연봉" DESC;      

-- 19. 모든 사원들의 입사한 년/월/일 
SELECT TO_CHAR(hiredate, 'YYYY"년"MM"월"DD"일"')
    FROM emp;
    
-- 20. 10번 부서에 대해 급여의 평균 값, 최대 값, 최소 값, 인원 수를 출력
SELECT deptno, AVG(sal), MAX(sal), MIN(sal), COUNT(*)
    FROM emp
    GROUP BY deptno
        HAVING deptno = 10;
-- 강사님 답        
SELECT ROUND(AVG(sal), 2), MAX(sal), MIN(sal), COUNT(*)
    FROM emp
    WHERE deptno = 10;        
        
-- 21. 사원번호가 짝수인 사원들의 모든 정보를 출력
SELECT *   
    FROM emp
    WHERE MOD(empno, 2) = 0;
    
-- 22. 각 부서별 같은 직무를 갖는 사원의 인원수를 구하여 부서 번호, 직무, 인원수 출력
SELECT deptno, job, COUNT(*)
    FROM emp
    GROUP BY deptno, job;

-- 23. EMP와 DEPT테이블을 조인하여 모든 사원에 대해 부서 번호, 부서이름, 사원이름 급여를 출력
SELECT d.deptno, dname, ename, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno;

-- 24. 이름이 ‘ALLEN’인 사원의 부서 번호, 부서 이름, 사원 이름, 급여 출력
SELECT d.deptno, dname, ename, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'ALLEN';

-- 25. ‘ALLEN’과 직무가 같은 사원의 이름, 부서 이름, 급여, 부서위치를 출력
SELECT job
    FROM emp
    WHERE ename = 'ALLEN';

SELECT ename, e.job, sal, loc
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE job = (SELECT job
                    FROM emp
                    WHERE ename = 'ALLEN');
       
-- 26. 모든 사원들의 평균 급여 보다 많이 받는 사원들의 사원번호와 이름 출력
SELECT AVG(sal)
    FROM emp;

SELECT empno, ename
    FROM emp
    WHERE sal > (SELECT AVG(sal)
                    FROM emp);
            
-- 27. 부서별 평균 급여가 2000보다 적은 부서 사원들의 부서 번호 출력
SELECT deptno
    FROM emp
    GROUP BY deptno
        HAVING AVG(sal) < 2000;

-- 28. 30번 부서의 최고급여보다 급여가 많은 사원의 사원 번호, 이름, 급여를 출력
SELECT MAX(sal)
    FROM emp
    WHERE deptno = 30;

SELECT empno, ename, sal
    FROM emp
    WHERE sal > (SELECT MAX(sal)
                     FROM emp
                    WHERE deptno = 30);
                  
-- 29. 'FORD’와 부서가 같은 사원들의 이름, 부서 이름, 직무, 급여를 출력  
SELECT dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'FORD';

SELECT ename, dname, e.job, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 
        (SELECT dname
            FROM emp e JOIN dept d
            ON e.deptno = d.deptno
            WHERE ename = 'FORD');
            
SELECT * FROM dept;            
SELECT * FROM emp;
SELECT ename, job, dname, e.deptno
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'FORD';
SELECT *
    FROM emp
    WHERE deptno = 20;

-- 30. 부서 이름이 ‘SALES’인 사원들의 평균 급여 보다 많고, 
--     부서 이름이 ‘RESEARCH’인 사원들의 평균 급여 보다 적은 사원들의 이름, 부서번호, 급여, 직무 출력    
SELECT AVG(sal)
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 'SALES';
    
SELECT AVG(sal)
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 'RESEARCH';
    
SELECT ename, deptno, sal, job
    FROM emp
    WHERE sal > (SELECT AVG(sal)
                    FROM emp e JOIN dept d
                    ON e.deptno = d.deptno
                    WHERE dname = 'SALES')
    AND sal < (SELECT AVG(sal)
                 FROM emp e JOIN dept d
                 ON e.deptno = d.deptno
                 WHERE dname = 'RESEARCH');        
                 
SELECT ename, deptno, sal, job
    FROM emp
    WHERE sal BETWEEN 
    (SELECT AVG(sal)
         FROM emp e JOIN dept d
         ON e.deptno = d.deptno
         WHERE dname = 'SALES')
    AND 
    (SELECT AVG(sal)
         FROM emp e JOIN dept d
         ON e.deptno = d.deptno
         WHERE dname = 'RESEARCH');                       
                    


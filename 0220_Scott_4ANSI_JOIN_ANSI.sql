/* 2023/02/22 */
/* ANSI JOIN : 1) NATURAL JOIN
               2) JOIN ~ USING
               3) JOING ~ ON 
               + 오라클JOIN (, WHERE) = 총 4가지 JOIN     */
               
               
/* NATURAL JOIN : 동등 조인과 비슷하지만 WHERE 조건절 없이 조인하는 방식 
                : 두 테이블의 동일한 이름(컬럼 또는 열)을 갖는 컬럼은 모두 조인 됨 
                : deptno열이 양쪽 테이블에 모두 존재 함                      */
                
SELECT empno, ename, dname
    FROM emp NATURAL JOIN dept;
    
-- 일반적인 동등조인인 경우는 아래의 쿼리문의 에러가 발생합니다. deptno가 어디 소속인지 모호성이 발생 함
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc -- 양쪽에 존재하는 deptno열이 NATURAL JOIN으로 묶여져서 에러가 안나나봐..?
    FROM emp NATURAL JOIN dept
    ORDER BY deptno, empno;
    
/* JOIN ~ USING : 기존의 등가 조인을 대신하는 조인 방식
                : FROM table1 JOIN table2 USING(기준열)        */   
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
    FROM emp JOIN dept USING(deptno)
    WHERE sal >= 3000
    ORDER BY deptno, empno;
    
/* JOIN ~ ON : 가장 범용성 있는 JOIN ~ ON 키워드를 사용한 조인 방식
             : FROM table1 JOIN table2 ON (조인 조건식)      */    
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e JOIN dept d
    on e.deptno = d.deptno
    WHERE sal <= 3000
    ORDER BY e.empno, empno;
    
    
/* ANSI OUTER JOIN : 1) LEFT OUTER JOIN
                     2) RIGHT OUTER JOIN                             */
                     
/* LEFT OUTER JOIN : 왼쪽 테이블 기준으로 오른쪽 테이블의 모든 행이 출력 됨 */
-- ORACLE 
SELECT empno, ename, job, mgr, hiredae, sal, comm, e.deptno, dname, loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno(+); -- 왼쪽(e.deptno) 기준으로 오른쪽(d.deptno)에 비어있는걸 채워 넣으라는 의미
-- ANSI
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno;

/* RIGHT OUTER JOIN :  오른쪽 테이블 기준으로 왼쪽 테이블의 모든 행이 출력 됨 */    
-- ORACLE 
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno; 
-- ANSI
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;

/* 연습문제 */
-- 1. 급여(sal)가 2000초과인 사원들의 부서 정보, 사원 정보를 부서번호, 부서이름, 사원이름, 급여 표시 (4가지 JOIN 문법사용)
    -- ORACLE JOIN
SELECT d.deptno 부서번호, dname 부서이름, ename 사원이름, sal 급여
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
    AND sal > 2000;
    -- ANSI JOIN : NATURAL JOIN (WHERE 조건절 없이 JOIN..해야하나?)
SELECT deptno 부서번호, dname 부서이름, ename 사원이름, sal 급여
    FROM emp NATURAL JOIN dept
    WHERE sal > 2000;
    -- ANSI JOIN : JOING ~ USING
SELECT deptno 부서번호, dname 부서이름, ename 사원이름, sal 급여
    FROM emp JOIN dept USING(deptno)
    WHERE sal > 2000;
    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno 부서번호, dname 부서이름, ename 사원이름, sal 급여
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE sal > 2000;

-- 2. 각 부서별 평균 급여, 최대 급여, 최소급여, 사원 수 출력(4가지 JOIN문법사용)
    -- ORACLE JOIN
SELECT d.deptno, dname, ROUND(AVG(sal)) 평균급여, MAX(sal) 최대급여, MIN(sal) 최소급여, COUNT(*) 사원수
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
    GROUP BY d.deptno, dname;

    -- ANSI JOIN : NATURAL JOIN
SELECT deptno, dname, ROUND(AVG(sal)) 평균급여, MAX(sal) 최대급여, MIN(sal) 최소급여, COUNT(*) 사원수
    FROM emp NATURAL JOIN dept
    GROUP BY deptno, dname;

    -- ANSI JOIN : JOING ~ USING
SELECT deptno, dname, ROUND(AVG(sal)) 평균급여, MAX(sal) 최대급여, MIN(sal) 최소급여, COUNT(*) 사원수
    FROM emp JOIN dept USING(deptno)
    GROUP BY deptno, dname;

    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno, dname, ROUND(AVG(sal)) 평균급여, MAX(sal) 최대급여, MIN(sal) 최소급여, COUNT(*) 사원수
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    GROUP BY d.deptno, dname;

-- 3. 모든 부서 정보와 사원 정보를 부서번호, 부서이름, 사원번호, 사원이름, 직책, 급여를 부서번호, 사원 이름순으로 출력 (4가지 JOIN문법 사용)
    -- ORACLE JOIN
SELECT d.deptno 부서번호, dname 부서이름, empno 사원번호, ename 사원이름, job 직책, sal 급여
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
   ORDER BY d.deptno, ename;
    -- ANSI JOIN : NATURAL JOIN)
SELECT deptno 부서번호, dname 부서이름, empno 사원번호, ename 사원이름, job 직책, sal 급여
    FROM emp NATURAL JOIN dept
    ORDER BY ename;
    -- ANSI JOIN : JOING ~ USING
SELECT deptno 부서번호, dname 부서이름, empno 사원번호, ename 사원이름, job 직책, sal 급여
    FROM emp JOIN dept USING(deptno)
    ORDER BY deptno, ename;
    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno 부서번호, dname 부서이름, empno 사원번호, ename 사원이름, job 직책, sal 급여
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY d.deptno, ename;

-- 3번 문제 RIGHT OUTER JOIN 사용해서 deptno 40번 출력
-- ORACLE JOIN
SELECT d.deptno, dname, empno, ename, job, sal
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno
    ORDER BY d.deptno, ename;
-- ANSI JOIN   
SELECT d.deptno, dname, empno, ename, job, sal
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY d.deptno, ename;    
    
    
    
    
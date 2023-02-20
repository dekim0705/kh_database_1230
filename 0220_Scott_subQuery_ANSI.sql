/* 2023/02/20 */
/* 서브쿼리 : SQL문 안에 작성하는 작은 SQL 문을 의미함. 주로 WHERE절에 사용 
           : 서브쿼리는 반드시 괄호(서브쿼리) 안에 넣어 표현                
    서브쿼리의 특징 : 1) 조회 대상의 오른쪽에 놓이며 () 묶어서 사용
                    2) 대부분의 경우 ORDER BY절울 사용할 수 없음
                    3) 메인쿼리의 대상과 서브쿼리의 대상은 같은 자료형이거나 같은 개수로 지정 해야 함
                    4) 서브쿼리와 메인쿼리는 연산자와 함께 상호 작용하는 방식에 따라 단일행 서브 쿼리와 다중행 서브 쿼리 */
                    /* 서브쿼리의 결과로 여러행을 반환할 때에는 다중행 서브쿼리를 사용해야 함. (Ex3에서 ALLEN이 두명 이상일 수도 있음) */  


/* 단일행 서브쿼리(single-row subquesry)는 실행 결과가 단 하나의 행으로 나오는 서브쿼리를 뜻함. 단일행 연산자로 비교 가능 */ 

-- Ex1. ‘KING’인 사원의 부서번호를 조회하는 서브쿼리와 그 결과로 부서명을 조회하는 메인 쿼리
SELECT dname -- 메인 쿼리에서 부서 이름과 부서 번호를 비교해서 원하는 결과를 찾음
    FROM dept
    WHERE deptno = (SELECT deptno  -- 사원의 이름으로 사원이 속한 부서 번호를 찾음(서브쿼리)
                        FROM emp
                        WHERE ename = 'KING');

-- Ex2. 서브쿼리로 'JONES'의 급여보다 높은 급여를 받는 사원 정보 출력하기
SELECT *
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- Ex3. 서브쿼리를 사용하여 EMP 테이블의 사원 정보 중에서 사원 이름이 ALLEN인 사원의 추가 수당 보다 많은 추가 수당을 받는 사원 정보를 구하도록 코드 작성   
SELECT *
    FROM emp
    WHERE comm > (SELECT comm
                    FROM emp 
                    WHERE ename = 'ALLEN');
                    
-- Ex4. JAMES보다 먼저 입사한 사원 정보 출력
SELECT *
    FROM emp
    WHERE hiredate < (SELECT hiredate
                        FROM emp
                        WHERE ename = 'JAMES');
              
-- Ex5. 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 정보와 소속 부서 정보를 조회하는 경우에 대한 쿼리를 작성
SELECT AVG(sal) FROM emp; -- 전체 sal평균 : 2077.08333...  (서브쿼리)          
SELECT empno, ename, job, sal, d.deptno, dname, loc -- 메인쿼리
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE d.deptno = 20
    AND sal > (SELECT AVG(sal)
                    FROM emp);


/* 다중행 서브쿼리(multiple-row subquesry) : 실행 결과 행이 여러 개로 나오는 서브쿼리
   다중행 연산자 : 1) IN        : 메인쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치하면 true
                 2) ANY, SOME : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 true 
                 3) ALL       : 메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족하면 true
                 4) EXITST    : 서브쿼리의 결과가 존재하면(즉, 행이 1개 이상일 경우) true               */
   
   
-- Ex1. 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력 (IN 연산자)
SELECT *
    FROM emp
    WHERE sal IN (SELECT MAX(sal)
                    FROM emp -- 여기까지만 하면 단일행 쿼리, 전체 사원중 최고 급여 = 1개
                    GROUP BY deptno); -- GROUP BY가 추가되어서 부서별로 최고급여가 나옴 = 3개. (부서가 3개니까 각 부서에서 MAX(sal)인 사원들이 출력됨 

-- Ex2. ‘SALESMAN’들의 급여와 같은 급여를 받는 사원을 조회 (ANY 연산자)
SELECT sal FROM emp WHERE job = 'SALESMAN'; -- 1600, 1250, 1250, 1500 (1250보다 높으면 다 나옴)
SELECT *
    FROM emp
    WHERE sal = ANY (SELECT sal -- 서브쿼리의 결과값이 4개, 메인쿼리에서 그 중 하나이상 만족되면 반환
                    FROM emp
                    WHERE job = 'SALESMAN');
 
-- Ex3. 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력 (ANY 연산자)
SELECT MAX(sal) FROM emp WHERE deptno = 30; -- 2850
SELECT *
    FROM emp
    WHERE sal < ANY (SELECT MAX(sal)
                        FROM emp
                        WHERE deptno = 30);               
-- 다중행 서브쿼리 사용
SELECT SAL FROM EMP WHERE DEPTNO = 30; -- 1600, 1250, 1250, 2850, 1500, 950이 나오는데 그 중 2850보다 급여가 적은 사람들만 출력 됨 
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL 
                FROM EMP
                WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
                                        
-- Ex 4. 부서 번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력
SELECT MIN(sal)  FROM emp WHERE deptno = 30;     
SELECT *
    FROM emp
    WHERE sal < ALL (SELECT MIN(sal)
                        FROM emp
                        WHERE deptno = 30);                     
-- 다중행 서브쿼리 사용
SELECT SAL FROM EMP WHERE DEPTNO = 30; -- 1600, 1250, 1250, 2850, 1500, 950
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
-- Ex5. 서브쿼리 결과 값이 존재하는 경우
SELECT *
    FROM emp
    WHERE EXISTS (SELECT dname
                    FROM dept
                    WHERE deptno = 10); -- 10번 부서가 존재하면 모두 다 출력 

-- Ex6. 서브쿼리 결과 값이 존재하지 않는 경우
SELECT *
    FROM emp
    WHERE EXISTS (SELECT dname
                    FROM dept
                    WHERE deptno = 50); -- 50번 부서가 존재하면 모두 다 출력 
                    
                    
/* 다중 열 서브쿼리 : 서브쿼리의 결과가 두 개 이상의 컬럼으로 반환되어 메인 쿼리에 전달 됨  */        
-- Ex1
SELECT deptno, sal FROM emp WHERE deptno = 30;
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE (deptno, sal) IN (SELECT deptno, sal
                            FROM emp
                            WHERE deptno = 30);

-- Ex2. GROUP BY 절이 포함된 다중열 서브쿼리
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;
SELECT *
    FROM emp
    WHERE (deptno, sal) IN (SELECT deptno, MAX(sal)
                            FROM emp
                            GROUP BY deptno);


/* FROM 절에 사용하는 서브 쿼리 
    : 메인 쿼리의 FROM절을 서브쿼리로 이용하는 방법으로 다른 말로는 인라인뷰라고 함.
    : 테이블이 너무 커서 일부분만 사용하고자 하는 경우
    : 보안상 보여주고 싶은 열을 제한 해야 하는 경우                                */
-- Ex1.  
SELECT e.ename, e.ename, e.deptno, d.dname, d.loc
    FROM(SELECT * FROM emp WHERE deptno = 10) e,         
        (SELECT * FROM dept) d
    WHERE e.deptno = d.deptno;    

-- Ex2. 먼저 정렬하고 해당 개수만 가져오기 (급여 내림차순으로 정렬 후 상위 3행 출력)
/* ROWNUM : 오라클에서 일련번호를 부여하기 위해서 사용되는 예약어 (즉, 행번호 매기기) */    
SELECT ROWNUM, ename, sal
    FROM(SELECT * FROM emp ORDER BY sal DESC)
    WHERE ROWNUM <= 3;
    
/* SELECT 절에 사용하는 서브 쿼리
    : SELECT문에서 쓰이는 단일 해 서브쿼리를 스칼라 서브쿼리 라고 함
    : SELECT절에 명시하는 서브쿼리는 반드시 하나의 결과만 반환하도록 작성해야 함      */
SELECT empno, ename, job, sal,
    (SELECT grade 
     FROM salgrade
     WHERE e.sal BETWEEN losal AND hisal) AS SALGRADE,
     deptno,
     (SELECT dname
      FROM dept
      WHERE e.deptno =  dept.deptno) AS DNAME
FROM emp e;  

SELECT * FROM salgrade;

-- Ex2. 매 행마다 부서번호가 각 행의 부서번호와 동일한 사원들의 SAL 평균을 구해서 반환
SELECT ename, deptno, sal, 
    (SELECT TRUNC(AVG(sal)) 
        FROM emp 
        WHERE deptno = e.deptno) AS AVGDEPTSAL
    FROM emp e;
    
-- Ex3. 부서 위치가 NEW YORK 인 경우에 본사로, 그 외 부서는 분점으로 반환
SELECT empno, ename,
    CASE WHEN deptno = (SELECT deptno
                        FROM dept
                        WHERE loc = 'NEW YORK')
        THEN '본사' 
        ELSE '분점' 
    END AS 소속    
FROM emp        
ORDER BY 소속 DESC;



/* 노션에 있는 연습 문제 */                              
-- 1. 전체 사원 중 ALLEN과 같은 직책인 사원들의 사원 정보, 부서 정보 출력
    -- (직책, 사원번호, 이름, 부서번호, 부서이름)
SELECT job, empno, ename, sal, e.deptno, dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno 
    WHERE job = (SELECT job
                    FROM emp
                    WHERE ename = 'ALLEN');

-- 2. 전체 사원의 평균 급여 보다 높은 급여를 받는 사원들의 사원 정보, 부서 정보, 급여 등급 정보를 출력
    -- (사원번호, 사원이름, 부서이름, 입사일, 부서위치, 급여, 급여 등급)
SELECT empno, ename, dname, hiredate, loc, sal, 
    (SELECT grade
        FROM salgrade WHERE e.sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE sal > (SELECT TRUNC(AVG(sal))
                    FROM emp)
    ORDER BY sal DESC, ename;   
-- 강사님 답 (ORACLE)
SELECT empno, ename, dname, hiredate, loc, sal, grade
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT AVG(sal) FROM emp)
    ORDER BY e.sal DESC, e.empno;
-- 강사님 답 (ANSI)
SELECT empno, ename, dname, hiredate, loc, sal, grade
    FROM emp e
    JOIN dept d ON e.deptno = d.deptno
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT AVG(sal) FROM emp)
    ORDER BY e.sal DESC, e.empno;


-- 3. 10번 부서에 근무하는 사원 중 30번 부서에는 존재하지 않는 직책을 가진 사원들의 사원 정보, 부서 정보 출력
    -- (사원번호, 사원이름, 직책, 부서번호, 부서이름, 부서위치)
SELECT empno, ename, job, e.deptno, dname, loc
    FROM (SELECT * FROM emp WHERE deptno = 10)  e
    JOIN dept d
    ON e.deptno = d.deptno
    WHERE job NOT IN (SELECT job 
                        FROM emp
                        WHERE deptno = 30);
-- 강사님 답
SELECT empno, ename, job, e.deptno, dname, loc
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE e.deptno = 10
    AND job NOT IN (SELECT job FROM emp WHERE deptno = 30);

-- 4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 정보 출력
    -- (사원번호, 사원이름, 급여, 급여등급) + 사원 번호 기준으로 오름차순 정렬

-- 다중서브쿼리 사용
SELECT empno, ename, sal, (SELECT grade
        FROM salgrade WHERE sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp
    WHERE sal > ALL (SELECT sal
                        FROM emp
                        WHERE job = 'SALESMAN')
    ORDER BY empno;                    
-- 단일서브쿼리 사용                
SELECT empno, ename, sal, (SELECT grade
        FROM salgrade WHERE sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp
    WHERE sal > (SELECT TRUNC(MAX(sal))
                        FROM emp
                        WHERE job = 'SALESMAN')
    ORDER BY empno;  
-- 강사님 답
SELECT empno, ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN')
    ORDER BY e.empno;
-- 강사님 답 (ANSI)
SELECT empno, ename, sal, grade
    FROM emp e JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal
    WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'SALESMAN')
    ORDER BY e.empno;
    
    
-- salgrade로 혼자 해본거 ;    
SELECT * FROM salgrade;    

SELECT ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN losal AND hisal;

SELECT ename, sal, 
        (SELECT grade FROM salgrade WHERE sal BETWEEN losal AND hisal) grade
    FROM emp
    ORDER BY sal;
    

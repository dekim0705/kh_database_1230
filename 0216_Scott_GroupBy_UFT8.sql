/* 다중행 합수와 데이터 그룹화 :
   다중행 함수 : 여러 행에 대해 함수가 적용되어 하나의 결과를 나타내는 함수 입니다.
              : = 집계 함수  
*/

SELECT* FROM emp;
SELECT ename, sal FROM emp; -- 이름과 급여
SELECT SUM(sal) FROM emp; -- SUM은 결과가 하나만 나옴 
SELECT SUM(sal), ename FROM emp; -- 에러. SUM은 1개, ename은 12개

SELECT deptno, SUM(sal)
    FROM emp; -- 에러
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno; -- deptno단위로 결과 출력 
    
SELECT deptno, AVG(sal)
    FROM emp
    GROUP BY deptno;
    
SELECT job, COUNT(*)
    FROM emp
    GROUP BY job;

SELECT job, MAX(sal)
    FROM emp
    GROUP BY job;

SELECT deptno, MIN(sal)
    FROM emp
    GROUP BY deptno;    
    
/* SUM : 합계를 구하는 함수 
       : SUM의 옵션 1)DISTINCT : 중복 제거, 2)ALL : 사용하지 않아도 기본적으로 ALL 특성을 가짐 
*/
SELECT SAL  FROM EMP;
SELECT SUM(DISTINCT SAL) AS 중복제거, SUM(ALL SAL) AS 전부, SUM(SAL) AS 기본
    FROM EMP;               
    
SELECT SUM(SAL), SUM(COMM) 
    FROM EMP;   
    
SELECT COUNT(*) FROM EMP;  -- 총 몇명인지 확인
SELECT COUNT(COMM) FROM EMP; -- COMM이 NULL이 아닌 사원의 수 (NULL 제외!)

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 부서 번호가 20인 사원의 입사일 중 가장 최근 입사일
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY절 : 하나의 결과를 특정 열을 묶어서 출력하는 것을 '그룹화'한다고 함. 이때 출력해야 할 대상열 지정을 GROUP BY 로 수행 */

-- 부서별 급여 평균 (GROUP BY절 사용)
SELECT TRUNC(AVG(SAL)), DEPTNO
    FROM EMP
    GROUP BY DEPTNO; -- 그룹으로 묶어야 출력이 됨 
-- 부서별 평균 급여 (WHERE절 사용)
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 10;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 20;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 30;

-- 부서 번호 및 직책별 평균 급여로 정렬
SELECT DEPTNO, JOB, TRUNC(AVG(SAL))
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;

-- 부서 번호별 평균 추가 수당을 출력
SELECT DEPTNO, AVG(COMM)
    FROM EMP
    GROUP BY DEPTNO;
-- NULL을 0으로 처리
SELECT DEPTNO, NVL(AVG(COMM), 0)
    FROM EMP
    GROUP BY DEPTNO;

-- 부서 코드, 급여 합계, 부서 평균, 부서 인원수를  부서코드 순으로 정렬
SELECT DEPTNO 부서코드, SUM(SAL) 급여합계, FLOOR(AVG(SAL)) 급여평균, COUNT(*) 인원수
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
/* HAVING 절 : SELECT문에 GROUP BY 절이 존재할 때만 사용 가능 
             : GROUP BY절을 통해 그룹화된 결과 값의 범위를 제한시 사용
*/
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
       
-- WHERE절과 HAVING절을 모두 사용한 경우
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP                -- 첫번째 수행 : 12개 행이 있음
    WHERE SAL <= 3000       -- 두번째 수행 : 행이 11개로 제한이 걸린 상태(SAL이 5000인 CEO가빠짐)
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;  
    
/* 연습문제 */    
-- 1. HAVING절을 사용하여 EMP 테이블의 부서별 직책의 평균 급여가 500 이상인 사원들의 부서 번호, 직책, 부서별 직책의 평균 급여가 출력
SELECT DEPTNO 부서번호, JOB 직책, AVG(SAL) 평균급여
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500
    ORDER BY DEPTNO, JOB; 
    
-- 2. EMP 테이블을 이용하여 부서번호, 평균급여, 최고급여, 최저급여, 사원수를 출력,  단, 평균 급여를 출력 할 때는 소수점 제외하고 부서 번호별로 출력    
SELECT DEPTNO 부서번호, TRUNC(AVG(SAL)) 평균급여, MAX(SAL) 최고급여, MIN(SAL) 최저급여, COUNT(*) 사원수
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
-- 3. 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원를 출력
SELECT JOB 직책, COUNT(*) 인원
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(*) >= 3;    
        
-- 4. 사원들의 입사 연도를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT EXTRACT(YEAR FROM HIREDATE) 입사일, DEPTNO 부서번호, COUNT(*) 사원수
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY COUNT(*);

-- 5. 추가 수당을 받는 사원 수와 받지 않는 사원수를 출력 (O, X로 표기 필요)
SELECT NVL2(COMM, 'O', 'X') 추가수당, COUNT(*) 사원수
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');

--6. 각 부서의 입사 연도별 사원 수, 최고 급여, 급여 합, 평균 급여를 출력
SELECT DEPTNO, EXTRACT(YEAR FROM HIREDATE) 입사년도, COUNT(*) 사원수, 
        MAX(SAL) 최고급여, TRUNC(AVG(SAL)) 평균급여, SUM(SAL) 급여합
        FROM EMP
        GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE);
    

-- 2022/02/17 추가 
/* ROLLUP 함수를 적용한 그룹화 : 명시한 열을 소그룹부터 대그룹의 순서로 각 그룹별 결과를 출력하고 마지막에 총 데이터 결과를 출력 */
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
    FROM EMP
    GROUP BY ROLLUP(deptno, job);

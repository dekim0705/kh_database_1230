/* 2022/02/13 월요일 */

/*주석*/
-- 단일행에 대한 주석

/* 사원 정보 테이블 */ 
DESC EMP; 
/* 보너스 테이블 */ 
DESC BONUS;
/* 급여 정보 테이블 */ 
DESC SALGRADE;

/* SELECT문은 데이터베이스에 저장된 데이터를 조회하는데 사용하는 구문 입니다 */

/* SELECT [조회할 열.....] FROM 조회할 테이블 */
SELECT * FROM EMP;
SELECT EMPNO, ENAME, HIREDATE FROM EMP;
SELECT EMPNO, ENAME FROM EMP;

/* 실습 문제 - 사원 번호와 부서 번호만 나오도록 쿼리문 작성하기 */
SELECT EMPNO, DEPTNO FROM EMP;

/* 별칭(alias) 사용하기 */

SELECT EMPNO "번 호", ENAME "이 름" FROM EMP; -- 공백이나 특수문자 사용 가능
SELECT EMPNO AS 번호, ENAME AS 이름 FROM EMP;
SELECT EMPNO 번호, ENAME 이름 FROM EMP; -- AS 생략 가능

-- 급여, 월급 연봉+커미션, 커미션
SELECT ENAME, SAL, SAL*12+COMM, COMM FROM EMP;
 -- ALIAS 사용
SELECT ENAME, SAL, SAL*12+COMM AS "연☆봉", COMM FROM EMP;


SHOW USER; -- 현재 USER를 표시 함(ORACLE 전용 커맨드)
SELECT * FROM TAB; -- 전체 계정에 대한 테이블 확인 용도

/* 중복 제거(DISTINCT) : 데이터를 조회할 때 값이 중복되는 행이 여러 개 조회되는데, 값이 중복된 행을 한개씩만 선택하고자 할 때 사용하는 키워드 */
SELECT DEPTNO FROM EMP; -- 12명에 대한 모든 부서번호가 나옴
SELECT DISTINCT DEPTNO FROM EMP; -- 부서번호 중복 제거

SELECT JOB, DEPTNO FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP; -- 두가지 조건에 대한 중복 제거

/* 컬럼값 계산하는 산술연산자(+, -, *, /) : 자료형이 숫자인 컬럼값들을 계산한 값을 조회하고자 할 때 사용*/
SELECT ENAME, SAL, SAL*12 AS "연봉"
FROM EMP;

/* 연습 문제 : JOB 열에 대한 중복 없이 출력 해보기 */
SELECT DISTINCT JOB FROM EMP;


/* WHERE 구문 : 데이터를 조회할 때 사용자가 원하는 조건에 맞는 데이터만을 조회하고 싶을 때 사용 하는 것 */
SELECT * 
    FROM EMP 
    WHERE DEPTNO = 10; -- SQL에서 같은지 비교하는 연산자는 = D입니다.

/* 연습 문제 : 급여가 2500 이상의 사원번호, 이름, 직무, 급여 출력하기 */
SELECT EMPNO, ENAME, JOB, SAL 
    FROM EMP 
    WHERE SAL >= 2500;

/* 연습 문제 : WHERE 구문을 사용해 사원 번호가 7500 보다 큰 사람만 골라서 사원번호, 사원이름 입사일 부서번호 출력하기 */
SELECT EMPNO, ENAME, HIREDATE, DEPTNO
    FROM EMP 
    WHERE EMPNO > 7500;
    
/* 산술연산자 : +, -, *, / */
SELECT *
    FROM EMP
    WHERE SAL * 12 = 36000;
    

/* 비교연산자 :  >, >=, <, <= */
-- 커미션이 500 이상인 사람만 출력
SELECT *
    FROM EMP
    WHERE COMM >= 500; 

/* 입사일이 81년 1월 1일 이후 인 사람을 모두 출력 */
SELECT *
    FROM EMP
    WHERE HIREDATE > '81/01/01'; -- 날짜나 문자열을 비교할 때는 ''로 감싸 주어야 합니다.
    
/* 직업이 세일즈맨인 사람만 출력 */
SELECT *
    FROM EMP
    WHERE JOB = 'SALESMAN'; -- 문자열 비교시 대소문자 구분

/* 논리연산자 : AND, OR, NOT */
-- 급여가 2500이상이고 부서가 20번인 사람을 모두 출력 (조건을 둘 다 만족해야 함 AND)
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20;

-- 급여가 2500이상이거나 부서가 20번인 사람을 모두 출력 (조건을 둘 중 하나만 만족해도 됨 OR)
SELECT *
    FROM EMP
    WHERE SAL >= 2500 OR DEPTNO = 20;
    

-- 급여가 2500이상이고 입사일이 82년 1월 1일 이전 입사자 출력
SELECT * FROM EMP;

SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20 AND HIREDATE < '82/01/01'; 
    
    
-- 급여가 2000 이상이고 직업이 MANAGER인 사원의 사원번호, 이름, 직책, 급여, 부서번호를 출력
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';
    
SELECT EMPNO 사원번호, ENAME 이름, JOB 직책, SAL 급여, DEPTNO 부서번호
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';
    
-- 부정의 연산자 사용하기 : NOT 
-- 급여가 2500이상이고 직업이 SALESMAN이 아닌 사람만 출력하기
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND JOB != 'SALESMAN';

/* IN 연산자 : 포함 여부를 확인하는 것. 특정 열에 포함된 데이터를 여러개 조회할 때 활용 */
SELECT * 
    FROM EMP
    WHERE job = 'MANAGER' 
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';

SELECT *
    FROM EMP
    WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');
    -- WHERE [열 이름] IN (데이터1, 데이터2, 데이터N...)
    

-- dpetno가  20, 30인 사원들의 정보를 조회
SELECT EMPNO 사원번호, ENAME 이름, HIREDATE 입사일 , SAL 급여
    FROM EMP
    WHERE DEPTNO IN (20, 30);
    
-- 등가 비교연산자와 AND 연산자
SELECT * 
    FROM EMP
    WHERE JOB != 'MANAGER'
    AND JOB <> 'SALESMAN'
    AND JOB ^= 'CLERK';

/* 일정 범위를 지정하는 BETWEEN 연산자 */    
-- 급여가 2000 이상 3000 이하, 즉 급여가 2000 ~ 3000인 사원 데이터를 조회
SELECT *
    FROM EMP
    WHERE SAL >= 2000
        AND SAL <= 3000;
-- BETWEEN AND 사이에 있는 값들은 둘 다 포함됨        
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;
    
    
    
-- BETWEEN 절을 사용해서 급여가 1000에서 2500 사이이고 부서가 10, 30인 사원을 출력 하기
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO IN (10, 30);
        
        
        
-- BETWEEN 절을 사용해서 급여가 1000 에서 2500 사이이고, 부서가 10, 20이 아닌 사원 출력
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO NOT IN (10, 20);

-- BETWEEN 절을 사용해서 사원번호가 7000에서 7999 사이이고, 입사일이 81년 5월 1일 이후 인 사원 출력
SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '1981/05/01';







-- 1980년이 아닌 해에 입사한 직원을 조회    
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '80/01/01' AND '80/12/31';
SELECT *
    FROM EMP
    WHERE NOT HIREDATE BETWEEN '80/01/01' AND '80/12/31';
-- EXTRACT 절을 사용하는 방법
SELECT *
    FROM EMP 
    WHERE EXTRACT (YEAR FROM HIREDATE) != 1980;
-- EXTRACT 절 응용:  12월 입사자 출력
SELECT *
    FROM EMP 
    WHERE EXTRACT (MONTH FROM HIREDATE) = 12;
    
/* LIKE 절은 일부 문자열이 포함되어 있는지 여부를 확인 할 때 사용 */
-- % : 길이와 상관없이 모든 문자 데이터를 의미
-- _ : 문자 1개를 의미

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%%'; -- '%%'는 모든 문자 = 조건이 X

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S%'; -- S 가포함된 모든것. 길이 상관 X. S가 제일 앞, 제일 뒤에도 올 수 있음 
    
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'S____'; -- SMITH를 찾으려면 S_ _ _ _. S_만 하면 안나옴. 

SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    
-- 이름에 AM이 포함되어 있는 사원 출력  
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';
     
-- 이름에 AM이 포함되어 있지 않은 사원 출력  
SELECT *
    FROM EMP
    WHERE ENAME NOT LIKE '%AM%';
    
/* 와일드카드 문자가 데이터 일부일 경우 */
-- 테이블에 값 넣기
INSERT INTO EMP VALUES(9999, 'TEST%PP', 'SALESMAN', 7698, TO_DATE('23-02-14','DD-MM-YY'), 2000, 1000, 30); -- 입사연도 이상함 
SELECT * FROM EMP;
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%\%%' ESCAPE '\'; -- \=제어문자. \바로 뒤의 문자는 진짜 찾는 문자

-- 테이블에서 행 지우기 (해당하는 이름의 데이터 삭제)
DELETE FROM EMP 
    WHERE ENAME = 'TEST%PP';
    
/* IS NULL */
-- NULL이란 ? 0도 아니고 빈 공간도 아님을 의미. 즉, 미확정된 값이라는 의미. 연산 및 비교, 할당이 불가능. (DB에서는 실제 값만 존재하기 때문에 참조의 개념이 없음)
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL은 값을 비교 할 수 없어서 출력값 안나옴
-- NULL을 조회할 때는 IS 연산자 사용    
SELECT *
    FROM EMP
    WHERE COMM IS NULL; 
-- NULL을 제외하고 조회할 때. 
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;   
    -- TURNER의 COMM이 0은 0으로 확정된 값이라서 NULL과 다름. 
    
-- MGR이 있는 사원만 출력하기
SELECT * 
    FROM EMP
    WHERE MGR IS NOT NULL;
    

/* ORDER BY 절 : 특정 컬럼의 데이터를 기준으로 오름차순이나 내림차순으로 정렬하는 기능을 하는 절. 가장 마지막에 기술되어야 하며 남발하면 좋지 않음  */
-- 정렬을 위한 ORDER BY 절. 여러 절 중 가장 마지막 부분에 씀. DB가 크면 성능에 영향을 미침
SELECT *
    FROM EMP
    ORDER BY SAL ASC;
    -- ORDER BY자체가 정렬 명령어라서 ASC 붙이지 않아도 자동 오름차순 정렬
    
    
-- 사원 번호 기준으로 오름차순이 되도록 작성    
SELECT *
    FROM EMP
    ORDER BY EMPNO;
-- 급여 기준으로 오름차순 하고 급여가 같은 경우 이름 기준으로 정렬 
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME;
-- 급여 기준으로 오름차순 하고 금여가 같은 경우 이름을 내림차순으로 정렬
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME DESC;

/* 별칭 사용과 ORDER BY */
SELECT EMPNO 사원번호, ENAME 사원명, SAL 월급, HIREDATE 입사일     -- STEP 2
    FROM EMP                                                    -- STEP 1
    ORDER BY 월급 DESC, 사원명 ASC;                              -- STEP 3
    
    
/* 연결 연산자 (||): SELECT 조회시 컬럼 사이에 특정한 문자를 넣고 싶을 때 사용하는 연산자 */
SELECT ENAME || 's JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;


    
/****** 실습문제 *******/    
-- 1. S로 끝나는 사원 
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S';
    
-- 2. 30번 부서, 직책 'SALESMAN'
SELECT EMPNO 사원번호, ENAME 이름, JOB 직책, SAL 급여, DEPTNO 부서번호  -- STEP 3
    FROM EMP                                                        -- STEP 1
    WHERE DEPTNO = 30 AND JOB = 'SALESMAN';                         -- STEP 2
        
-- 3. 20,30번 부서에 근무, 급여 2000초과 
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO IN (20, 30) --   WHERE DEPTNO BETWEEN 20 AND 30
    AND SAL > 2000;

-- 4. BETWEEN 연산자 없이, 급여가 2000 이상 3000 이하를 제외 
SELECT *
    FROM EMP
    WHERE SAL NOT BETWEEN 2000 AND 3000; -- WHERE SAL < 2000 OR SAL > 3000;
SELECT *
    FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;
    
-- 5. 이름에 E가 포함, 30번 부서, 1000 ~ 2000사이가 아님 
SELECT ENAME, EMPNO, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 30 
    AND ENAME LIKE '%E%'
    AND SAL NOT BETWEEN 1000 AND 2000;
/*
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE ENAME LIKE '%E%' -- 이름 먼저
    AND DEPTNO = 30
    AND SAL NOT BETWEEN 1000 AND 2000;
*/
    
-- 6. 
SELECT *
    FROM EMP 
    WHERE COMM IS NULL AND MGR IS NOT NULL
    AND JOB IN ('MANAGER', 'CLERK') -- AND JOB = 'MANAGER' OR JOB = 'CLERK' -> 얘는 안됨 
    AND ENAME NOT LIKE '_L%';
/* SELECT *
FROM EMP
WHERE COMM IS NULL OR COMM = 0
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%';*/

SELECT *
FROM EMP
WHERE (COMM IS NULL OR COMM = 0) -- 여기서 안묶으면 COMM IS NULL OOOORRRR 로 들어감 NULL이거나 아니면 ~ 
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%'

-- 처음 나의 답 업그레이드
SELECT *
    FROM EMP
    WHERE (COMM IS NULL OR COMM = 0)
    AND MGR IS NOT NULL
    AND (JOB = 'MANAGER' OR JOB = 'CLERK')
    AND ENAME NOT LIKE '_L%'
    














/* 추가 문제 풀이 */
-- 1. COMM의 값이 NULL이 아닌 정보 조회
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 2. COMM을 받지 못하는 직원 조회
SELECT ENAME
    FROM EMP
    WHERE COMM IS NULL OR COMM = 0;
    
-- 3. 관리자가 없는 직원 조회
SELECT ENAME
    FROM EMP
    WHERE MGR IS NULL;
    
-- 4. 급여를 많이 받는 직원 순으로 조회
SELECT *
    FROM EMP
    ORDER BY SAL DESC;
    
-- 5. 급여가 같을 경우 COMM을 내림차순 정렬 조회
SELECT *
    FROM EMP
    ORDER BY SAL DESC, COMM DESC;
    
-- 6. 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO, ENAME, JOB, HIREDATE
    FROM EMP
    --ORDER BY 4; --컬럼의 순서를 입력해도 됨 
    ORDER BY HIREDATE;
    
    
-- 7. 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO, ENAME
    FROM EMP
    ORDER BY EMPNO DESC;
    
-- 8. 사원번호, 입사일, 사원명, 급여 조회 (부서번호가 빠른 순으로, 부서 번호가 같으면 최근 입사일 순으로 처리)
SELECT EMPNO, HIREDATE, ENAME, SAL
    FROM EMP
    ORDER BY DEPTNO, HIREDATE DESC;
    
 
-- 9. EMPNO 홀수?    
SELECT EMPNO, ENAME
    FROM EMP
    WHERE MOD(EMPNO, 2) = 1;
    
-- 10. EMPNO 짝수?    
SELECT EMPNO, ENAME
    FROM EMP
    WHERE MOD(EMPNO, 2) = 0;    

    
    

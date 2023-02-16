/* 2022/02/15 수요일 */

/* SUBSTR함수와 다른 함수 함께 사용 */
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)),      -- CLERK -> CLERK
    SUBSTR(JOB, -LENGTH(JOB), 2),   -- CLERK -> CL
    SUBSTR(JOB, -3)                 -- CLERK -> ERK
FROM EMP;    

SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)),  -- -LENGTH(JOB)은 JOB의 문자개수만큼 음수로 빠져서 JOB 이 처음부터 끝까지 출력 됨
    SUBSTR(JOB, -LENGTH(JOB), 4),  -- -LENGTH(JOB)한 상태에서 그 위치에서 4개까지 뽑는거 CLERK -> CLER
    SUBSTR(JOB, -LENGTH(JOB), -4) -- LENGTH(JOB)한 상태에서 뒤에서 
FROM EMP;    

/* REPLACE : 특정 문자열 데이터에 포함된 문자를 다른 문자로 대체 할 때 사용(자바 문법과 유사). 대체할 문자열을 넣지 않으면 삭제의 효과 */
SELECT '010-5006-4146' AS 변경이전, 
    REPLACE('010-5006-4146', '-', ' ') 하이픈을공백으로, -- 010 5006 4146
    REPLACE('010-5006-4146', '-') 하이픈삭제            -- 01050064146
    FROM DUAL;
    
/* LPAD / RPAD : 공간에 칸수를 지정하고 빈칸 만큼 특정 문자로 채우는 기능 */
SELECT LPAD ('ORACLE', 10, '+') FROM DUAL; -- ++++ORACLE
SELECT RPAD ('ORACLE', 10, '+') FROM DUAL; -- ORACLE++++
SELECT 'ORACLE', 
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2,
    RPAD('ORACLE', 10) AS RPAD_2
    FROM DUAL;
    
-- 개인정보 뒷자리를 *표시로 출력 하기
SELECT
    RPAD('910624-', 14, '*') AS RPAD_JUMIN,
    RPAD('010-9327-', 13, '*') AS RPAD_PHONE
FROM DUAL;    


-- 두 문자열을 합치는 CONCAT 함수
SELECT CONCAT(EMPNO, ENAME),
CONCAT(EMPNO, CONCAT(' : ', ENAME)) -- 중첩사용
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM/LTRIM/RTRIM : 문자열 내에서 특정 문자를 지우기 위해서 사용
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM, -- TRIM : 문자열의 앞,뒤 공백을 지움
        '[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
        '[' || LTRIM('<_ORACLE_>', '_<') || ']' AS LTRIM_2, -- 문자열이 문자를 지우기 때문에 순서가 맞지 않아도 지워짐
        '[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM,
        '[' || RTRIM('<_ORACLE_>', '_>') || ']' AS RTRIM_2
FROM DUAL;

SELECT TRIM('     KDE0624     ') AS TRIM FROM DUAL; -- 앞,뒤 공백 제거


/* 날짜 데이터를 다루는 날짜 함수 : DATE형 데이터는 간단한 연산이 가능 (더하기 연산은 불가) */
SELECT SYSDATE FROM DUAL; -- 23/02/15

SELECT SYSDATE AS NOW,      -- 23/02/15
    SYSDATE-1 AS YESTERDAY, -- 23/02/14 : 운영체제에서 읽어온 시간 정보에서 1일을 뺌
    SYSDATE+1 AS TOMORROW   -- 23/02/16 : 운영체제에서 읽어온 시간 정보에서 1일을 더함
    FROM DUAL;

/* 몇 개월 이후의 날짜를 구하는 ADD_MONTHS 함수 : 특정 날짜에 지정한 개월 수 이후 날짜 데이터를 반환하는 함수  
                                            : 형식 : ADD_MONTHS([날짜 데이터], [더할 개월 수(정수)(필수)]) 
*/

SELECT SYSDATE,
    ADD_MONTHS (SYSDATE, 5)
    FROM DUAL;

/* 실습 문제 */
--(EMP테이블 사용) 입사 10주년이 되는 사원에 대해 사원번호, 이름, 입사일, 10주년 경과된 날짜를 출력하기
SELECT EMPNO 사원번호, ENAME 이름, HIREDATE 입사일, 
    ADD_MONTHS(HIREDATE, 120) AS "10주년"
    FROM EMP;
    
--(DUAL테이블 사용) 현재 시간과 8개월 이후 시간 출력하기
SELECT SYSDATE 현재시간,
    ADD_MONTHS(SYSDATE, 8) AS "8개월경과일"
FROM DUAL;

/* 두 날짜간의 개월 수 차이를 구하는 MONTHS_BETWEEN 함수 */
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, -- 과거시간 - 현재시간 = 음수
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2, -- 현재시간 - 과거시간 = 양수
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3 -- TRUNC 함수를 조합하여 개월수 차이를 정수로 출력 가능
    FROM EMP;
    
    
/* 돌아오는 요일, 달의 마지막 날짜를 구하는 NEXT_DAY, LAST_DAY 함수 */    
/* NEXT_DAY(날짜데이터, 요일문자) : 날짜 기준으로 돌아오는 요일의 날짜를 출력 */
/*  LAST_DAY(날짜데이터) : 날짜가 속한 달의 마지막 날짜를 출력 */
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, 2) AS NEXTMONDAY, -- '월요일', '월', 2 가능. 영어로도 찾아보기-> 언어환경 바꿔주면 됨!  ALTER SESSION SET NLS_LANGUAGE = 'English';

    LAST_DAY(SYSDATE)
    FROM DUAL;
    
/* 날짜를 반올림, 버림을 하는 ROUND, TRUNC 함수 */    
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS ROUND,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS TRUNC
    FROM EMP;
    
    
/* 날짜 정보 추출 함수 EXTRACT */
SELECT EXTRACT(YEAR FROM DATE '1998-03-07')
    FROM DUAL;
    
-- 입사일이 12월인 사원 출력
SELECT *
    FROM EMP
    WHERE EXTRACT (MONTH FROM HIREDATE) = 12;

-- 현재 몇월인지 추출
SELECT EXTRACT(MONTH FROM SYSDATE) 
    FROM DUAL;



/* 자료형을 변환하는 형 변환 함수
    : 오라클도 자바와 마찬가지로 명시적 형변환과 묵시적 형변환이 있음.
    : 숫자가 순위가 더 높음, 자바와는 다르게 숫자+문자열은 문자열이 아닌 숫자. */  
    
/* 묵시적(자동) 형변환 : 숫자와 문자 자료형의 연산은 자동으로 숫자로 변함 */
SELECT EMPNO, ENAME, EMPNO + '500'
    FROM EMP;

SELECT EMPNO, ENAME, EMPNO + 'ABCD' -- invalid number 에러 발생
    FROM EMP;

/* 날짜, 숫자를 문자로 변환하는 TO_CHAR 함수 : 주로 날짜 데이터를 데이터를 문자 데이터로 변환시 사용
                                         : 형식 : TO_CHAR(날짜데이터, 출력되기를 원하는 문자 형태)
*/

SELECT TO_CHAR (SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재 날짜와 시간" -- SQL은 대소문자 구분을 하지 않아서 MM, mm 대신 MM, M1로 구분
    FROM DUAL;
    
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS 세기,
    TO_CHAR(SYSDATE, 'YY') AS 연도,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') AS "년/월/일 시:분:초",
    TO_CHAR(SYSDATE, 'Q') AS 쿼터,
    TO_CHAR(SYSDATE, 'DD') AS 일,
    TO_CHAR(SYSDATE, 'DDD') AS 경과일,
    TO_CHAR(SYSDATE, 'HH') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH12') AS "12시간제",
    TO_CHAR(SYSDATE, 'HH24') AS "24시간제",
    TO_CHAR(SYSDATE, 'W') AS 몇주차
    FROM DUAL;

-- 셀프 응용(?)
SELECT SYSDATE, 
    TO_CHAR(NEXT_DAY(SYSDATE, 2)) AS NEXTMONDAY
    FROM DUAL;


-- 특정 언어에 맞춰서 날짜 출력하기 : 날짜 데이터를 출력할 문자 형태를 지정하고 원하는 언어 양식을 지정
--                              : TO_CHAR([날짜 데이터(필수)], '[출력되길 원하는 문자 형태(필수)]’ , ‘NLS_DATE_LANGUAGE = language’(선택))


-- 여러 언어로 날짜(월) 출력 하기
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MONTH_KOR,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_ENG
    FROM DUAL;
    
-- 여러 언어로 날짜(요일) 출력하기
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'MM') AS MM,
     TO_CHAR(SYSDATE, 'DD') AS DD,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DY_KOR,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DY_JPN,
     TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DY_ENG,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = KOREAN' ) AS DAY_KOR,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS DAY_JPN,
     TO_CHAR(SYSDATE, 'DAY', 'NLS_DATE_LANGUAGE = ENGLISH' ) AS DAY_ENG
FROM DUAL;

--  시간 형식 지정하여 출력하기
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
     TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
     TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;


-- 숫자 데이터 형식을 지정하여 출력하기 
--    9 : 숫자의 한 자리를 의미하고 빈 자리를 채우지 않음
--    0 : 빈 자리를 0으로 채움
--    $ : 달러 표시를 붙임
--    L : L(Local) 지역 화폐 단위를 표시
--    . : 소수점 표시
--    , : 천 단위의 기호를 표시                                 */
    
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$,  -- 달러 표시를 하고 빈 자리를 채우지 않고 천 단위에 , 추가
    TO_CHAR(SAL, 'L999,999') AS SAL_L,  -- 지역 화폐를 표시하고 천 단위에 , 추가
    TO_CHAR(SAL, '999,999.00') AS SAL_1, -- 소수점 이하 2자리 표시하고 천 단위에 , 추가
    TO_CHAR(SAL, '000,999,999.00') AS SAL_2, -- 빈 자리를 0으로 채움 (얼마가 들어가던지 빈 자리에 대해서는 다 0으로 채움)
    TO_CHAR(SAL, '000999999.99') AS SAL_3, -- 소수점이 있으면 표시, 없으면 표시 안함
    TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;
    
    
/* TO_NUMBER : 숫자 타입의 문자열을 숫자 데이터 타입으로 변환해주는 함수 */
SELECT TO_NUMBER('1300') - TO_NUMBER('1500'),
    '1300' + 1500
    FROM DUAL;

-- 자동 형변환이 일어나기 때문에 결과가 똑같음 
SELECT '1300' - '1500', 
    '1300' + 1500
    FROM DUAL;
    
    
-- 가공된 문자 데이터로 저장 되어있는 숫자 데이터의 산술은 TO_NUMBER 필요   
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999'),
    '1300' + 1500
    FROM DUAL;


/* TO_DATE : 문자열로 명시된 날짜를 변환하는 함수 */    
SELECT TO_DATE('22/08/20', 'YY/MM/DD')    -- 데이트 타입 결과
    FROM DUAL;
 
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') AS NOW -- 문자타입 결과
    FROM DUAL;
 
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_CHAR(SYSDATE);
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE(SYSDATE, 'YY/MM/DD');
SELECT *
    FROM EMP
    WHERE HIREDATE < TO_DATE('1981/01/01', 'YYYY/MM/DD');

-- 1981년 6월 1일 이후에 입사한 사원 정보 출력하기
SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');
        
        
/* NVL(Null Value) 함수의 사용법 : NVL(데이터열, 앞의 데이터가 NULL일 경우 반환 할 데이터) */        
SELECT EMPNO, ENAME, SAL, COMM,
        NVL (COMM, 0),
        SAL*12+NVL(COMM,0) AS 연봉
    FROM EMP;


/* NVL2 : 데이터가 NULL이 아닐 때 반환할 데이터를 추가로 지정해 줄 수 있음
        : 형식 : (NVL2([NULL인지 여부를 검사할 데이터 또는 열(필수)],[앞 데이터가 NULL이 아닐 경우 반환할 데이터 또는 계산식(필수)], [앞 데이터가 NULL일 경우 반환할 데이터 또는 계산식(필수)]) */     
SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X') AS "NULL여부표시",
    NVL2(COMM, SAL*12+COMM, SAL*12) AS "연봉계산"
    FROM EMP;
   
/* NULLIF : 두 값을 비교해서 동일한지 아닌지에 대한 결과 반환 
          : 두 값이 동일하면 NULL을 반환하고 동일하지 않으면 첫번째 값을 반환 */
SELECT NULLIF(10,10), NULLIF('A', 'B') FROM DUAL; -- (null) | A

/* DECODE : 주어진 데이터의 값이 조건값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값을 출력 (자바의 조건문 또는 SWITCH문과 유사) */
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1, -- 10%
        'SALESMAN', SAL*1.05, -- 5%
        'ANALYST', SAL, -- 동결
        SAL*1.03) AS 급여인상 -- 조건이 없는 나머지는 3%
        FROM EMP;
        
/* CASE문 : 주어진 데이터의 값이 조건값과 일치하는 값을 출력하고 일치하는 값이 없으면 기본값을 출력 (자바의 조건문 또는 SWITCH문과 유사) */  
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ALANYST' THEN SAL
        ELSE SAL*1.03
    END AS 급여인상
FROM EMP;

-- 열 값에 따라서 출력값이 달라지는 CASE문
SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '해당 사항 없음'
        WHEN COMM = 0 THEN '수당 없음'
        WHEN COMM > 0 THEN '수당: ' || COMM
    END AS 수당표시
FROM EMP;    
        
/* 종합 실습문제 */
-- 노션에 있는 4개의 문제
-- 1.ENAME이 다섯글자인 사원, 사원번호 앞 두자리만 표시하고 나머지는 별(*)표처리, 
SELECT EMPNO, 
    RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO, 
    ENAME,
    RPAD(SUBSTR(ENAME,1, 1), LENGTH(ENAME), '*') AS MAKING_ENAME
    FROM EMP
    WHERE LENGTH(ENAME) = 5;
    
-- 1번 강사님 답     
SELECT EMPNO, 
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO, 
    ENAME,
    RPAD(SUBSTR(ENAME,1, 1), 5, '*') AS MAKING_ENAME -- 이름들이 어차피 다섯자리라서 LENGTH(ENAME) 할 필요 X
    FROM EMP
    WHERE LENGTH(ENAME) = 5
    ORDER BY EMPNO;
    

-- 2.  
SELECT EMPNO, ENAME, SAL, 
        ROUND(SAL/21.5, 2) AS DAY_PAY,
        ROUND(SAL/21.5/8, 1) AS TIME_PAY
        FROM EMP;
        
-- 2번 강사님 답  *****    
SELECT EMPNO, ENAME, SAL, 
        TRUNC(SAL/21.5, 2) AS DAY_PAY, -- DAY_PAY는 소수점 세자리에부터 버리고(TRUNC)
        ROUND(SAL/21.5/8, 1) AS TIME_PAY -- TIME_PAY는 둘째 자리에서 반올림 (ROUND)
        FROM EMP;
        
-- 3. 
SELECT EMPNO, ENAME, HIREDATE,
    NEXT_DAY (ADD_MONTHS(HIREDATE, 3),2) AS R_JOB, 
    CASE
    WHEN COMM IS NULL THEN 'N/A'
    WHEN COMM IS NOT NULL THEN TO_CHAR(COMM)
    END AS COMM    
FROM EMP;

-- 3번 강사님 답
SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB, -- 'YYYY-MM-DD' 형식으로! 
    NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP;    

-- 4.
SELECT EMPNO, ENAME, MGR, 
    CASE
        WHEN MGR IS NULL THEN '0000'
        WHEN SUBSTR(MGR, 1, 2) = '75' THEN '5555'
        WHEN SUBSTR(MGR, 1, 2) = '76' THEN '6666'
        WHEN SUBSTR(MGR, 1, 2) = '77' THEN '7777'
        WHEN SUBSTR(MGR, 1, 2) = '78' THEN '8888'
        ELSE TO_CHAR(MGR)
    END AS CHG_MGR
FROM EMP;    


-- SCOTT 계정 문제
-- 1. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE FROM DUAL;

-- 2. EMP테이블에서 사번, 사원명, 급여 조회 (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, TO_CHAR(SAL, '999') AS SAL
    FROM EMP
    ORDER BY SAL DESC;
-- 2번 강사님 답 : 급여 100단위까지의 값은 둘째 자리에서 반올림 해야한다는 뜻
SELECT EMPNO, ENAME, ROUND(SAL, -2)
    FROM EMP
    ORDER BY 3 DESC;
    

-- 3. 사원번호가 홀수인 사원들을 조회
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) != 0;
-- 3번 강사님 답
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) = 1;

    
-- 4. 사원명, 입사일 조회( 단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY') AS YEAR, TO_CHAR(HIREDATE, 'MM') AS MONTH
FROM EMP;
-- 4번 강사님 답
SELECT ENAME, EXTRACT (YEAR FROM HIREDATE) AS 입사년도, EXTRACT(MONTH FROM HIREDATE) AS 입사월
    FROM EMP;


-- 5. 9월에 입사한 직원의 정보 조회
SELECT *
    FROM EMP
    WHERE EXTRACT (MONTH FROM HIREDATE) = 9;


-- 6. 81년도에 입사한 직원 조회
SELECT *
    FROM EMP
    WHERE EXTRACT (YEAR FROM HIREDATE) = 1981;
    
-- 7. 이름이 'E'로 끝나는 직원 조회
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%E';
    
-- 8. 이름의 세 번째 글자가 'R'인 직원의 정보 조회
SELECT *
    FROM EMP
    WHERE ENAME LIKE '__R%';
    
-- 9. 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS (HIREDATE, 480) AS 입사일로부터40년
    FROM EMP;
-- 9번 강사닙 답 
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 40*12)
    FROM EMP;

-- 10. 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT *
    FROM EMP
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) >= 38; 
-- 10번 강사님 답
SELECT *
    FROM EMP
    WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)/12 >= 38;
    
    
-- 11. 오늘 날짜에서 년도만 추출
SELECT TO_CHAR(SYSDATE, 'YYYY') AS THISYEAR FROM DUAL;
SELECT EXTRACT(YEAR FROM SYSDATE) AS THISYEAR FROM DUAL;

/* 2022/02/14 화요일 */

/* 함수란? 오라클에서는 내장 함수와 사용자가 필요에 의해서 직접 정의한 사용자 정의 함수로 나누어 집니다. 
          단일행 함수와 다중행 함수(집계 함수)로 나누어 집니다. */

/* DUAL 테이블 : SYS계정에서 제공하는 테이블로 함수나 계산식을 테이블 참조 없이 실행해보기 위해 FROM 절에 사용하는 더미(DUMMY) 테이블. 가상 테이블 */          
          
          
/* 숫자 함수 : 수학적 계산식을 처리하기 위한 함수를 의미 
             (ABS, ROUND, TRUNC, MOD, CEIL, FLOOR, POWER) */

/* ABS : 절대값 구하는 함수 */
-- SELECT -10, ABS(10) FROM EMP;
SELECT -10, ABS(10) FROM DUAL;

/* ROUND : 반올림한 결과를 반환하는 함수 */
SELECT ROUND(1234.5678) AS ROUND, -- 반올림 자리를 지정하지 않으면 0으로 반올림한것과 같음(소수점 이하 첫번째 자리)
     ROUND(1234.5678, 0) AS ROUND_0,
     ROUND(1234.5678, 1) AS ROUND_1,
     ROUND(1234.5678, 2) AS ROUND_2,
     ROUND(1234.5678, 3) AS ROUND_3, -- 양수의 범위 만큼 소수점 아래로 이동 
     ROUND(1234.5678, -1) AS ROUND_MINUS1,
     ROUND(1234.5678, -2) AS ROUND_MINUS2,
     ROUND(1234.5678, -3) AS ROUND_MINUS3
 FROM DUAL;

/* TRUNC : 버림을 한 결과를 반환하는 함수 (ROUND와의 차이점은 5이상이어도 버림)*/
SELECT TRUNC(1234.5678) AS TRUNC,
     TRUNC(1234.5678, 0) AS TRUNC_0,
     TRUNC(1234.5678, 1) AS TRUNC_1,
     TRUNC(1234.5678, 2) AS TRUNC_2,
     TRUNC(1234.5678, 3) AS TRUNC_3, 
     TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
     TRUNC(1234.5678, -2) AS TRUNC_MINUS2,
     TRUNC(1234.5678, -3) AS TRUNC_MINUS3
 FROM DUAL;

/* MOD : 나누기 한 후 나머지를 출력하는 함수 */
SELECT MOD(21, 5) FROM DUAL;

/* CEIL : 소수점 이하가 있으면 무조건 올림 */
SELECT CEIL(12.001) FROM DUAL; -- 13

/* FLOOR : 소수점 이하를 무조건 날림 */
SELECT FLOOR(12.999) FROM DUAL; -- 12

/* POWER : 정수A를 정수B만큼 곱하는 함수 */
SELECT POWER(3, 4) FROM DUAL;


/* 문자함수 : 문자 데이터를 가공하거나 문자 데이터로 부터 특정 결과를 얻고자 할 때 사용하는 함수
             (UPPER, LOWER, INITCAP) */

/* UPPER : 대문자로 변경 */
/* LOWER : 소문자로 변경 */
/* INITCAP : 첫글자는 대문자로 변경하고 나머지는 소문자로 변경 */
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
    FROM EMP;
    
    
-- 문자 함수를 WHERE 조건절에서 사용
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) = UPPER('james'); -- java의 eualsIsnoreCase와 비슷한 효과

-- 문자 함수를 LIKE절과 함께 사용  
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) LIKE UPPER('%ja%'); 
    
-- INITCAP
SELECT INITCAP('woo young woo') AS 이름 FROM DUAL;

/* 연습문제 */
-- 사원 이름은 대문자, 직책은 첫자 대문자 나머지는 소문자로 변경하고 급여가 높은 순으로 출력
SELECT UPPER(ENAME) AS 이름, INITCAP(JOB) AS 직책, SAL AS 급여
    FROM EMP
    ORDER BY SAL DESC;
    
/* LENGTH : 문자열 길이를 구하는 함수 */    
SELECT ENAME, LENGTH(ENAME) AS 이름의길이
    FROM EMP;

-- 이름의 길이가 5와 같거나 큰 사원의 이름, 사원번호, 직책을 연봉 순으로 표시. 단, 보너스 제외
SELECT ENAME AS 이름, EMPNO AS 사원번호, JOB AS 직책, SAL*12 AS 연봉
    FROM EMP
    WHERE LENGTH(ENAME) >= 5
    ORDER BY 4 DESC; -- SAL*12 = 연봉 = 4
    
/* LENGTH vs. LENGTHB */
/* LENGTH  : 문자열의 길이를 반환  
   LENGTHB : 문자열의 바이트 수 반환 */
SELECT LENGTH('한글'), LENGTHB('한글') -- 오라클XE 버전에서 한글은 한글자가 3바이트. MySQL은 한글자당 1바이트, 디비마다 다름   
    FROM DUAL;
    
-- 직책 이름이 6글자 이상이고 COMM 이 있는 사원 출력
SELECT *
    FROM EMP
    WHERE LENGTH(JOB) >= 6 
        AND COMM IS NOT NULL 
        AND COMM != 0; -- (COMM IS NOT NULL OR COMM != 0)로 걸면 NOT NULL에서 다 나오고 끝나버림 
        


/* SUBSTR/SUBSTRB : 대상 문자열이나 컬럼의 자료에서 시작 위치부터 선택 개수만큼의 문자를 반환하는 함수. 인덱스 개념 아님
   SUBSTR  : 문자수 : SUBSTR(문자열데이터, 시작위치, 길이)
   SUBSTRB : 바이트수 : SUBSTRB(문자열데이터, 시작위치)                                                         */    
   
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
    FROM EMP;
    
-- SUBSTR 함수와 다른 함수 함께 사용
SELECT JOB, 
 SUBSTR(JOB, -LENGTH(JOB)), 
 SUBSTR(JOB, -LENGTH(JOB), 2),
 SUBSTR(JOB, -3)
FROM EMP;   


/* INSTR : 문자열 데이터 안에 특정 문자나 문자열이 어디에 포함되어 있는지 알고자 할 때 사용 */
/* INSTR([대상 문자열 데이터(필수)],
    [위치를 찾으려는 부분 문자(필수)],
    [위치 찾기를 시작할 대상 문자열 데이터 위치(선택, 기본값은 1)],
    [시작 위치에서 찾으려는 문자가 몇 번째인지 지정(선택, 기본값은 1)]) */
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, -- 3
 INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,    -- 12
 INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3  -- 4
FROM DUAL;


SELECT INSTR('HELLO, ORACLE!', 'L', 2, 10) AS INSTR
FROM DUAL;







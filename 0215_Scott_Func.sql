/* 2022/02/15 ������ */

/* SUBSTR�Լ��� �ٸ� �Լ� �Բ� ��� */
SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)),      -- CLERK -> CLERK
    SUBSTR(JOB, -LENGTH(JOB), 2),   -- CLERK -> CL
    SUBSTR(JOB, -3)                 -- CLERK -> ERK
FROM EMP;    

SELECT JOB,
    SUBSTR(JOB, -LENGTH(JOB)),  -- -LENGTH(JOB)�� JOB�� ���ڰ�����ŭ ������ ������ JOB �� ó������ ������ ��� ��
    SUBSTR(JOB, -LENGTH(JOB), 4),  -- -LENGTH(JOB)�� ���¿��� �� ��ġ���� 4������ �̴°� CLERK -> CLER
    SUBSTR(JOB, -LENGTH(JOB), -4) -- LENGTH(JOB)�� ���¿��� �ڿ��� 
FROM EMP;    

/* REPLACE : Ư�� ���ڿ� �����Ϳ� ���Ե� ���ڸ� �ٸ� ���ڷ� ��ü �� �� ���(�ڹ� ������ ����). ��ü�� ���ڿ��� ���� ������ ������ ȿ�� */
SELECT '010-5006-4146' AS ��������, 
    REPLACE('010-5006-4146', '-', ' ') ����������������, -- 010 5006 4146
    REPLACE('010-5006-4146', '-') �����»���            -- 01050064146
    FROM DUAL;
    
/* LPAD / RPAD : ������ ĭ���� �����ϰ� ��ĭ ��ŭ Ư�� ���ڷ� ä��� ��� */
SELECT LPAD ('ORACLE', 10, '+') FROM DUAL; -- ++++ORACLE
SELECT RPAD ('ORACLE', 10, '+') FROM DUAL; -- ORACLE++++
SELECT 'ORACLE', 
    LPAD('ORACLE', 10, '#') AS LPAD_1,
    RPAD('ORACLE', 10, '*') AS RPAD_1,
    LPAD('ORACLE', 10) AS LPAD_2,
    RPAD('ORACLE', 10) AS RPAD_2
    FROM DUAL;
    
-- �������� ���ڸ��� *ǥ�÷� ��� �ϱ�
SELECT
    RPAD('910624-', 14, '*') AS RPAD_JUMIN,
    RPAD('010-9327-', 13, '*') AS RPAD_PHONE
FROM DUAL;    


-- �� ���ڿ��� ��ġ�� CONCAT �Լ�
SELECT CONCAT(EMPNO, ENAME),
CONCAT(EMPNO, CONCAT(' : ', ENAME)) -- ��ø���
FROM EMP
WHERE ENAME = 'JAMES';

-- TRIM/LTRIM/RTRIM : ���ڿ� ������ Ư�� ���ڸ� ����� ���ؼ� ���
SELECT '[' || TRIM(' _ORACLE_ ') || ']' AS TRIM, -- TRIM : ���ڿ��� ��,�� ������ ����
        '[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
        '[' || LTRIM('<_ORACLE_>', '_<') || ']' AS LTRIM_2, -- ���ڿ��� ���ڸ� ����� ������ ������ ���� �ʾƵ� ������
        '[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM,
        '[' || RTRIM('<_ORACLE_>', '_>') || ']' AS RTRIM_2
FROM DUAL;

SELECT TRIM('     KDE0624     ') AS TRIM FROM DUAL; -- ��,�� ���� ����


/* ��¥ �����͸� �ٷ�� ��¥ �Լ� : DATE�� �����ʹ� ������ ������ ���� (���ϱ� ������ �Ұ�) */
SELECT SYSDATE FROM DUAL; -- 23/02/15

SELECT SYSDATE AS NOW,      -- 23/02/15
    SYSDATE-1 AS YESTERDAY, -- 23/02/14 : �ü������ �о�� �ð� �������� 1���� ��
    SYSDATE+1 AS TOMORROW   -- 23/02/16 : �ü������ �о�� �ð� �������� 1���� ����
    FROM DUAL;

/* �� ���� ������ ��¥�� ���ϴ� ADD_MONTHS �Լ� : Ư�� ��¥�� ������ ���� �� ���� ��¥ �����͸� ��ȯ�ϴ� �Լ�  
                                            : ���� : ADD_MONTHS([��¥ ������], [���� ���� ��(����)(�ʼ�)]) 
*/

SELECT SYSDATE,
    ADD_MONTHS (SYSDATE, 5)
    FROM DUAL;

/* �ǽ� ���� */
--(EMP���̺� ���) �Ի� 10�ֳ��� �Ǵ� ����� ���� �����ȣ, �̸�, �Ի���, 10�ֳ� ����� ��¥�� ����ϱ�
SELECT EMPNO �����ȣ, ENAME �̸�, HIREDATE �Ի���, 
    ADD_MONTHS(HIREDATE, 120) AS "10�ֳ�"
    FROM EMP;
    
--(DUAL���̺� ���) ���� �ð��� 8���� ���� �ð� ����ϱ�
SELECT SYSDATE ����ð�,
    ADD_MONTHS(SYSDATE, 8) AS "8���������"
FROM DUAL;

/* �� ��¥���� ���� �� ���̸� ���ϴ� MONTHS_BETWEEN �Լ� */
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1, -- ���Žð� - ����ð� = ����
    MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2, -- ����ð� - ���Žð� = ���
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3 -- TRUNC �Լ��� �����Ͽ� ������ ���̸� ������ ��� ����
    FROM EMP;
    
    
/* ���ƿ��� ����, ���� ������ ��¥�� ���ϴ� NEXT_DAY, LAST_DAY �Լ� */    
/* NEXT_DAY(��¥������, ���Ϲ���) : ��¥ �������� ���ƿ��� ������ ��¥�� ��� */
/*  LAST_DAY(��¥������) : ��¥�� ���� ���� ������ ��¥�� ��� */
SELECT SYSDATE,
    NEXT_DAY(SYSDATE, 2) AS NEXTMONDAY, -- '������', '��', 2 ����. ����ε� ã�ƺ���-> ���ȯ�� �ٲ��ָ� ��!  ALTER SESSION SET NLS_LANGUAGE = 'English';

    LAST_DAY(SYSDATE)
    FROM DUAL;
    
/* ��¥�� �ݿø�, ������ �ϴ� ROUND, TRUNC �Լ� */    
SELECT EMPNO, ENAME, HIREDATE, SYSDATE,
    MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
    ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS ROUND,
    TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS TRUNC
    FROM EMP;
    
    
/* ��¥ ���� ���� �Լ� EXTRACT */
SELECT EXTRACT(YEAR FROM DATE '1998-03-07')
    FROM DUAL;
    
-- �Ի����� 12���� ��� ���
SELECT *
    FROM EMP
    WHERE EXTRACT (MONTH FROM HIREDATE) = 12;

-- ���� ������� ����
SELECT EXTRACT(MONTH FROM SYSDATE) 
    FROM DUAL;



/* �ڷ����� ��ȯ�ϴ� �� ��ȯ �Լ�
    : ����Ŭ�� �ڹٿ� ���������� ����� ����ȯ�� ������ ����ȯ�� ����.
    : ���ڰ� ������ �� ����, �ڹٿʹ� �ٸ��� ����+���ڿ��� ���ڿ��� �ƴ� ����. */  
    
/* ������(�ڵ�) ����ȯ : ���ڿ� ���� �ڷ����� ������ �ڵ����� ���ڷ� ���� */
SELECT EMPNO, ENAME, EMPNO + '500'
    FROM EMP;

SELECT EMPNO, ENAME, EMPNO + 'ABCD' -- invalid number ���� �߻�
    FROM EMP;

/* ��¥, ���ڸ� ���ڷ� ��ȯ�ϴ� TO_CHAR �Լ� : �ַ� ��¥ �����͸� �����͸� ���� �����ͷ� ��ȯ�� ���
                                         : ���� : TO_CHAR(��¥������, ��µǱ⸦ ���ϴ� ���� ����)
*/

SELECT TO_CHAR (SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "���� ��¥�� �ð�" -- SQL�� ��ҹ��� ������ ���� �ʾƼ� MM, mm ��� MM, M1�� ����
    FROM DUAL;
    
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'CC') AS ����,
    TO_CHAR(SYSDATE, 'YY') AS ����,
    TO_CHAR(SYSDATE, 'YYYY/MM/DD AM HH:MI:SS') AS "��/��/�� ��:��:��",
    TO_CHAR(SYSDATE, 'Q') AS ����,
    TO_CHAR(SYSDATE, 'DD') AS ��,
    TO_CHAR(SYSDATE, 'DDD') AS �����,
    TO_CHAR(SYSDATE, 'HH') AS "12�ð���",
    TO_CHAR(SYSDATE, 'HH12') AS "12�ð���",
    TO_CHAR(SYSDATE, 'HH24') AS "24�ð���",
    TO_CHAR(SYSDATE, 'W') AS ������
    FROM DUAL;

-- ���� ����(?)
SELECT SYSDATE, 
    TO_CHAR(NEXT_DAY(SYSDATE, 2)) AS NEXTMONDAY
    FROM DUAL;


-- Ư�� �� ���缭 ��¥ ����ϱ� : ��¥ �����͸� ����� ���� ���¸� �����ϰ� ���ϴ� ��� ����� ����
--                              : TO_CHAR([��¥ ������(�ʼ�)], '[��µǱ� ���ϴ� ���� ����(�ʼ�)]�� , ��NLS_DATE_LANGUAGE = language��(����))


-- ���� ���� ��¥(��) ��� �ϱ�
SELECT SYSDATE,
    TO_CHAR(SYSDATE, 'MM') AS MM,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN,
    TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MONTH_KOR,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN,
    TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_ENG
    FROM DUAL;
    
-- ���� ���� ��¥(����) ����ϱ�
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

--  �ð� ���� �����Ͽ� ����ϱ�
SELECT SYSDATE,
     TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
     TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
     TO_CHAR(SYSDATE, 'HH:MI:SS P.M.') AS HHMISS_PM
FROM DUAL;


-- ���� ������ ������ �����Ͽ� ����ϱ� 
--    9 : ������ �� �ڸ��� �ǹ��ϰ� �� �ڸ��� ä���� ����
--    0 : �� �ڸ��� 0���� ä��
--    $ : �޷� ǥ�ø� ����
--    L : L(Local) ���� ȭ�� ������ ǥ��
--    . : �Ҽ��� ǥ��
--    , : õ ������ ��ȣ�� ǥ��                                 */
    
SELECT SAL,
    TO_CHAR(SAL, '$999,999') AS SAL_$,  -- �޷� ǥ�ø� �ϰ� �� �ڸ��� ä���� �ʰ� õ ������ , �߰�
    TO_CHAR(SAL, 'L999,999') AS SAL_L,  -- ���� ȭ�� ǥ���ϰ� õ ������ , �߰�
    TO_CHAR(SAL, '999,999.00') AS SAL_1, -- �Ҽ��� ���� 2�ڸ� ǥ���ϰ� õ ������ , �߰�
    TO_CHAR(SAL, '000,999,999.00') AS SAL_2, -- �� �ڸ��� 0���� ä�� (�󸶰� ������ �� �ڸ��� ���ؼ��� �� 0���� ä��)
    TO_CHAR(SAL, '000999999.99') AS SAL_3, -- �Ҽ����� ������ ǥ��, ������ ǥ�� ����
    TO_CHAR(SAL, '999,999,00') AS SAL_4
FROM EMP;
    
    
/* TO_NUMBER : ���� Ÿ���� ���ڿ��� ���� ������ Ÿ������ ��ȯ���ִ� �Լ� */
SELECT TO_NUMBER('1300') - TO_NUMBER('1500'),
    '1300' + 1500
    FROM DUAL;

-- �ڵ� ����ȯ�� �Ͼ�� ������ ����� �Ȱ��� 
SELECT '1300' - '1500', 
    '1300' + 1500
    FROM DUAL;
    
    
-- ������ ���� �����ͷ� ���� �Ǿ��ִ� ���� �������� ����� TO_NUMBER �ʿ�   
SELECT TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999'),
    '1300' + 1500
    FROM DUAL;


/* TO_DATE : ���ڿ��� ��õ� ��¥�� ��ȯ�ϴ� �Լ� */    
SELECT TO_DATE('22/08/20', 'YY/MM/DD')    -- ����Ʈ Ÿ�� ���
    FROM DUAL;
 
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD') AS NOW -- ����Ÿ�� ���
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

-- 1981�� 6�� 1�� ���Ŀ� �Ի��� ��� ���� ����ϱ�
SELECT *
    FROM EMP
    WHERE HIREDATE > TO_DATE('1981/06/01', 'YYYY/MM/DD');
        
        
/* NVL(Null Value) �Լ��� ���� : NVL(�����Ϳ�, ���� �����Ͱ� NULL�� ��� ��ȯ �� ������) */        
SELECT EMPNO, ENAME, SAL, COMM,
        NVL (COMM, 0),
        SAL*12+NVL(COMM,0) AS ����
    FROM EMP;


/* NVL2 : �����Ͱ� NULL�� �ƴ� �� ��ȯ�� �����͸� �߰��� ������ �� �� ����
        : ���� : (NVL2([NULL���� ���θ� �˻��� ������ �Ǵ� ��(�ʼ�)],[�� �����Ͱ� NULL�� �ƴ� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)], [�� �����Ͱ� NULL�� ��� ��ȯ�� ������ �Ǵ� ����(�ʼ�)]) */     
SELECT EMPNO, ENAME, COMM,
    NVL2(COMM, 'O', 'X') AS "NULL����ǥ��",
    NVL2(COMM, SAL*12+COMM, SAL*12) AS "�������"
    FROM EMP;
   
/* NULLIF : �� ���� ���ؼ� �������� �ƴ����� ���� ��� ��ȯ 
          : �� ���� �����ϸ� NULL�� ��ȯ�ϰ� �������� ������ ù��° ���� ��ȯ */
SELECT NULLIF(10,10), NULLIF('A', 'B') FROM DUAL; -- (null) | A

/* DECODE : �־��� �������� ���� ���ǰ��� ��ġ�ϴ� ���� ����ϰ� ��ġ�ϴ� ���� ������ �⺻���� ��� (�ڹ��� ���ǹ� �Ǵ� SWITCH���� ����) */
SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB,
        'MANAGER', SAL*1.1, -- 10%
        'SALESMAN', SAL*1.05, -- 5%
        'ANALYST', SAL, -- ����
        SAL*1.03) AS �޿��λ� -- ������ ���� �������� 3%
        FROM EMP;
        
/* CASE�� : �־��� �������� ���� ���ǰ��� ��ġ�ϴ� ���� ����ϰ� ��ġ�ϴ� ���� ������ �⺻���� ��� (�ڹ��� ���ǹ� �Ǵ� SWITCH���� ����) */  
SELECT EMPNO, ENAME, JOB, SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ALANYST' THEN SAL
        ELSE SAL*1.03
    END AS �޿��λ�
FROM EMP;

-- �� ���� ���� ��°��� �޶����� CASE��
SELECT EMPNO, ENAME, COMM,
    CASE
        WHEN COMM IS NULL THEN '�ش� ���� ����'
        WHEN COMM = 0 THEN '���� ����'
        WHEN COMM > 0 THEN '����: ' || COMM
    END AS ����ǥ��
FROM EMP;    
        
/* ���� �ǽ����� */
-- ��ǿ� �ִ� 4���� ����
-- 1.ENAME�� �ټ������� ���, �����ȣ �� ���ڸ��� ǥ���ϰ� �������� ��(*)ǥó��, 
SELECT EMPNO, 
    RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS MASKING_EMPNO, 
    ENAME,
    RPAD(SUBSTR(ENAME,1, 1), LENGTH(ENAME), '*') AS MAKING_ENAME
    FROM EMP
    WHERE LENGTH(ENAME) = 5;
    
-- 1�� ����� ��     
SELECT EMPNO, 
    RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS MASKING_EMPNO, 
    ENAME,
    RPAD(SUBSTR(ENAME,1, 1), 5, '*') AS MAKING_ENAME -- �̸����� ������ �ټ��ڸ��� LENGTH(ENAME) �� �ʿ� X
    FROM EMP
    WHERE LENGTH(ENAME) = 5
    ORDER BY EMPNO;
    

-- 2.  
SELECT EMPNO, ENAME, SAL, 
        ROUND(SAL/21.5, 2) AS DAY_PAY,
        ROUND(SAL/21.5/8, 1) AS TIME_PAY
        FROM EMP;
        
-- 2�� ����� ��  *****    
SELECT EMPNO, ENAME, SAL, 
        TRUNC(SAL/21.5, 2) AS DAY_PAY, -- DAY_PAY�� �Ҽ��� ���ڸ������� ������(TRUNC)
        ROUND(SAL/21.5/8, 1) AS TIME_PAY -- TIME_PAY�� ��° �ڸ����� �ݿø� (ROUND)
        FROM EMP;
        
-- 3. 
SELECT EMPNO, ENAME, HIREDATE,
    NEXT_DAY (ADD_MONTHS(HIREDATE, 3),2) AS R_JOB, 
    CASE
    WHEN COMM IS NULL THEN 'N/A'
    WHEN COMM IS NOT NULL THEN TO_CHAR(COMM)
    END AS COMM    
FROM EMP;

-- 3�� ����� ��
SELECT EMPNO, ENAME, HIREDATE,
    TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '������'), 'YYYY-MM-DD') AS R_JOB, -- 'YYYY-MM-DD' ��������! 
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


-- SCOTT ���� ����
-- 1. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE FROM DUAL;

-- 2. EMP���̺��� ���, �����, �޿� ��ȸ (��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME, TO_CHAR(SAL, '999') AS SAL
    FROM EMP
    ORDER BY SAL DESC;
-- 2�� ����� �� : �޿� 100���������� ���� ��° �ڸ����� �ݿø� �ؾ��Ѵٴ� ��
SELECT EMPNO, ENAME, ROUND(SAL, -2)
    FROM EMP
    ORDER BY 3 DESC;
    

-- 3. �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) != 0;
-- 3�� ����� ��
SELECT *
    FROM EMP
    WHERE MOD(EMPNO, 2) = 1;

    
-- 4. �����, �Ի��� ��ȸ( ��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY') AS YEAR, TO_CHAR(HIREDATE, 'MM') AS MONTH
FROM EMP;
-- 4�� ����� ��
SELECT ENAME, EXTRACT (YEAR FROM HIREDATE) AS �Ի�⵵, EXTRACT(MONTH FROM HIREDATE) AS �Ի��
    FROM EMP;


-- 5. 9���� �Ի��� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE EXTRACT (MONTH FROM HIREDATE) = 9;


-- 6. 81�⵵�� �Ի��� ���� ��ȸ
SELECT *
    FROM EMP
    WHERE EXTRACT (YEAR FROM HIREDATE) = 1981;
    
-- 7. �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%E';
    
-- 8. �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE ENAME LIKE '__R%';
    
-- 9. ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS (HIREDATE, 480) AS �Ի��Ϸκ���40��
    FROM EMP;
-- 9�� ����� �� 
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE, 40*12)
    FROM EMP;

-- 10. �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
    FROM EMP
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) >= 38; 
-- 10�� ����� ��
SELECT *
    FROM EMP
    WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE)/12 >= 38;
    
    
-- 11. ���� ��¥���� �⵵�� ����
SELECT TO_CHAR(SYSDATE, 'YYYY') AS THISYEAR FROM DUAL;
SELECT EXTRACT(YEAR FROM SYSDATE) AS THISYEAR FROM DUAL;

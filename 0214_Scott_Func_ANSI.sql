/* 2022/02/14 ȭ���� */

/* �Լ���? ����Ŭ������ ���� �Լ��� ����ڰ� �ʿ信 ���ؼ� ���� ������ ����� ���� �Լ��� ������ ���ϴ�. 
          ������ �Լ��� ������ �Լ�(���� �Լ�)�� ������ ���ϴ�. */

/* DUAL ���̺� : SYS�������� �����ϴ� ���̺�� �Լ��� ������ ���̺� ���� ���� �����غ��� ���� FROM ���� ����ϴ� ����(DUMMY) ���̺�. ���� ���̺� */          
          
          
/* ���� �Լ� : ������ ������ ó���ϱ� ���� �Լ��� �ǹ� 
             (ABS, ROUND, TRUNC, MOD, CEIL, FLOOR, POWER) */

/* ABS : ���밪 ���ϴ� �Լ� */
-- SELECT -10, ABS(10) FROM EMP;
SELECT -10, ABS(10) FROM DUAL;

/* ROUND : �ݿø��� ����� ��ȯ�ϴ� �Լ� */
SELECT ROUND(1234.5678) AS ROUND, -- �ݿø� �ڸ��� �������� ������ 0���� �ݿø��ѰͰ� ����(�Ҽ��� ���� ù��° �ڸ�)
     ROUND(1234.5678, 0) AS ROUND_0,
     ROUND(1234.5678, 1) AS ROUND_1,
     ROUND(1234.5678, 2) AS ROUND_2,
     ROUND(1234.5678, 3) AS ROUND_3, -- ����� ���� ��ŭ �Ҽ��� �Ʒ��� �̵� 
     ROUND(1234.5678, -1) AS ROUND_MINUS1,
     ROUND(1234.5678, -2) AS ROUND_MINUS2,
     ROUND(1234.5678, -3) AS ROUND_MINUS3
 FROM DUAL;

/* TRUNC : ������ �� ����� ��ȯ�ϴ� �Լ� (ROUND���� �������� 5�̻��̾ ����)*/
SELECT TRUNC(1234.5678) AS TRUNC,
     TRUNC(1234.5678, 0) AS TRUNC_0,
     TRUNC(1234.5678, 1) AS TRUNC_1,
     TRUNC(1234.5678, 2) AS TRUNC_2,
     TRUNC(1234.5678, 3) AS TRUNC_3, 
     TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
     TRUNC(1234.5678, -2) AS TRUNC_MINUS2,
     TRUNC(1234.5678, -3) AS TRUNC_MINUS3
 FROM DUAL;

/* MOD : ������ �� �� �������� ����ϴ� �Լ� */
SELECT MOD(21, 5) FROM DUAL;

/* CEIL : �Ҽ��� ���ϰ� ������ ������ �ø� */
SELECT CEIL(12.001) FROM DUAL; -- 13

/* FLOOR : �Ҽ��� ���ϸ� ������ ���� */
SELECT FLOOR(12.999) FROM DUAL; -- 12

/* POWER : ����A�� ����B��ŭ ���ϴ� �Լ� */
SELECT POWER(3, 4) FROM DUAL;


/* �����Լ� : ���� �����͸� �����ϰų� ���� �����ͷ� ���� Ư�� ����� ����� �� �� ����ϴ� �Լ�
             (UPPER, LOWER, INITCAP) */

/* UPPER : �빮�ڷ� ���� */
/* LOWER : �ҹ��ڷ� ���� */
/* INITCAP : ù���ڴ� �빮�ڷ� �����ϰ� �������� �ҹ��ڷ� ���� */
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
    FROM EMP;
    
    
-- ���� �Լ��� WHERE ���������� ���
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) = UPPER('james'); -- java�� eualsIsnoreCase�� ����� ȿ��

-- ���� �Լ��� LIKE���� �Բ� ���  
SELECT *
    FROM EMP
    WHERE UPPER(ENAME) LIKE UPPER('%ja%'); 
    
-- INITCAP
SELECT INITCAP('woo young woo') AS �̸� FROM DUAL;

/* �������� */
-- ��� �̸��� �빮��, ��å�� ù�� �빮�� �������� �ҹ��ڷ� �����ϰ� �޿��� ���� ������ ���
SELECT UPPER(ENAME) AS �̸�, INITCAP(JOB) AS ��å, SAL AS �޿�
    FROM EMP
    ORDER BY SAL DESC;
    
/* LENGTH : ���ڿ� ���̸� ���ϴ� �Լ� */    
SELECT ENAME, LENGTH(ENAME) AS �̸��Ǳ���
    FROM EMP;

-- �̸��� ���̰� 5�� ���ų� ū ����� �̸�, �����ȣ, ��å�� ���� ������ ǥ��. ��, ���ʽ� ����
SELECT ENAME AS �̸�, EMPNO AS �����ȣ, JOB AS ��å, SAL*12 AS ����
    FROM EMP
    WHERE LENGTH(ENAME) >= 5
    ORDER BY 4 DESC; -- SAL*12 = ���� = 4
    
/* LENGTH vs. LENGTHB */
/* LENGTH  : ���ڿ��� ���̸� ��ȯ  
   LENGTHB : ���ڿ��� ����Ʈ �� ��ȯ */
SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�') -- ����ŬXE �������� �ѱ��� �ѱ��ڰ� 3����Ʈ. MySQL�� �ѱ��ڴ� 1����Ʈ, ��񸶴� �ٸ�   
    FROM DUAL;
    
-- ��å �̸��� 6���� �̻��̰� COMM �� �ִ� ��� ���
SELECT *
    FROM EMP
    WHERE LENGTH(JOB) >= 6 
        AND COMM IS NOT NULL 
        AND COMM != 0; -- (COMM IS NOT NULL OR COMM != 0)�� �ɸ� NOT NULL���� �� ������ �������� 
        


/* SUBSTR/SUBSTRB : ��� ���ڿ��̳� �÷��� �ڷῡ�� ���� ��ġ���� ���� ������ŭ�� ���ڸ� ��ȯ�ϴ� �Լ�. �ε��� ���� �ƴ�
   SUBSTR  : ���ڼ� : SUBSTR(���ڿ�������, ������ġ, ����)
   SUBSTRB : ����Ʈ�� : SUBSTRB(���ڿ�������, ������ġ)                                                         */    
   
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5)
    FROM EMP;
    
-- SUBSTR �Լ��� �ٸ� �Լ� �Բ� ���
SELECT JOB, 
 SUBSTR(JOB, -LENGTH(JOB)), 
 SUBSTR(JOB, -LENGTH(JOB), 2),
 SUBSTR(JOB, -3)
FROM EMP;   


/* INSTR : ���ڿ� ������ �ȿ� Ư�� ���ڳ� ���ڿ��� ��� ���ԵǾ� �ִ��� �˰��� �� �� ��� */
/* INSTR([��� ���ڿ� ������(�ʼ�)],
    [��ġ�� ã������ �κ� ����(�ʼ�)],
    [��ġ ã�⸦ ������ ��� ���ڿ� ������ ��ġ(����, �⺻���� 1)],
    [���� ��ġ���� ã������ ���ڰ� �� ��°���� ����(����, �⺻���� 1)]) */
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1, -- 3
 INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,    -- 12
 INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3  -- 4
FROM DUAL;


SELECT INSTR('HELLO, ORACLE!', 'L', 2, 10) AS INSTR
FROM DUAL;







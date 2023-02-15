/* 2022/02/13 ������ */

/*�ּ�*/
-- �����࿡ ���� �ּ�

/* ��� ���� ���̺� */ 
DESC EMP; 
/* ���ʽ� ���̺� */ 
DESC BONUS;
/* �޿� ���� ���̺� */ 
DESC SALGRADE;

/* SELECT���� �����ͺ��̽��� ����� �����͸� ��ȸ�ϴµ� ����ϴ� ���� �Դϴ� */

/* SELECT [��ȸ�� ��.....] FROM ��ȸ�� ���̺� */
SELECT * FROM EMP;
SELECT EMPNO, ENAME, HIREDATE FROM EMP;
SELECT EMPNO, ENAME FROM EMP;

/* �ǽ� ���� - ��� ��ȣ�� �μ� ��ȣ�� �������� ������ �ۼ��ϱ� */
SELECT EMPNO, DEPTNO FROM EMP;

/* ��Ī(alias) ����ϱ� */

SELECT EMPNO "�� ȣ", ENAME "�� ��" FROM EMP; -- �����̳� Ư������ ��� ����
SELECT EMPNO AS ��ȣ, ENAME AS �̸� FROM EMP;
SELECT EMPNO ��ȣ, ENAME �̸� FROM EMP; -- AS ���� ����

-- �޿�, ���� ����+Ŀ�̼�, Ŀ�̼�
SELECT ENAME, SAL, SAL*12+COMM, COMM FROM EMP;
 -- ALIAS ���
SELECT ENAME, SAL, SAL*12+COMM AS "���ٺ�", COMM FROM EMP;


SHOW USER; -- ���� USER�� ǥ�� ��(ORACLE ���� Ŀ�ǵ�)
SELECT * FROM TAB; -- ��ü ������ ���� ���̺� Ȯ�� �뵵

/* �ߺ� ����(DISTINCT) : �����͸� ��ȸ�� �� ���� �ߺ��Ǵ� ���� ���� �� ��ȸ�Ǵµ�, ���� �ߺ��� ���� �Ѱ����� �����ϰ��� �� �� ����ϴ� Ű���� */
SELECT DEPTNO FROM EMP; -- 12�� ���� ��� �μ���ȣ�� ����
SELECT DISTINCT DEPTNO FROM EMP; -- �μ���ȣ �ߺ� ����

SELECT JOB, DEPTNO FROM EMP;
SELECT DISTINCT JOB, DEPTNO FROM EMP; -- �ΰ��� ���ǿ� ���� �ߺ� ����

/* �÷��� ����ϴ� ���������(+, -, *, /) : �ڷ����� ������ �÷������� ����� ���� ��ȸ�ϰ��� �� �� ���*/
SELECT ENAME, SAL, SAL*12 AS "����"
FROM EMP;

/* ���� ���� : JOB ���� ���� �ߺ� ���� ��� �غ��� */
SELECT DISTINCT JOB FROM EMP;


/* WHERE ���� : �����͸� ��ȸ�� �� ����ڰ� ���ϴ� ���ǿ� �´� �����͸��� ��ȸ�ϰ� ���� �� ��� �ϴ� �� */
SELECT * 
    FROM EMP 
    WHERE DEPTNO = 10; -- SQL���� ������ ���ϴ� �����ڴ� = D�Դϴ�.

/* ���� ���� : �޿��� 2500 �̻��� �����ȣ, �̸�, ����, �޿� ����ϱ� */
SELECT EMPNO, ENAME, JOB, SAL 
    FROM EMP 
    WHERE SAL >= 2500;

/* ���� ���� : WHERE ������ ����� ��� ��ȣ�� 7500 ���� ū ����� ��� �����ȣ, ����̸� �Ի��� �μ���ȣ ����ϱ� */
SELECT EMPNO, ENAME, HIREDATE, DEPTNO
    FROM EMP 
    WHERE EMPNO > 7500;
    
/* ��������� : +, -, *, / */
SELECT *
    FROM EMP
    WHERE SAL * 12 = 36000;
    

/* �񱳿����� :  >, >=, <, <= */
-- Ŀ�̼��� 500 �̻��� ����� ���
SELECT *
    FROM EMP
    WHERE COMM >= 500; 

/* �Ի����� 81�� 1�� 1�� ���� �� ����� ��� ��� */
SELECT *
    FROM EMP
    WHERE HIREDATE > '81/01/01'; -- ��¥�� ���ڿ��� ���� ���� ''�� ���� �־�� �մϴ�.
    
/* ������ ��������� ����� ��� */
SELECT *
    FROM EMP
    WHERE JOB = 'SALESMAN'; -- ���ڿ� �񱳽� ��ҹ��� ����

/* �������� : AND, OR, NOT */
-- �޿��� 2500�̻��̰� �μ��� 20���� ����� ��� ��� (������ �� �� �����ؾ� �� AND)
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20;

-- �޿��� 2500�̻��̰ų� �μ��� 20���� ����� ��� ��� (������ �� �� �ϳ��� �����ص� �� OR)
SELECT *
    FROM EMP
    WHERE SAL >= 2500 OR DEPTNO = 20;
    

-- �޿��� 2500�̻��̰� �Ի����� 82�� 1�� 1�� ���� �Ի��� ���
SELECT * FROM EMP;

SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND DEPTNO = 20 AND HIREDATE < '82/01/01'; 
    
    
-- �޿��� 2000 �̻��̰� ������ MANAGER�� ����� �����ȣ, �̸�, ��å, �޿�, �μ���ȣ�� ���
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';
    
SELECT EMPNO �����ȣ, ENAME �̸�, JOB ��å, SAL �޿�, DEPTNO �μ���ȣ
    FROM EMP
    WHERE SAL >= 2000 AND JOB = 'MANAGER';
    
-- ������ ������ ����ϱ� : NOT 
-- �޿��� 2500�̻��̰� ������ SALESMAN�� �ƴ� ����� ����ϱ�
SELECT *
    FROM EMP
    WHERE SAL >= 2500 AND JOB != 'SALESMAN';

/* IN ������ : ���� ���θ� Ȯ���ϴ� ��. Ư�� ���� ���Ե� �����͸� ������ ��ȸ�� �� Ȱ�� */
SELECT * 
    FROM EMP
    WHERE job = 'MANAGER' 
    OR JOB = 'SALESMAN'
    OR JOB = 'CLERK';

SELECT *
    FROM EMP
    WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');
    -- WHERE [�� �̸�] IN (������1, ������2, ������N...)
    

-- dpetno��  20, 30�� ������� ������ ��ȸ
SELECT EMPNO �����ȣ, ENAME �̸�, HIREDATE �Ի��� , SAL �޿�
    FROM EMP
    WHERE DEPTNO IN (20, 30);
    
-- � �񱳿����ڿ� AND ������
SELECT * 
    FROM EMP
    WHERE JOB != 'MANAGER'
    AND JOB <> 'SALESMAN'
    AND JOB ^= 'CLERK';

/* ���� ������ �����ϴ� BETWEEN ������ */    
-- �޿��� 2000 �̻� 3000 ����, �� �޿��� 2000 ~ 3000�� ��� �����͸� ��ȸ
SELECT *
    FROM EMP
    WHERE SAL >= 2000
        AND SAL <= 3000;
-- BETWEEN AND ���̿� �ִ� ������ �� �� ���Ե�        
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 2000 AND 3000;
    
    
    
-- BETWEEN ���� ����ؼ� �޿��� 1000���� 2500 �����̰� �μ��� 10, 30�� ����� ��� �ϱ�
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO IN (10, 30);
        
        
        
-- BETWEEN ���� ����ؼ� �޿��� 1000 ���� 2500 �����̰�, �μ��� 10, 20�� �ƴ� ��� ���
SELECT *
    FROM EMP
    WHERE SAL BETWEEN 1000 AND 2500
        AND DEPTNO NOT IN (10, 20);

-- BETWEEN ���� ����ؼ� �����ȣ�� 7000���� 7999 �����̰�, �Ի����� 81�� 5�� 1�� ���� �� ��� ���
SELECT *
    FROM EMP
    WHERE EMPNO BETWEEN 7000 AND 7999
        AND HIREDATE > '1981/05/01';







-- 1980���� �ƴ� �ؿ� �Ի��� ������ ��ȸ    
SELECT *
    FROM EMP
    WHERE HIREDATE NOT BETWEEN '80/01/01' AND '80/12/31';
SELECT *
    FROM EMP
    WHERE NOT HIREDATE BETWEEN '80/01/01' AND '80/12/31';
-- EXTRACT ���� ����ϴ� ���
SELECT *
    FROM EMP 
    WHERE EXTRACT (YEAR FROM HIREDATE) != 1980;
-- EXTRACT �� ����:  12�� �Ի��� ���
SELECT *
    FROM EMP 
    WHERE EXTRACT (MONTH FROM HIREDATE) = 12;
    
/* LIKE ���� �Ϻ� ���ڿ��� ���ԵǾ� �ִ��� ���θ� Ȯ�� �� �� ��� */
-- % : ���̿� ������� ��� ���� �����͸� �ǹ�
-- _ : ���� 1���� �ǹ�

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%%'; -- '%%'�� ��� ���� = ������ X

SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S%'; -- S �����Ե� ����. ���� ��� X. S�� ���� ��, ���� �ڿ��� �� �� ���� 
    
SELECT *
    FROM EMP
    WHERE ENAME LIKE 'S____'; -- SMITH�� ã������ S_ _ _ _. S_�� �ϸ� �ȳ���. 

SELECT *
    FROM EMP
    WHERE ENAME LIKE '_L%';
    
-- �̸��� AM�� ���ԵǾ� �ִ� ��� ���  
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%AM%';
     
-- �̸��� AM�� ���ԵǾ� ���� ���� ��� ���  
SELECT *
    FROM EMP
    WHERE ENAME NOT LIKE '%AM%';
    
/* ���ϵ�ī�� ���ڰ� ������ �Ϻ��� ��� */
-- ���̺� �� �ֱ�
INSERT INTO EMP VALUES(9999, 'TEST%PP', 'SALESMAN', 7698, TO_DATE('23-02-14','DD-MM-YY'), 2000, 1000, 30); -- �Ի翬�� �̻��� 
SELECT * FROM EMP;
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%\%%' ESCAPE '\'; -- \=�����. \�ٷ� ���� ���ڴ� ��¥ ã�� ����

-- ���̺��� �� ����� (�ش��ϴ� �̸��� ������ ����)
DELETE FROM EMP 
    WHERE ENAME = 'TEST%PP';
    
/* IS NULL */
-- NULL�̶� ? 0�� �ƴϰ� �� ������ �ƴ��� �ǹ�. ��, ��Ȯ���� ���̶�� �ǹ�. ���� �� ��, �Ҵ��� �Ұ���. (DB������ ���� ���� �����ϱ� ������ ������ ������ ����)
SELECT *
    FROM EMP
    WHERE COMM = NULL; -- NULL�� ���� �� �� �� ��� ��°� �ȳ���
-- NULL�� ��ȸ�� ���� IS ������ ���    
SELECT *
    FROM EMP
    WHERE COMM IS NULL; 
-- NULL�� �����ϰ� ��ȸ�� ��. 
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;   
    -- TURNER�� COMM�� 0�� 0���� Ȯ���� ���̶� NULL�� �ٸ�. 
    
-- MGR�� �ִ� ����� ����ϱ�
SELECT * 
    FROM EMP
    WHERE MGR IS NOT NULL;
    

/* ORDER BY �� : Ư�� �÷��� �����͸� �������� ���������̳� ������������ �����ϴ� ����� �ϴ� ��. ���� �������� ����Ǿ�� �ϸ� �����ϸ� ���� ����  */
-- ������ ���� ORDER BY ��. ���� �� �� ���� ������ �κп� ��. DB�� ũ�� ���ɿ� ������ ��ħ
SELECT *
    FROM EMP
    ORDER BY SAL ASC;
    -- ORDER BY��ü�� ���� ��ɾ�� ASC ������ �ʾƵ� �ڵ� �������� ����
    
    
-- ��� ��ȣ �������� ���������� �ǵ��� �ۼ�    
SELECT *
    FROM EMP
    ORDER BY EMPNO;
-- �޿� �������� �������� �ϰ� �޿��� ���� ��� �̸� �������� ���� 
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME;
-- �޿� �������� �������� �ϰ� �ݿ��� ���� ��� �̸��� ������������ ����
SELECT *
    FROM EMP
    ORDER BY SAL, ENAME DESC;

/* ��Ī ���� ORDER BY */
SELECT EMPNO �����ȣ, ENAME �����, SAL ����, HIREDATE �Ի���     -- STEP 2
    FROM EMP                                                    -- STEP 1
    ORDER BY ���� DESC, ����� ASC;                              -- STEP 3
    
    
/* ���� ������ (||): SELECT ��ȸ�� �÷� ���̿� Ư���� ���ڸ� �ְ� ���� �� ����ϴ� ������ */
SELECT ENAME || 's JOB IS ' || JOB AS EMPLOYEE
    FROM EMP;


    
/****** �ǽ����� *******/    
-- 1. S�� ������ ��� 
SELECT *
    FROM EMP
    WHERE ENAME LIKE '%S';
    
-- 2. 30�� �μ�, ��å 'SALESMAN'
SELECT EMPNO �����ȣ, ENAME �̸�, JOB ��å, SAL �޿�, DEPTNO �μ���ȣ  -- STEP 3
    FROM EMP                                                        -- STEP 1
    WHERE DEPTNO = 30 AND JOB = 'SALESMAN';                         -- STEP 2
        
-- 3. 20,30�� �μ��� �ٹ�, �޿� 2000�ʰ� 
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO IN (20, 30) --   WHERE DEPTNO BETWEEN 20 AND 30
    AND SAL > 2000;

-- 4. BETWEEN ������ ����, �޿��� 2000 �̻� 3000 ���ϸ� ���� 
SELECT *
    FROM EMP
    WHERE SAL NOT BETWEEN 2000 AND 3000; -- WHERE SAL < 2000 OR SAL > 3000;
SELECT *
    FROM EMP
    WHERE SAL < 2000 OR SAL > 3000;
    
-- 5. �̸��� E�� ����, 30�� �μ�, 1000 ~ 2000���̰� �ƴ� 
SELECT ENAME, EMPNO, SAL, DEPTNO
    FROM EMP
    WHERE DEPTNO = 30 
    AND ENAME LIKE '%E%'
    AND SAL NOT BETWEEN 1000 AND 2000;
/*
SELECT EMPNO, ENAME, SAL, DEPTNO
    FROM EMP
    WHERE ENAME LIKE '%E%' -- �̸� ����
    AND DEPTNO = 30
    AND SAL NOT BETWEEN 1000 AND 2000;
*/
    
-- 6. 
SELECT *
    FROM EMP 
    WHERE COMM IS NULL AND MGR IS NOT NULL
    AND JOB IN ('MANAGER', 'CLERK') -- AND JOB = 'MANAGER' OR JOB = 'CLERK' -> ��� �ȵ� 
    AND ENAME NOT LIKE '_L%';
/* SELECT *
FROM EMP
WHERE COMM IS NULL OR COMM = 0
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%';*/

SELECT *
FROM EMP
WHERE (COMM IS NULL OR COMM = 0) -- ���⼭ �ȹ����� COMM IS NULL OOOORRRR �� �� NULL�̰ų� �ƴϸ� ~ 
AND MGR IS NOT NULL
AND JOB IN ('MANAGER', 'CLERK')
AND ENAME NOT LIKE '_L%'

-- ó�� ���� �� ���׷��̵�
SELECT *
    FROM EMP
    WHERE (COMM IS NULL OR COMM = 0)
    AND MGR IS NOT NULL
    AND (JOB = 'MANAGER' OR JOB = 'CLERK')
    AND ENAME NOT LIKE '_L%'
    














/* �߰� ���� Ǯ�� */
-- 1. COMM�� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- 2. COMM�� ���� ���ϴ� ���� ��ȸ
SELECT ENAME
    FROM EMP
    WHERE COMM IS NULL OR COMM = 0;
    
-- 3. �����ڰ� ���� ���� ��ȸ
SELECT ENAME
    FROM EMP
    WHERE MGR IS NULL;
    
-- 4. �޿��� ���� �޴� ���� ������ ��ȸ
SELECT *
    FROM EMP
    ORDER BY SAL DESC;
    
-- 5. �޿��� ���� ��� COMM�� �������� ���� ��ȸ
SELECT *
    FROM EMP
    ORDER BY SAL DESC, COMM DESC;
    
-- 6. �����ȣ, �����, ����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO, ENAME, JOB, HIREDATE
    FROM EMP
    --ORDER BY 4; --�÷��� ������ �Է��ص� �� 
    ORDER BY HIREDATE;
    
    
-- 7. �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO, ENAME
    FROM EMP
    ORDER BY EMPNO DESC;
    
-- 8. �����ȣ, �Ի���, �����, �޿� ��ȸ (�μ���ȣ�� ���� ������, �μ� ��ȣ�� ������ �ֱ� �Ի��� ������ ó��)
SELECT EMPNO, HIREDATE, ENAME, SAL
    FROM EMP
    ORDER BY DEPTNO, HIREDATE DESC;
    
 
-- 9. EMPNO Ȧ��?    
SELECT EMPNO, ENAME
    FROM EMP
    WHERE MOD(EMPNO, 2) = 1;
    
-- 10. EMPNO ¦��?    
SELECT EMPNO, ENAME
    FROM EMP
    WHERE MOD(EMPNO, 2) = 0;    

    
    

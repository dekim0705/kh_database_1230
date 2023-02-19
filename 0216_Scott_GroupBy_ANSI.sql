/* ������ �ռ��� ������ �׷�ȭ :
   ������ �Լ� : ���� �࿡ ���� �Լ��� ����Ǿ� �ϳ��� ����� ��Ÿ���� �Լ� �Դϴ�.
              : = ���� �Լ�  
*/

SELECT* FROM emp;
SELECT ename, sal FROM emp; -- �̸��� �޿�
SELECT SUM(sal) FROM emp; -- SUM�� ����� �ϳ��� ���� 
SELECT SUM(sal), ename FROM emp; -- ����. SUM�� 1��, ename�� 12��

SELECT deptno, SUM(sal)
    FROM emp; -- ����
SELECT deptno, SUM(sal)
    FROM emp
    GROUP BY deptno; -- deptno������ ��� ��� 
    
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
    
/* SUM : �հ踦 ���ϴ� �Լ� 
       : SUM�� �ɼ� 1)DISTINCT : �ߺ� ����, 2)ALL : ������� �ʾƵ� �⺻������ ALL Ư���� ���� 
*/
SELECT SAL  FROM EMP;
SELECT SUM(DISTINCT SAL) AS �ߺ�����, SUM(ALL SAL) AS ����, SUM(SAL) AS �⺻
    FROM EMP;               
    
SELECT SUM(SAL), SUM(COMM) 
    FROM EMP;   
    
SELECT COUNT(*) FROM EMP;  -- �� ������� Ȯ��
SELECT COUNT(COMM) FROM EMP; -- COMM�� NULL�� �ƴ� ����� �� (NULL ����!)

SELECT COUNT(COMM)
    FROM EMP
    WHERE COMM IS NOT NULL;
    
-- �μ� ��ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի���
SELECT MAX(HIREDATE)
    FROM EMP
    WHERE DEPTNO = 20;
    
/* GROUP BY�� : �ϳ��� ����� Ư�� ���� ��� ����ϴ� ���� '�׷�ȭ'�Ѵٰ� ��. �̶� ����ؾ� �� ��� ������ GROUP BY �� ���� */

-- �μ��� �޿� ��� (GROUP BY�� ���)
SELECT TRUNC(AVG(SAL)), DEPTNO
    FROM EMP
    GROUP BY DEPTNO; -- �׷����� ����� ����� �� 
-- �μ��� ��� �޿� (WHERE�� ���)
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 10;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 20;
SELECT TRUNC(AVG(SAL)) FROM EMP WHERE DEPTNO = 30;

-- �μ� ��ȣ �� ��å�� ��� �޿��� ����
SELECT DEPTNO, JOB, TRUNC(AVG(SAL))
    FROM EMP
    GROUP BY DEPTNO, JOB
    ORDER BY DEPTNO, JOB;

-- �μ� ��ȣ�� ��� �߰� ������ ���
SELECT DEPTNO, AVG(COMM)
    FROM EMP
    GROUP BY DEPTNO;
-- NULL�� 0���� ó��
SELECT DEPTNO, NVL(AVG(COMM), 0)
    FROM EMP
    GROUP BY DEPTNO;

-- �μ� �ڵ�, �޿� �հ�, �μ� ���, �μ� �ο�����  �μ��ڵ� ������ ����
SELECT DEPTNO �μ��ڵ�, SUM(SAL) �޿��հ�, FLOOR(AVG(SAL)) �޿����, COUNT(*) �ο���
    FROM EMP 
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
/* HAVING �� : SELECT���� GROUP BY ���� ������ ���� ��� ���� 
             : GROUP BY���� ���� �׷�ȭ�� ��� ���� ������ ���ѽ� ���
*/
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;
       
-- WHERE���� HAVING���� ��� ����� ���
SELECT DEPTNO, JOB, AVG(SAL)
    FROM EMP                -- ù��° ���� : 12�� ���� ����
    WHERE SAL <= 3000       -- �ι�° ���� : ���� 11���� ������ �ɸ� ����(SAL�� 5000�� CEO������)
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 2000
    ORDER BY DEPTNO, JOB;  
    
/* �������� */    
-- 1. HAVING���� ����Ͽ� EMP ���̺��� �μ��� ��å�� ��� �޿��� 500 �̻��� ������� �μ� ��ȣ, ��å, �μ��� ��å�� ��� �޿��� ���
SELECT DEPTNO �μ���ȣ, JOB ��å, AVG(SAL) ��ձ޿�
    FROM EMP
    GROUP BY DEPTNO, JOB
        HAVING AVG(SAL) >= 500
    ORDER BY DEPTNO, JOB; 
    
-- 2. EMP ���̺��� �̿��Ͽ� �μ���ȣ, ��ձ޿�, �ְ�޿�, �����޿�, ������� ���,  ��, ��� �޿��� ��� �� ���� �Ҽ��� �����ϰ� �μ� ��ȣ���� ���    
SELECT DEPTNO �μ���ȣ, TRUNC(AVG(SAL)) ��ձ޿�, MAX(SAL) �ְ�޿�, MIN(SAL) �����޿�, COUNT(*) �����
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY DEPTNO;
    
-- 3. ���� ��å�� �����ϴ� ����� 3�� �̻��� ��å�� �ο��� ���
SELECT JOB ��å, COUNT(*) �ο�
    FROM EMP
    GROUP BY JOB
        HAVING COUNT(*) >= 3;    
        
-- 4. ������� �Ի� ������ �������� �μ����� �� ���� �Ի��ߴ��� ���
SELECT EXTRACT(YEAR FROM HIREDATE) �Ի���, DEPTNO �μ���ȣ, COUNT(*) �����
    FROM EMP
    GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE)
    ORDER BY COUNT(*);

-- 5. �߰� ������ �޴� ��� ���� ���� �ʴ� ������� ��� (O, X�� ǥ�� �ʿ�)
SELECT NVL2(COMM, 'O', 'X') �߰�����, COUNT(*) �����
    FROM EMP
    GROUP BY NVL2(COMM, 'O', 'X');

--6. �� �μ��� �Ի� ������ ��� ��, �ְ� �޿�, �޿� ��, ��� �޿��� ���
SELECT DEPTNO, EXTRACT(YEAR FROM HIREDATE) �Ի�⵵, COUNT(*) �����, 
        MAX(SAL) �ְ�޿�, TRUNC(AVG(SAL)) ��ձ޿�, SUM(SAL) �޿���
        FROM EMP
        GROUP BY DEPTNO, EXTRACT(YEAR FROM HIREDATE);
    

-- 2022/02/17 �߰� 
/* ROLLUP �Լ��� ������ �׷�ȭ : ����� ���� �ұ׷���� ��׷��� ������ �� �׷캰 ����� ����ϰ� �������� �� ������ ����� ��� */
SELECT deptno, job, COUNT(*), MAX(sal), SUM(sal), AVG(sal)
    FROM EMP
    GROUP BY ROLLUP(deptno, job);

/* 2023/02/20 */
/* �������� : SQL�� �ȿ� �ۼ��ϴ� ���� SQL ���� �ǹ���. �ַ� WHERE���� ��� 
           : ���������� �ݵ�� ��ȣ(��������) �ȿ� �־� ǥ��                
    ���������� Ư¡ : 1) ��ȸ ����� �����ʿ� ���̸� () ��� ���
                    2) ��κ��� ��� ORDER BY���� ����� �� ����
                    3) ���������� ���� ���������� ����� ���� �ڷ����̰ų� ���� ������ ���� �ؾ� ��
                    4) ���������� ���������� �����ڿ� �Բ� ��ȣ �ۿ��ϴ� ��Ŀ� ���� ������ ���� ������ ������ ���� ���� */
                    /* ���������� ����� �������� ��ȯ�� ������ ������ ���������� ����ؾ� ��. (Ex3���� ALLEN�� �θ� �̻��� ���� ����) */  


/* ������ ��������(single-row subquesry)�� ���� ����� �� �ϳ��� ������ ������ ���������� ����. ������ �����ڷ� �� ���� */ 

-- Ex1. ��KING���� ����� �μ���ȣ�� ��ȸ�ϴ� ���������� �� ����� �μ����� ��ȸ�ϴ� ���� ����
SELECT dname -- ���� �������� �μ� �̸��� �μ� ��ȣ�� ���ؼ� ���ϴ� ����� ã��
    FROM dept
    WHERE deptno = (SELECT deptno  -- ����� �̸����� ����� ���� �μ� ��ȣ�� ã��(��������)
                        FROM emp
                        WHERE ename = 'KING');

-- Ex2. ���������� 'JONES'�� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�
SELECT *
    FROM emp
    WHERE sal > (SELECT sal
                    FROM emp
                    WHERE ename = 'JONES');
                    
-- Ex3. ���������� ����Ͽ� EMP ���̺��� ��� ���� �߿��� ��� �̸��� ALLEN�� ����� �߰� ���� ���� ���� �߰� ������ �޴� ��� ������ ���ϵ��� �ڵ� �ۼ�   
SELECT *
    FROM emp
    WHERE comm > (SELECT comm
                    FROM emp 
                    WHERE ename = 'ALLEN');
                    
-- Ex4. JAMES���� ���� �Ի��� ��� ���� ���
SELECT *
    FROM emp
    WHERE hiredate < (SELECT hiredate
                        FROM emp
                        WHERE ename = 'JAMES');
              
-- Ex5. 20�� �μ��� ���� ��� �� ��ü ����� ��� �޿����� ���� �޿��� �޴� ��� ������ �Ҽ� �μ� ������ ��ȸ�ϴ� ��쿡 ���� ������ �ۼ�
SELECT AVG(sal) FROM emp; -- ��ü sal��� : 2077.08333...  (��������)          
SELECT empno, ename, job, sal, d.deptno, dname, loc -- ��������
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE d.deptno = 20
    AND sal > (SELECT AVG(sal)
                    FROM emp);


/* ������ ��������(multiple-row subquesry) : ���� ��� ���� ���� ���� ������ ��������
   ������ ������ : 1) IN        : ���������� �����Ͱ� ���������� ��� �� �ϳ��� ��ġ�ϸ� true
                 2) ANY, SOME : ���� ������ ���ǽ��� �����ϴ� ���������� ����� �ϳ� �̻��̸� true 
                 3) ALL       : ���������� ���ǽ��� ���������� ��� ��ΰ� �����ϸ� true
                 4) EXITST    : ���������� ����� �����ϸ�(��, ���� 1�� �̻��� ���) true               */
   
   
-- Ex1. �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ��� (IN ������)
SELECT *
    FROM emp
    WHERE sal IN (SELECT MAX(sal)
                    FROM emp -- ��������� �ϸ� ������ ����, ��ü ����� �ְ� �޿� = 1��
                    GROUP BY deptno); -- GROUP BY�� �߰��Ǿ �μ����� �ְ�޿��� ���� = 3��. (�μ��� 3���ϱ� �� �μ����� MAX(sal)�� ������� ��µ� 

-- Ex2. ��SALESMAN������ �޿��� ���� �޿��� �޴� ����� ��ȸ (ANY ������)
SELECT sal FROM emp WHERE job = 'SALESMAN'; -- 1600, 1250, 1250, 1500 (1250���� ������ �� ����)
SELECT *
    FROM emp
    WHERE sal = ANY (SELECT sal -- ���������� ������� 4��, ������������ �� �� �ϳ��̻� �����Ǹ� ��ȯ
                    FROM emp
                    WHERE job = 'SALESMAN');
 
-- Ex3. 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ��� (ANY ������)
SELECT MAX(sal) FROM emp WHERE deptno = 30; -- 2850
SELECT *
    FROM emp
    WHERE sal < ANY (SELECT MAX(sal)
                        FROM emp
                        WHERE deptno = 30);               
-- ������ �������� ���
SELECT SAL FROM EMP WHERE DEPTNO = 30; -- 1600, 1250, 1250, 2850, 1500, 950�� �����µ� �� �� 2850���� �޿��� ���� ����鸸 ��� �� 
SELECT *
    FROM EMP
    WHERE SAL < ANY(SELECT SAL 
                FROM EMP
                WHERE DEPTNO = 30)
    ORDER BY SAL, EMPNO;
                                        
-- Ex 4. �μ� ��ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� �޴� ��� ���
SELECT MIN(sal)  FROM emp WHERE deptno = 30;     
SELECT *
    FROM emp
    WHERE sal < ALL (SELECT MIN(sal)
                        FROM emp
                        WHERE deptno = 30);                     
-- ������ �������� ���
SELECT SAL FROM EMP WHERE DEPTNO = 30; -- 1600, 1250, 1250, 2850, 1500, 950
SELECT *
    FROM EMP
    WHERE SAL < ALL (SELECT SAL
                        FROM EMP
                        WHERE DEPTNO = 30);
                        
-- Ex5. �������� ��� ���� �����ϴ� ���
SELECT *
    FROM emp
    WHERE EXISTS (SELECT dname
                    FROM dept
                    WHERE deptno = 10); -- 10�� �μ��� �����ϸ� ��� �� ��� 

-- Ex6. �������� ��� ���� �������� �ʴ� ���
SELECT *
    FROM emp
    WHERE EXISTS (SELECT dname
                    FROM dept
                    WHERE deptno = 50); -- 50�� �μ��� �����ϸ� ��� �� ��� 
                    
                    
/* ���� �� �������� : ���������� ����� �� �� �̻��� �÷����� ��ȯ�Ǿ� ���� ������ ���� ��  */        
-- Ex1
SELECT deptno, sal FROM emp WHERE deptno = 30;
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE (deptno, sal) IN (SELECT deptno, sal
                            FROM emp
                            WHERE deptno = 30);

-- Ex2. GROUP BY ���� ���Ե� ���߿� ��������
SELECT deptno, MAX(sal) FROM emp GROUP BY deptno;
SELECT *
    FROM emp
    WHERE (deptno, sal) IN (SELECT deptno, MAX(sal)
                            FROM emp
                            GROUP BY deptno);


/* FROM ���� ����ϴ� ���� ���� 
    : ���� ������ FROM���� ���������� �̿��ϴ� ������� �ٸ� ���δ� �ζ��κ��� ��.
    : ���̺��� �ʹ� Ŀ�� �Ϻκи� ����ϰ��� �ϴ� ���
    : ���Ȼ� �����ְ� ���� ���� ���� �ؾ� �ϴ� ���                                */
-- Ex1.  
SELECT e.ename, e.ename, e.deptno, d.dname, d.loc
    FROM(SELECT * FROM emp WHERE deptno = 10) e,         
        (SELECT * FROM dept) d
    WHERE e.deptno = d.deptno;    

-- Ex2. ���� �����ϰ� �ش� ������ �������� (�޿� ������������ ���� �� ���� 3�� ���)
/* ROWNUM : ����Ŭ���� �Ϸù�ȣ�� �ο��ϱ� ���ؼ� ���Ǵ� ����� (��, ���ȣ �ű��) */    
SELECT ROWNUM, ename, sal
    FROM(SELECT * FROM emp ORDER BY sal DESC)
    WHERE ROWNUM <= 3;
    
/* SELECT ���� ����ϴ� ���� ����
    : SELECT������ ���̴� ���� �� ���������� ��Į�� �������� ��� ��
    : SELECT���� ����ϴ� ���������� �ݵ�� �ϳ��� ����� ��ȯ�ϵ��� �ۼ��ؾ� ��      */
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

-- Ex2. �� �ึ�� �μ���ȣ�� �� ���� �μ���ȣ�� ������ ������� SAL ����� ���ؼ� ��ȯ
SELECT ename, deptno, sal, 
    (SELECT TRUNC(AVG(sal)) 
        FROM emp 
        WHERE deptno = e.deptno) AS AVGDEPTSAL
    FROM emp e;
    
-- Ex3. �μ� ��ġ�� NEW YORK �� ��쿡 �����, �� �� �μ��� �������� ��ȯ
SELECT empno, ename,
    CASE WHEN deptno = (SELECT deptno
                        FROM dept
                        WHERE loc = 'NEW YORK')
        THEN '����' 
        ELSE '����' 
    END AS �Ҽ�    
FROM emp        
ORDER BY �Ҽ� DESC;



/* ��ǿ� �ִ� ���� ���� */                              
-- 1. ��ü ��� �� ALLEN�� ���� ��å�� ������� ��� ����, �μ� ���� ���
    -- (��å, �����ȣ, �̸�, �μ���ȣ, �μ��̸�)
SELECT job, empno, ename, sal, e.deptno, dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno 
    WHERE job = (SELECT job
                    FROM emp
                    WHERE ename = 'ALLEN');

-- 2. ��ü ����� ��� �޿� ���� ���� �޿��� �޴� ������� ��� ����, �μ� ����, �޿� ��� ������ ���
    -- (�����ȣ, ����̸�, �μ��̸�, �Ի���, �μ���ġ, �޿�, �޿� ���)
SELECT empno, ename, dname, hiredate, loc, sal, 
    (SELECT grade
        FROM salgrade WHERE e.sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE sal > (SELECT TRUNC(AVG(sal))
                    FROM emp)
    ORDER BY sal DESC, ename;   
-- ����� �� (ORACLE)
SELECT empno, ename, dname, hiredate, loc, sal, grade
    FROM emp e, dept d, salgrade s
    WHERE e.deptno = d.deptno AND e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT AVG(sal) FROM emp)
    ORDER BY e.sal DESC, e.empno;
-- ����� �� (ANSI)
SELECT empno, ename, dname, hiredate, loc, sal, grade
    FROM emp e
    JOIN dept d ON e.deptno = d.deptno
    JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT AVG(sal) FROM emp)
    ORDER BY e.sal DESC, e.empno;


-- 3. 10�� �μ��� �ٹ��ϴ� ��� �� 30�� �μ����� �������� �ʴ� ��å�� ���� ������� ��� ����, �μ� ���� ���
    -- (�����ȣ, ����̸�, ��å, �μ���ȣ, �μ��̸�, �μ���ġ)
SELECT empno, ename, job, e.deptno, dname, loc
    FROM (SELECT * FROM emp WHERE deptno = 10)  e
    JOIN dept d
    ON e.deptno = d.deptno
    WHERE job NOT IN (SELECT job 
                        FROM emp
                        WHERE deptno = 30);
-- ����� ��
SELECT empno, ename, job, e.deptno, dname, loc
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE e.deptno = 10
    AND job NOT IN (SELECT job FROM emp WHERE deptno = 30);

-- 4. ��å�� SALESMAN�� ������� �ְ� �޿����� ���� �޿��� �޴� ������� ���� ���
    -- (�����ȣ, ����̸�, �޿�, �޿����) + ��� ��ȣ �������� �������� ����

-- ���߼������� ���
SELECT empno, ename, sal, (SELECT grade
        FROM salgrade WHERE sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp
    WHERE sal > ALL (SELECT sal
                        FROM emp
                        WHERE job = 'SALESMAN')
    ORDER BY empno;                    
-- ���ϼ������� ���                
SELECT empno, ename, sal, (SELECT grade
        FROM salgrade WHERE sal BETWEEN losal AND hisal) AS SALGRADE
    FROM emp
    WHERE sal > (SELECT TRUNC(MAX(sal))
                        FROM emp
                        WHERE job = 'SALESMAN')
    ORDER BY empno;  
-- ����� ��
SELECT empno, ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal AND s.hisal
    AND sal > (SELECT MAX(sal) FROM emp WHERE job = 'SALESMAN')
    ORDER BY e.empno;
-- ����� �� (ANSI)
SELECT empno, ename, sal, grade
    FROM emp e JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal
    WHERE sal > ALL (SELECT sal FROM emp WHERE job = 'SALESMAN')
    ORDER BY e.empno;
    
    
-- salgrade�� ȥ�� �غ��� ;    
SELECT * FROM salgrade;    

SELECT ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN losal AND hisal;

SELECT ename, sal, 
        (SELECT grade FROM salgrade WHERE sal BETWEEN losal AND hisal) grade
    FROM emp
    ORDER BY sal;
    

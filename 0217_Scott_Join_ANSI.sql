/* 2022/02/17 �ݿ��� */
    
/* ���� ������ : �� �� �̻��� ���� ����� �ϳ��� �����ϴ� ������
    UNION     : ������, �ߺ� ����
    UNION ALL : ������, �ߺ����� ���� ����
    MINUS     : ������
    INTERSECT : ������
                                                            */   
/* UNION(������) : �ߺ� ����*/
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 20;
        
-- UNION : ���� ������ �ڷᰡ �ٸ��� �ȵ� 
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION    
SELECT ename, empno, deptno, sal
    FROM emp
    WHERE deptno = 10;

/* UNION ALL(������) : �ߺ����� ���� */
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE deptno = 10
UNION ALL
SELECT empno, ename, sal, deptno
    FROM emp
    WHERE ENAME = 'FORD';
    
/* INTERSECT(������) �ΰ��� �������� ��� ���ԵǾ� �ִ� �����͸� ǥ�� */
SELECT empno, ename, sal
    FROM emp
    WHERE sal > 1000
INTERSECT
SELECT empno, ename, sal
    FROM emp
    WHERE SAL < 2000;
    
/* MINUS(������) : ���� ������ ������� ���� ������ ����� �� �� */
SELECT empno, ename, sal
    FROM emp
MINUS
SELECT empno, ename, sal
    FROM emp
    WHERE sal > 2000;


/* JOIN : �� �� �̻��� ���̺��� �����͸� �����ͼ� PK�� FK���� ����Ͽ� ���� */    
/* ���̺� �ĺ� �� Primary Key : IS NOT NULL, unique
   ���̺� �� ���� �� Foreign Key : PK of a table */
/* INNER JOIN : �� ���̺��� ��ġ�ϴ� �����͸� ����
   LEFT JOIN  : ���� ���̺��� ��� �����Ϳ� ������ �����Ϳ��� ��ġ�ϴ� �����͸� ����
   RIGHT JOIN : ������ ���̺��� ��� �����Ϳ� ���� ���̺��� ��ġ�ϴ� �����͸� ���� */


/* CROSS JOIN (ī�׽þ� ��) : ���� ������ ���������� �ʾƼ� �� ���� ���̺��� ��翭�� ���յǾ� ������ * ������ ��ŭ�� ����� ǥ�õ�   */
SELECT * 
    FROM emp, dept; -- emp * dept

/* INNER JOIN */
SELECT *
    FROM emp, dept
    WHERE emp.deptno = dept.deptno; -- emp�� FK, dept�� PK

/* ���̺� ��Ī �ֱ� */
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc -- deptno �ߺ� X
-- SELECT������ ��Ī�� ��� ������ deptno�� �� ���̺��� �ߺ��� �Ǳ⶧���� deptno�� ��Ī�� ��� �� !
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;


/* � ���� : ���̺��� ������ �Ŀ� ��� ���� �� ���̺��� Ư�� ���� ��ġ�� ������ �������� �����ϴ� �ٽ�
            : 1)ANSI JOIN, 2)ORACLE JOIN   
            : ANSI JOIN�� ORACLE JOIN���� JOIN���¸� �˷��ִ� �������� ����*/ 
            
/* ANSI JOIN (American National Standard Institute) : ����Ŭ 10g ���� ��� ���� */            
SELECT empno, ename, job, e.deptno, dname, loc 
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno  
    WHERE job = 'MANAGER';
/* ORACLE JOIN : ����Ŭ 9i ������ ����Ŭ ���θ� ��� ���� �߾��� */    
SELECT e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
    FROM emp e, dept d
    WHERE job = 'MANAGER' 
    AND e.deptno = d.deptno;


-- ANSI�� ORACLE ������� emp�� dept���̺��� �����ϰ� �޿��� 3000�̻��� ��� ���� ��� (�����ȣ, �̸�, �޿�, �Ի���, �μ���ȣ, �μ��̸�
-- ORACLE
SELECT empno �����ȣ, ename �̸�, sal �޿�, hiredate �Ի���, e.deptno �μ���ȣ, dname �μ��̸�
    FROM emp e, dept d
    WHERE e.deptno = d.deptno 
    AND sal >= 3000;
-- ANSI
SELECT empno �����ȣ, ename �̸�, sal �޿�, hiredate �Ի���, e.deptno �μ���ȣ, dname �μ��̸�
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno 
    WHERE sal >= 3000;    
    
-- EMP ���̺� ��Ī�� E��, DEPT ���̺� ��Ī�� D�� �Ͽ� ������ ���� � ������ ���� ��,
-- �޿��� 2500 �����̰� ��� ��ȣ�� 9999 ������ ����� ������ ��µǵ��� �ۼ�
SELECT empno, ename, sal, d.deptno, dname, loc
    FROM emp E JOIN dept D
    ON E.deptno = D.deptno
    WHERE sal <= 2500 AND empno <= 9999;

SELECT empno, ename, sal, D.deptno, dname, loc
    FROM emp E, dept D
    WHERE E.deptno = D.deptno
    AND sal <= 2500 
    AND empno <= 9999;
    

/* ������ : ���� ���� �ƴ� �ٸ� ������ ����Ͽ� ���� �� �� ���Ǹ�, ���� ������ ���� */
-- �޿��� ���� ����� ǥ�� �ϱ� ���ؼ��� �޿��� �ݾ��� ��ġ �� �� �����Ƿ� �ּҿ� �ִ� �޿� ���̿� �־�� ��. �̷���� BETWEEN a AND b �����ڸ� ����ϸ� ó�� ����

SELECT * FROM emp;
SELECT * FROM salgrade;
-- ORACLE JOIN
SELECT ename, sal, grade
    FROM emp e, salgrade s
    WHERE e.sal BETWEEN s.losal AND s.hisal;
-- ANSI JOIN 
SELECT ename, sal, grade
    FROM emp e JOIN salgrade s
    ON e.sal BETWEEN s.losal AND s.hisal;


/* ��ü ���� : ���� ���̺��� �ι� ����ϴ� �� */
SELECT e1.empno, e1.ename, e1.mgr,
        e2.empno AS MGR_EMPNO,
        e2.ename AS MGR_ENAME
    FROM emp e1, emp e2
    WHERE e1.mgr = e2.empno;

SELECT e1.empno, e1.ename, e1.mgr,
        e2.empno AS MGR_EMPNO,
        e2.ename AS MGR_ENAME
    FROM emp e1 JOIN emp e2
    ON e1.mgr = e2.empno;

/* OUTER JOIN(�ܺ�����)  : INNER JOIN �Ǵ� ���� ������ ��� ������ �÷�(��)�� ���� ���ٸ� ��ȸ �Ұ�
                        : �ܺ������� ������� ���� ���� ǥ�� ��*/
-- ���� ����
SELECT ename, e.deptno, dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno;
    
/* RIGHT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� �����ʿ� ����� ���̺��� �÷� ���� �������� JOIN */
-- ANSI JOIN
SELECT ename, e.deptno, dname
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno; -- dname 'OPERATIONS'�� ������ �ٿ� ��Ÿ�� : dept ���̺� deptno=40 ���� �ִ� OPERATIONS! 
-- ORACLE JOIN
SELECT ename, e.deptno, dname
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno
    ORDER BY e.deptno;

/* LEFT OUTER JOIN : ��ġ�⿡ ����� �� ���̺� �� ���ʿ� ����� ���̺��� �÷� ���� �������� JOIN */    
-- ANSI JOIN
SELECT ename, e.deptno, dname
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY e.deptno; -- emp ���̺� �߰��� �ִ� ���� ��� �߰� ����
-- ORACLE JOIN
SELECT ename, e.deptno, dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno(+)
    ORDER BY e.deptno;


    
/* �������� */
-- 1. �����ȣ�� 7499�� ����� �̸�, �Ի��� �μ���ȣ ���
SELECT ename, hiredate, deptno
    FROM emp
    WHERE empno = 7499;

-- 2. �̸��� ALLEN�� ����� ��� ���� ���
SELECT *
    FROM emp
    WHERE ename = 'ALLEN';
    
-- 3. �̸��� K���� ū ���ڷ� �����ϴ� ����� ��� ���� ���
SELECT *
    FROM emp
    WHERE SUBSTR(ename, 1, 1) > 'K';
-- ����� ��
SELECT *
    FROM emp
    WHERE ename > 'K';
    
-- 4. �Ի����� 81�� 4��2�� ���� �ʰ�, 82�� 12��9�� ���� ���� ����� �̸�, �޿�, �μ���ȣ ���
SELECT ename, sal, deptno, hiredate
    FROM emp
    WHERE hiredate > TO_DATE('1981/04/02', 'YYYY,MM,DD') 
    AND hiredate < TO_DATE('1982/12/09', 'YYYY,MM,DD');
-- ����� ��
SELECT ename, sal, deptno, hiredate
    FROM emp
    WHERE hiredate > '81/04/02' AND hiredate < '82/12/09';
    
-- 5. �޿��� 1,600 ���� ũ��, 3000���� ���� ����� �̸�, ����, �޿��� ���
SELECT ename, job, sal
    FROM emp
--    WHERE sal > 1600
--    AND sal < 3000;
    WHERE sal BETWEEN 1601 AND 2999;
                    
-- 6. �Ի����� 81�� �̿ܿ� �Ի��� ����� ��� ���� ���
SELECT *
    FROM emp
    WHERE EXTRACT(YEAR FROM hiredate) != '1981';

-- 7. ������ MANAGER�� SALESMAN�� ����� ��� ������ ���     
SELECT *
    FROM emp
    WHERE job IN ('MANAGER', 'SALESMAN'); 
    
-- 8. �μ��� 20��, 30���� ������ ��� ����� �̸�, �����ȣ, �μ���ȣ�� ���
SELECT ename, empno, deptno
    FROM emp
    WHERE deptno NOT IN (20, 30); 
    
-- 9. �̸��� S�� �����ϴ� ����� �����ȣ, �̸�, �μ���ȣ ���
SELECT empno, ename, deptno
    FROM emp
    WHERE SUBSTR(ename, 1, 1) = 'S';
-- ����� ��
SELECT empno, ename, deptno
    FROM emp
    WHERE ename LIKE 'S%';
    
-- 10. ó�� ���ڴ� �������, �� ��° ���ڰ� A�� ����� ��� ������ ���
SELECT *
    FROM emp
    WHERE ename LIKE '_A%';

-- 11. Ŀ�̼��� NULL�� �ƴ� ����� ��� ������ ���
SELECT *
    FROM emp
    WHERE comm IS NOT NULL;
    
-- 12. �̸��� J�ڷ� �����ϰ� ������ ���ڰ� S�� ����� ��� ������ ���
SELECT *
    FROM emp
    WHERE ename LIKE 'J%' 
    AND ename LIKE '%S';
-- ����� ��
SELECT *
    FROM emp
    WHERE ename LIKE 'J%S';

-- 13. �޿��� 1500�̻��̰�, �μ���ȣ�� 30���� ��� �� ������ MANAGER�� ����� ��� ���� ���
SELECT *
    FROM emp
    WHERE sal >= 1500
    AND deptno = 30
    AND job = 'MANAGER';

-- 14. ��� ����� �̸�, �޿�, Ŀ�̼�, �Ѿ�(�޿�+Ŀ�̼�)�� ���Ͽ� �Ѿ��� ���� ������ ��� 
--     (��, Ŀ�̼��� null�� ����� 0���� ����)
SELECT ename, sal, NVL(comm, 0), NVL(sal+comm, sal+0) �Ѿ�
    FROM emp
    ORDER BY 4 DESC;
-- ����� ��    
SELECT ename, sal, NVL(comm, 0), sal+NVL(comm,0) AS "�Ѿ�"
    FROM emp
    ORDER BY "�Ѿ�" DESC;    

-- 15. 10�� �μ��� ��� ������� �޿��� 13%�� ���ʽ��� �����ϱ�� �Ͽ���. 
--     10�� �μ� ������� �̸�, �޿�, ���ʽ�, �μ���ȣ ���
SELECT ename, sal, sal*1.13 ���ʽ�, deptno
    FROM emp
    WHERE deptno = 10;

-- 16. ��� ����� ���� �Ի��� ���� ���� 60���� ���� ���� �������ϡ��� ���� ��,��,�ϸ� ���Ͽ� 
--     �̸�, �Ի���, 60�� ���� �������ϡ� ��¥�� ���    
SELECT ename, hiredate, TO_CHAR(NEXT_DAY(hiredate+60, 2), 'YYYY/MM/DD')
    FROM emp;
-- ����� ��
SELECT ename, hiredate, NEXT_DAY(hiredate+60, 2) DDAY
    FROM emp;
-- ���� �ְ� ������ TO_CHAR, �ƴϸ� �׳� NEXT_DAY�� ���� �� !     
SELECT NEXT_DAY(SYSDATE + 60, 2) FROM dual;    

-- 17. �̸��� ���ڼ��� 6�� �̻��� ����� �̸��� �տ��� 3�ڸ� ���Ͽ� �ҹ��ڷ� �̸��� ���
SELECT LOWER(SUBSTR(ename, 1, 3)) 
    FROM emp
    WHERE LENGTH(ename) >= 6;

-- 18. ������� ��� ��ȣ�� �޿�, Ŀ�̼�, ����((comm+sal)*12)�� ������ ���� ������ ���
SELECT empno, sal, NVL(comm, 0), NVL(sal*12+comm, sal*12+0)
    FROM emp
    ORDER BY 4 DESC;
-- ����� �� (���, Ŀ�̼��� �޸��� ��)   
SELECT empno, sal, NVL(comm, 0), NVL((comm+sal)*12, (0+sal)*12)
    FROM emp
    ORDER BY 4 DESC;    
-- ����� ��    
SELECT empno, sal, NVL(comm, 0)"Ŀ�̼�", SAL*12+NVL(comm,0)"����"
    FROM emp
    ORDER BY "����" DESC;      

-- 19. ��� ������� �Ի��� ��/��/�� 
SELECT TO_CHAR(hiredate, 'YYYY"��"MM"��"DD"��"')
    FROM emp;
    
-- 20. 10�� �μ��� ���� �޿��� ��� ��, �ִ� ��, �ּ� ��, �ο� ���� ���
SELECT deptno, AVG(sal), MAX(sal), MIN(sal), COUNT(*)
    FROM emp
    GROUP BY deptno
        HAVING deptno = 10;
-- ����� ��        
SELECT ROUND(AVG(sal), 2), MAX(sal), MIN(sal), COUNT(*)
    FROM emp
    WHERE deptno = 10;        
        
-- 21. �����ȣ�� ¦���� ������� ��� ������ ���
SELECT *   
    FROM emp
    WHERE MOD(empno, 2) = 0;
    
-- 22. �� �μ��� ���� ������ ���� ����� �ο����� ���Ͽ� �μ� ��ȣ, ����, �ο��� ���
SELECT deptno, job, COUNT(*)
    FROM emp
    GROUP BY deptno, job;

-- 23. EMP�� DEPT���̺��� �����Ͽ� ��� ����� ���� �μ� ��ȣ, �μ��̸�, ����̸� �޿��� ���
SELECT d.deptno, dname, ename, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno;

-- 24. �̸��� ��ALLEN���� ����� �μ� ��ȣ, �μ� �̸�, ��� �̸�, �޿� ���
SELECT d.deptno, dname, ename, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'ALLEN';

-- 25. ��ALLEN���� ������ ���� ����� �̸�, �μ� �̸�, �޿�, �μ���ġ�� ���
SELECT job
    FROM emp
    WHERE ename = 'ALLEN';

SELECT ename, e.job, sal, loc
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE job = (SELECT job
                    FROM emp
                    WHERE ename = 'ALLEN');
       
-- 26. ��� ������� ��� �޿� ���� ���� �޴� ������� �����ȣ�� �̸� ���
SELECT AVG(sal)
    FROM emp;

SELECT empno, ename
    FROM emp
    WHERE sal > (SELECT AVG(sal)
                    FROM emp);
            
-- 27. �μ��� ��� �޿��� 2000���� ���� �μ� ������� �μ� ��ȣ ���
SELECT deptno
    FROM emp
    GROUP BY deptno
        HAVING AVG(sal) < 2000;

-- 28. 30�� �μ��� �ְ�޿����� �޿��� ���� ����� ��� ��ȣ, �̸�, �޿��� ���
SELECT MAX(sal)
    FROM emp
    WHERE deptno = 30;

SELECT empno, ename, sal
    FROM emp
    WHERE sal > (SELECT MAX(sal)
                     FROM emp
                    WHERE deptno = 30);
                  
-- 29. 'FORD���� �μ��� ���� ������� �̸�, �μ� �̸�, ����, �޿��� ���  
SELECT dname
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'FORD';

SELECT ename, dname, e.job, sal
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 
        (SELECT dname
            FROM emp e JOIN dept d
            ON e.deptno = d.deptno
            WHERE ename = 'FORD');
            
SELECT * FROM dept;            
SELECT * FROM emp;
SELECT ename, job, dname, e.deptno
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE ename = 'FORD';
SELECT *
    FROM emp
    WHERE deptno = 20;

-- 30. �μ� �̸��� ��SALES���� ������� ��� �޿� ���� ����, 
--     �μ� �̸��� ��RESEARCH���� ������� ��� �޿� ���� ���� ������� �̸�, �μ���ȣ, �޿�, ���� ���    
SELECT AVG(sal)
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 'SALES';
    
SELECT AVG(sal)
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE dname = 'RESEARCH';
    
SELECT ename, deptno, sal, job
    FROM emp
    WHERE sal > (SELECT AVG(sal)
                    FROM emp e JOIN dept d
                    ON e.deptno = d.deptno
                    WHERE dname = 'SALES')
    AND sal < (SELECT AVG(sal)
                 FROM emp e JOIN dept d
                 ON e.deptno = d.deptno
                 WHERE dname = 'RESEARCH');        
                 
SELECT ename, deptno, sal, job
    FROM emp
    WHERE sal BETWEEN 
    (SELECT AVG(sal)
         FROM emp e JOIN dept d
         ON e.deptno = d.deptno
         WHERE dname = 'SALES')
    AND 
    (SELECT AVG(sal)
         FROM emp e JOIN dept d
         ON e.deptno = d.deptno
         WHERE dname = 'RESEARCH');                       
                    


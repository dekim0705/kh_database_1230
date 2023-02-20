/* 2023/02/22 */
/* ANSI JOIN : 1) NATURAL JOIN
               2) JOIN ~ USING
               3) JOING ~ ON 
               + ����ŬJOIN (, WHERE) = �� 4���� JOIN     */
               
               
/* NATURAL JOIN : ���� ���ΰ� ��������� WHERE ������ ���� �����ϴ� ��� 
                : �� ���̺��� ������ �̸�(�÷� �Ǵ� ��)�� ���� �÷��� ��� ���� �� 
                : deptno���� ���� ���̺� ��� ���� ��                      */
                
SELECT empno, ename, dname
    FROM emp NATURAL JOIN dept;
    
-- �Ϲ����� ���������� ���� �Ʒ��� �������� ������ �߻��մϴ�. deptno�� ��� �Ҽ����� ��ȣ���� �߻� ��
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc -- ���ʿ� �����ϴ� deptno���� NATURAL JOIN���� �������� ������ �ȳ�����..?
    FROM emp NATURAL JOIN dept
    ORDER BY deptno, empno;
    
/* JOIN ~ USING : ������ � ������ ����ϴ� ���� ���
                : FROM table1 JOIN table2 USING(���ؿ�)        */   
SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno, dname, loc
    FROM emp JOIN dept USING(deptno)
    WHERE sal >= 3000
    ORDER BY deptno, empno;
    
/* JOIN ~ ON : ���� ���뼺 �ִ� JOIN ~ ON Ű���带 ����� ���� ���
             : FROM table1 JOIN table2 ON (���� ���ǽ�)      */    
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e JOIN dept d
    on e.deptno = d.deptno
    WHERE sal <= 3000
    ORDER BY e.empno, empno;
    
    
/* ANSI OUTER JOIN : 1) LEFT OUTER JOIN
                     2) RIGHT OUTER JOIN                             */
                     
/* LEFT OUTER JOIN : ���� ���̺� �������� ������ ���̺��� ��� ���� ��� �� */
-- ORACLE 
SELECT empno, ename, job, mgr, hiredae, sal, comm, e.deptno, dname, loc
    FROM emp e, dept d
    WHERE e.deptno = d.deptno(+); -- ����(e.deptno) �������� ������(d.deptno)�� ����ִ°� ä�� ������� �ǹ�
-- ANSI
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e LEFT OUTER JOIN dept d
    ON e.deptno = d.deptno;

/* RIGHT OUTER JOIN :  ������ ���̺� �������� ���� ���̺��� ��� ���� ��� �� */    
-- ORACLE 
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno; 
-- ANSI
SELECT empno, ename, job, mgr, hiredate, sal, comm, e.deptno, dname, loc
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno;

/* �������� */
-- 1. �޿�(sal)�� 2000�ʰ��� ������� �μ� ����, ��� ������ �μ���ȣ, �μ��̸�, ����̸�, �޿� ǥ�� (4���� JOIN �������)
    -- ORACLE JOIN
SELECT d.deptno �μ���ȣ, dname �μ��̸�, ename ����̸�, sal �޿�
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
    AND sal > 2000;
    -- ANSI JOIN : NATURAL JOIN (WHERE ������ ���� JOIN..�ؾ��ϳ�?)
SELECT deptno �μ���ȣ, dname �μ��̸�, ename ����̸�, sal �޿�
    FROM emp NATURAL JOIN dept
    WHERE sal > 2000;
    -- ANSI JOIN : JOING ~ USING
SELECT deptno �μ���ȣ, dname �μ��̸�, ename ����̸�, sal �޿�
    FROM emp JOIN dept USING(deptno)
    WHERE sal > 2000;
    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno �μ���ȣ, dname �μ��̸�, ename ����̸�, sal �޿�
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    WHERE sal > 2000;

-- 2. �� �μ��� ��� �޿�, �ִ� �޿�, �ּұ޿�, ��� �� ���(4���� JOIN�������)
    -- ORACLE JOIN
SELECT d.deptno, dname, ROUND(AVG(sal)) ��ձ޿�, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, COUNT(*) �����
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
    GROUP BY d.deptno, dname;

    -- ANSI JOIN : NATURAL JOIN
SELECT deptno, dname, ROUND(AVG(sal)) ��ձ޿�, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, COUNT(*) �����
    FROM emp NATURAL JOIN dept
    GROUP BY deptno, dname;

    -- ANSI JOIN : JOING ~ USING
SELECT deptno, dname, ROUND(AVG(sal)) ��ձ޿�, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, COUNT(*) �����
    FROM emp JOIN dept USING(deptno)
    GROUP BY deptno, dname;

    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno, dname, ROUND(AVG(sal)) ��ձ޿�, MAX(sal) �ִ�޿�, MIN(sal) �ּұ޿�, COUNT(*) �����
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    GROUP BY d.deptno, dname;

-- 3. ��� �μ� ������ ��� ������ �μ���ȣ, �μ��̸�, �����ȣ, ����̸�, ��å, �޿��� �μ���ȣ, ��� �̸������� ��� (4���� JOIN���� ���)
    -- ORACLE JOIN
SELECT d.deptno �μ���ȣ, dname �μ��̸�, empno �����ȣ, ename ����̸�, job ��å, sal �޿�
    FROM emp e, dept d
    WHERE e.deptno = d.deptno
   ORDER BY d.deptno, ename;
    -- ANSI JOIN : NATURAL JOIN)
SELECT deptno �μ���ȣ, dname �μ��̸�, empno �����ȣ, ename ����̸�, job ��å, sal �޿�
    FROM emp NATURAL JOIN dept
    ORDER BY ename;
    -- ANSI JOIN : JOING ~ USING
SELECT deptno �μ���ȣ, dname �μ��̸�, empno �����ȣ, ename ����̸�, job ��å, sal �޿�
    FROM emp JOIN dept USING(deptno)
    ORDER BY deptno, ename;
    -- ANSI JOIN : JOIN ~ ON
SELECT d.deptno �μ���ȣ, dname �μ��̸�, empno �����ȣ, ename ����̸�, job ��å, sal �޿�
    FROM emp e JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY d.deptno, ename;

-- 3�� ���� RIGHT OUTER JOIN ����ؼ� deptno 40�� ���
-- ORACLE JOIN
SELECT d.deptno, dname, empno, ename, job, sal
    FROM emp e, dept d
    WHERE e.deptno(+) = d.deptno
    ORDER BY d.deptno, ename;
-- ANSI JOIN   
SELECT d.deptno, dname, empno, ename, job, sal
    FROM emp e RIGHT OUTER JOIN dept d
    ON e.deptno = d.deptno
    ORDER BY d.deptno, ename;    
    
    
    
    
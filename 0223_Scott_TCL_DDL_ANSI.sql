CREATE TABLE dept_tcl 
    AS SELECT * FROM dept;
    
SELECT * FROM dept_tcl;

INSERT INTO dept_tcl VALUES(50, 'DATABASE', 'SEOUL');

UPDATE dept_tcl SET loc = 'BUSAN' 
    WHERE deptno = 40;
    
DELETE FROM dept_tcl WHERE dname = 'RESEARCH';    

COMMIT; -- COMMIT; �ϴ� ���� ���������� �ٲ�. ROLLBACK �Ұ�. UPDATE �ؾ� ��


DESC emp;
/* �ڷ����� �����Ͽ� ���ο� ���̺� ���� */
CREATE TABLE emp_ddl (
    empno       NUMBER(4),
    ename       VARCHAR2(10),
    job         VARCHAR2(9),
    mgr         NUMBER(4),
    hiredate    DATE,
    sal         NUMBER(7, 2),
    comm        NUMBER(7, 2),
    deptno      NUMBER(2)
);
SELECT * FROM emp_ddl;

/* ���� ���̺��� �� ������ �����͸� �����Ͽ� �� ���̺� ���� */
CREATE TABLE dept_ddl
    AS SELECT * FROM dept;
SELECT * FROM dept_ddl;    


/* ���� ���̺��� �� ������ �����Ͽ� �� ���̺� ���� */
CREATE TABLE dept_ddl_tmp
    AS SELECT * FROM dept
    WHERE 1 != 1;
SELECT * FROM dept_ddl_tmp; 

/* */
CREATE TABLE empdept_ddl
    AS SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, d.deptno, d.dname, d.loc
    FROM emp e, dept d
    WHERE 1 != 1;
SELECT * FROM empdept_ddl;

/*
* DDL(������ ���Ǿ�)
* CREATE : ���̺� ����
* ALTER  : ���̺� ���� (ADD, RENAME, MODIFY, DROP)
* RENAME : ���̺� �̸� ����
* TRUNCATE : ���̺��� �����͸� ���� 
* DROP   : ���̺� ����
*/

/* ���̺��� �����ϴ� ALTER : ���̺� �� ���� �߰� �Ǵ� ����, ���� �ڷ����� ���� ���� ���� ���� 
                         : ADD, RENAME, MODIFY, DROP                                    */
CREATE TABLE EMP_ALTER AS SELECT * FROM EMP;
SELECT * FROM EMP_ALTER;
/* ADD : ���̺� ���ο� ���� �߰�, �߰��� ���� ���� �࿡�� NULL ������ �Է� �� */
ALTER TABLE EMP_ALTER
    ADD HP VARCHAR2(20);
/* RENAME : �� �̸� ���� */ 
ALTER TABLE EMP_ALTER
    RENAME COLUMN HP TO TEL;
/* MODIFY : ���� �ڷ��� ���� */
ALTER TABLE EMP_ALTER 
    MODIFY EMPNO NUMBER(2); -- ���� �Ұ�. �̹� ����Ǿ� �ִ� �������� ũ�Ⱑ 2���� �� ŭ
ALTER TABLE EMP_ALTER
    MODIFY EMPNO NUMBER(5); -- ����~
DESC EMP_ALTER;    
/* DROP : Ư�� �� ���� */
ALTER TABLE EMP_ALTER
    DROP COLUMN MGR;

/* RENAME : ���̺� �̸� ���� */
RENAME EMP_ALTER TO EMP_RENAME;
SELECT * FROM EMP_RENAME;


/* TRUNCATE : ���̺��� ��� �����͸� �����ϴ� ���. ���̺� ������ ������ ���� ������, ROLLBACK �Ұ� */
-- ���̺��� ������ ������ ������ ���۾� �� WHERE���� ������� ���� DELETE���� �������ε� ����,
-- ������ TRUNCATE�� ������ ���Ǿ��̱� ������ ROLLBACK�� ���� ���� = ���� ���� ���� �Ұ� 
TRUNCATE TABLE EMP_RENAME;
SELECT * FROM EMP_RENAME;

/* DROP : ���̺� ���� */
DROP TABLE EMP_RENAME;




/* �������� */
DESC EMP_HW;
SELECT * FROM EMP_HW;
-- 1. EMP TABLE�� �Ȱ��� ���� ������ ������ EMP_HW ���̺� ����
CREATE TABLE EMP_HW (
EMPNO    NUMBER(4),
ENAME    VARCHAR2(10),
JOB      VARCHAR2(9),
MGR      NUMBER(4),
HIREDATE DATE,
SAL      NUMBER(7, 2),
COMM     NUMBER(7, 2),
DEPTNO   NUMBER(2)
);
-- 2. EMP_HW ���̺� BIGO ���� �߰��� ������. BIGO ���� �ڷ����� ������ ���ڿ��̰�, ���̴� 20�Դϴ�.
ALTER TABLE EMP_HW
    ADD BIGO VARCHAR2(20);
-- 3. EMP_HW ���̺��� BIGO �� ũ�⸦ 30���� ������ ������.
ALTER TABLE EMP_HW
    MODIFY BIGO VARCHAR2(30);
-- 4. EMP_HW ���̺��� BIGO �� �̸��� REMARK�� ������ ������.
ALTER TABLE EMP_HW
    RENAME COLUMN BIGO TO REMARK;
-- 5. EMP_HW ���̺� EMP ���̺��� �����͸� ��� ������ ������. �� REMAKE ���� NULL�� �����մϴ�.
INSERT INTO EMP_HW 
SELECT EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO, NULL
  FROM EMP;
-- 6. EMP_HW ���̺� ����
DROP TABLE EMP_HW;




/* ��������(constraint) : ���̺� ������ �����͸� �����ϴ� Ư���� ��Ģ 
                       : NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK      */
                       
/* NOT NULL : ���� ������� ����. ���� ���� �����Ϳ� �ߺ����δ� ������� NULL���� ������� ���� (=�ݵ�� ���� �Է� �Ǿ�� ��) */ 
CREATE TABLE TABLE_NOTNULL (
    LOGIN_ID    VARCHAR2(20) NOT NULL,
    LOGIN_PWD   VARCHAR2(20) NOT NULL,
    TEL         VARCHAR2(20)
);
INSERT INTO TABLE_NOTNULL(LOGIN_ID, LOGIN_PWD, TEL) VALUES('��������', NULL, '010-1234-1234');
INSERT INTO TABLE_NOTNULL VALUES('��������', '1234', '010-1234-1234');
INSERT INTO TABLE_NOTNULL VALUES('����۸���', '5678', NULL);

/* UNIQUE : �ߺ����� �ʴ� ��. ���� ������ �������� �ߺ��� ������� ���� */
CREATE TABLE TABLE_UNIQUE(
    LOGIN_ID    VARCHAR2(20) UNIQUE,
    LOGIN_PWD   VARCHAR(20) NOT NULL,
    TEL         VARCHAR(20)
);
INSERT INTO TABLE_UNIQUE VALUES('��������', '1234', '010-1234-1234');
INSERT INTO TABLE_UNIQUE VALUES('��������', '1234', '010-1234-1234'); -- ID�ߺ� X
INSERT INTO TABLE_UNIQUE VALUES(NULL, '1234', NULL); 

SELECT * FROM TABLE_UNIQUE;



/* PRIMARY KEY : UNIQUE�� NOT NULL Ư���� ��� ������ ���� */
CREATE TABLE TABLE_PK (
    LOGIN_ID    VARCHAR2(20) PRIMARY KEY, 
    LOGIN_PWD   VARCHAR(20)  NOT NULL,
    TELL        VARCHAR2(20)
);
INSERT INTO TABLE_PK VALUES('��������', '1234', '010-1234-1234');
INSERT INTO TABLE_PK VALUES(NULL, '1234', NULL); -- X
INSERT INTO TABLE_PK VALUES('����۸���', '1234', NULL); 

SELECT * FROM TABLE_PK;

/* FOREIGN KEY : ���� �ٸ� ���̺� ���踦 �����ϴµ� ��� */
CREATE TABLE DEPT_FK(
    DEPTNO  NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME   VARCHAR2(14),
    LOC     VARCHAR2(13)
);
DESC DEPT_FK;

CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO__PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    MGR NUMBER(4),
    HIREDATE DATE,
    SAL NUMBER(7, 2),
    COMM NUMBER(7, 2),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO)
);
DESC EMP_FK;
-- 10�� �μ��� ���� ����, FK�� ����Ǿ��ִ� DEPT_FK�� PK�� ����
INSERT INTO EMP_FK VALUES(9999, '�ݺ���', 'AI', NULL, SYSDATE, 3000, NULL, 10);
-- DEPT_FK �����
INSERT INTO DEPT_FK VALUES(10, '�����ձ�', '�ΰ�����');
INSERT INTO EMP_FK VALUES(9999, '�ݺ���', 'AI', NULL, SYSDATE, 3000, NULL, 10);

-- ������ �������� ����
DELETE FROM DEPT_FK WHERE DEPTNO = 10; -- X
DELETE FROM EMP_FK WHERE DEPTNO = 10;
DELETE FROM DEPT_FK WHERE DEPTNO = 10; -- O

/* CHECK : ������ ���¿� ������ ���� */
CREATE TABLE TABLE_CHECK(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLCK_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
    TEL         VARCHAR2(20)
);    
INSERT INTO TABLE_CHECK VALUES('��������', '123', '123-123-123'); -- X ��й�ȣ ���� CHECK
INSERT INTO TABLE_CHECK VALUES('��������', '1234', '123-123-123');

/* CHECK ���� ���� Ȯ�� */
SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME LIKE 'TABLE_CHECK';
    
/* DEFAULT : ���� ���ǰ��� ������ Ư�� ���� ������ ���� �������� �ʾ��� ��쿡 �⺻�� ���� */
-- �⺻���� �����ϴ°� ���������� �ƴϱ⶧���� CONSTRAINT������ �ȵ�..
CREATE TABLE TABLE_DEFAULT(
    LOGIN_ID    VARCHAR2(20) CONSTRAINT TBLCK2_LOGINID_PK PRIMARY KEY,
    LOGIN_PWD   VARCHAR2(20) DEFAULT '1234',
    TEL         VARCHAR2(20)
);
INSERT INTO TABLE_DEFAULT VALUES('��������', NULL, '123-123-123'); -- NULL �ϸ� NULL�� ��! �⺻�� �ȵ�! 
INSERT INTO TABLE_DEFAULT VALUES('����۸���', '5678', '123-123-124');
SELECT * FROM TABLE_DEFAULT;
INSERT INTO TABLE_DEFAULT VALUES('�лк��Ƹ�', DEFAULT, '123-123-123');
INSERT INTO TABLE_DEFAULT (LOGIN_ID, TEL) VALUES('��������2', '123-123-123');

    


CREATE TABLE PRODUCT(
PRODUCT_ID     NUMBER  PRIMARY KEY,
PRODUCT_NAME   VARCHAR2(20) NOT NULL,
REG_DATE       DATE
);

INSERT INTO PRODUCT VALUES(1, 'Computer', '2021/01/12');
INSERT INTO PRODUCT VALUES(2, 'Smartphone', '2022/02/03');
INSERT INTO PRODUCT VALUES(3, 'Television', '2022/07/01');

ALTER TABLE PRODUCT
    ADD WEIGHT NUMBER CHECK (WEIGHT>=0);
ALTER TABLE PRODUCT
    ADD PRICE NUMBER CHECK (PRICE>=0);

SELECT * FROM PRODUCT;

UPDATE PRODUCT
    SET WEIGHT = 100,
        PRICE = 200
    WHERE PRODUCT_NAME = 'Computer';    



CREATE TABLE CUSTOMER(
CUSTOM_ID   NUMBER  PRIMARY KEY,
USER_NAME   VARCHAR(12) NOT NULL,
PHONE       VARCHAR(20),
EMAIL       VARCHAR(20),
REG_DATE    DATE DEFAULT('1900/01/01')
);

ALTER TABLE CUSTOMER
    ADD AGE NUMBER CHECK (AGE > 0 AND AGE < 200);
ALTER TABLE CUSTOMER
    ADD SEX VARCHAR2(1) CHECK (SEX = 'M' OR SEX = 'F');
ALTER TABLE CUSTOMER
    ADD BIRTH_DATE DATE;
    
DESC CUSTOMER;    

ALTER TABLE CUSTOMER
    MODIFY PHONE UNIQUE
    MODIFY EMAIL UNIQUE;
    
    
ALTER TABLE CUSTOMER
    RENAME COLUMN SEX TO GENDER;

ALTER TABLE CUSTOMER
    RENAME COLUMN PHONE TO MOBILE;
ALTER TABLE CUSTOMER    
    MODIFY USER_NAME VARCHAR2(20);
    
INSERT INTO CUSTOMER VALUES(1, '��������', '010-123-123', 'strawberry@com', DEFAULT, 2, 'F', SYSDATE);
SELECT * FROM CUSTOMER;
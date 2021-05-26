alter user hr IDENTIFIED by hr
account unlock;
--sys_user����
/*�̹����Ͱ� �⸻��� ����..!
���̺� �����̽� : ���̺��� ���� ����
RDBMS�� ���� ������ �޶��� �� ����.

*���̺� �����̽�<�̹� ������� ����>
�ý���     :system, sysaux
��ý���   :�Ϲ�-users, example, ��������� tablespace
           �ӽ�-temp
           ���-undotbs1
           
11g express edition(����)���� example�� ����.
���> undo(���), �ѹ� �ߴ� �͵��� �ҷ����̴� ģ��...

*�ý��ۺ�(������ ��ųʸ� + ���� ���� ��(Dynamic Performance View))
:dba_tablespaces, dba_data_file, dba_temp_file, dba_users, database_properties, <������Ʈ ��, ���� �� �̷��� Ȯ���� �ɰ� �� ���� �κе� ����>
v$tablespace, v$datafile, v$tempfile<�̸� ��Ģ ��ü�� �̷�.. �������ɺ�/ 11g �̻��� v$_... �� ǥ��>
*/
desc dba_tablespaces
select tablespace_name
from dba_tablespaces;

/*
SYSTEM
SYSAUX--�ý���
UNDOTBS1--���
TEMP--�ӽ�
USERS--�����
*/

desc v$tablespace
select name
from v$tablespace;
desc dba_users

select username, default_tablespace,temporary_tablespace
from dba_users
order by 1;

--default tal~ ���̺� ���� �� �⺻���� �ش� ������ �������� ��
/*
DIP	        SYSTEM	TEMP
FLOWS_FILES	SYSAUX	TEMP
HR	        USERS	TEMP
MDSYS	    SYSAUX	TEMP
*/

desc database_properties
select *
from database_properties;

/*
DEFAULT_TEMP_TABLESPACE     	TEMP
DEFAULT_PERMANENT_TABLESPACE	SYSTEM
*/
--�̷� �κе��� �ٲپ �ٸ��� ����� ���� �ְ�..

desc dba_data_files --����
select file_name, tablespace_name
from dba_data_files
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	    USERS
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	SYSAUX
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	UNDOTBS1
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	SYSTEM
temp�� ���������� �� �� ���� �۵�
*/
UNION --����Ȯ��
--desc dba_temp_files
select file_name, tablespace_name
from dba_temp_files;
--C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF    TEMP

select name, ts#
from v$datafile
UNION
select name, ts#
from v$tempfile;
--�̸� ��� ��ȣ�� ������ �ý���?
/*
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSAUX.DBF	1
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\SYSTEM.DBF	0
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\TEMP.DBF	    3
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\UNDOTBS1.DBF	2
C:\ORACLEXE\APP\ORACLE\ORADATA\XE\USERS.DBF	    4
�ν��Ͻ� ������ ��������� ���ο� CONTROL.DBF�� ��������ٰ�..
*/

/*
*���� ����
�� - tablespace < object(table, index, procedure, trigger..)
(������ ����)
���� - datafile01,...02.. < segement < extent < block
(�������� ����)
�ϳ��� ���̺� �����̽��� ����� ��Ģ�� ���� �������� ������������ ������� ���� �ִ�.
*/

--1.����� ���̺� �����̽�
--droptbs1(droptbs1.dbf)
--oraclexe������ testb���� ����
create tablespace droptbs1
datafile 'c:\oraclexe\testb\droptbs101.dbf' size 5m autoextend on next 1m maxsize 10m;
--:�ڵ�Ȯ�� �ʱ� extent 5m, 1m�� ����, �ִ� 10m
--����ؼ� ������ ������ Ȯ���ϴ� ������ �ֱ⿡ ����ڰ� ����� ������ �� ���� ���� ���ڸ� �ٿ���.
--Ȯ�� ���..? ���� �ִ� UNION �̿��ϱ� OR ���� ��� ���� Ȯ���ϱ�

--droptbs2_including(droptbs2_including01.dbf)
--droptbs3_datafile(droptbs3_datafile01.dbf)
--droptbs4_cascade(droptbs4_cascade01.dbf)

--2. " ������ �߰�
alter tablespace droptbs1
add datafile 'c:\oraclexe\testb\droptbs102.dbf'
size 5m autoextend on next 1m maxsize 10m;
--Ȯ���ڸ� ���� ���� �ʾƵ� ����������������.. ��Ģ�� �����ּ���
--���̺� �����̽��� �״�� / �׷��� ������ ������ �ϳ� �߰� (1��� ����, 1���̺����̽� : �� ����Ÿ����

--3. " �̵�;��ġ/�̸�����
--�ٸ� ������ �ű�ų�, �̸��� �ٲ۴ٰų�..
--1) alter tablespace tbs�� offline; --�۾��� �� �� ���� �����;offline
alter tablespace droptbs1 offline;

--2) ���������� ���ϴ� ��ġ/ �̸����� ����
/*���� Ž���⿡�� ���� 02�� ������ �� 03���� �̸� ����*/

--3) alter tablespace tbs�� rename
--datafile '����dbf��' to '�ű�dbf��';
alter tablespace droptbs1 rename
datafile 'c:\oraclexe\testb\droptbs102.dbf' to 'c:\oraclexe\testb\droptbs103.dbf';

--4) alter tablespace tbs�� online;
alter tablespace droptbs1 online;
--�������� ������ ���ϸ� ��ȭ

--5) ���������� ���������� ������ ����
--���� Ž���⿡�� ���� 2�� ���ָ� ��.

--4. " ����
--5. �ӽ� ���̺� �����̽� ���� �Ĥ� ����Ʈ �ӽ� ���̺� �����̽��� ����
--6. ��� ���̺� �����̽� ���� ��-- ����Ʈ ��� ���̺� �����̽��� ����

--[����]
--��������̺����̽� droptbs1�� ���������� droptbs103.dbf�� ���� �̸�(droptbs102.dbf)���� �����ϼ���.

show user;

create table test100 (a number);
-- insatbs�� ����Ǿ����� ����.

-- < insauser01

--insatbs�� quota�� unlimited dlrp..
--insauser03���� system tablespace�� �������� �ʴ´�.
--insauser01, 02�� ����

-- < insauser01

select * from test01; --�ȵ�..

-- < insauser02

select  * from insauser01.test01;

/*
�ý��ۺ�(������ ��ųʸ� ��)
������ �ο��� �ý��� ����: user_sys_privs, role_sys_privs, user_role_privs         >>�ѷ� ��� �ο��ϸ� ���..
������ �ο��� ������Ʈ ����: user_tab_privs, role_tab_privs, user_tab_privs
*/


-- < insauser 01


select * from user_sys_privs; 
/*
INSAUSER03	CREATE SESSION	NO
INSAUSER03	CREATE TABLE	NO
*/
select * from user_role_privs;  --X
select * from role_sys_privs;   --X


select * from user_tab_privs;
/*
INSAUSER03	INSAUSER01	TEST01	INSAUSER02	SELECT	NO	NO
*/
/*
�����
*/

/*
���Ѻο�
1) ����ڿ��� �ý��� ���� �ο�
:grant �ý��۱��� to ����ڸ� [with admin option];
2) ����ڿ��� ������Ʈ ���� �ο�
:grant ������Ʈ���� to ����ڸ� [with grant option];
��, revoke ~ from ����ڸ�;
�ý��۱����� �ش� ����ڸ� revoke,
������Ʈ ������ �̾���� ��� ����ڿ��Լ� revoke!

4.��;role�� �̿��� ���� �ο�
1)�� ����
2)�ѿ��� �ý��� ���� �ο�
3)�ѿ��� ������Ʈ ���� �ο�
4)����ڿ��� �� �ο�
��, ���� ���� ����ڰ� �� set�� �ؾ� ���� 
>set role �Ѹ�;
cf. �ý��� �� connect, resource(unlimited tablespace ������ �ڵ������� �־���)

5. ���Ǿ�;synonym ���� (as ���� ��..)   
insauser01.test01 >> test01
6. ������;sequence ����; �Ϸù�ȣ�� primary key�� ����� ��쵵 �� ����.
������ ��¥ + �Ϸù�ȣ ���� ��������
����ڿ��� �Է��ϰ� �Ѵٸ� ����ڰ� ������ �Է��ߴ��� �򰥷��� ���� ����.
�̷� �Ϸù�ȣ�� �ڵ����� �����ϴ� ������ �ϴ� ���� ������(�ǹ̾��� �ο��� ��..)
7.���̺����̽� ���ֱ�
8.����� ���ֱ�
9.�� ���ֱ�

�� �����ֿ��� �̷� �帧��� �ֿ� �غ��ϸ� ���ƿ�.
��� �ְ����� �� �ȿ��� �����ϸ� ���� �� �ֵ���..
�����ֿ� �⸻��縦 ����� ���̸� �� ����.

�߰���� �ܴ����� ��ҿ� �ϴ� ���� �� �����ϸ� �Ѵٸ� ��������.
(�ʹ� �������� �ʾƵ�.. �׷��� �غ�� �س���.)

�̹��� ������ ��� ����
*/
--���� ������ �Ͱ� �̾���


-- <<insauser01
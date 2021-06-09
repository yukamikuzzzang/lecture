show user;
 /*2. u_owner����ڷ� �����Ͽ� t_item���̺��� �����ϰ� ���̺� ������ ���Ͽ� 
 ��� ���������� �߰��Ͻÿ�. �̶� u_owner 
 ����� ������ ������ ���̺�� ���������� �ý��� ��� Ȯ���Ͻÿ�.*/
 create table t_item (
    itemno char(3),
    itemname char(10)
 );
 
 alter table t_item
 add primary key (itemno);
 
 select * from user_constraints, user_tables;
 
 /*3. u_owner����ڰ� r_insert���� �����ϰ� 
 ���̺��� ������ �Է°� �˻������� �ѿ� �ο��ϰ� 
  �� ���� u_insert����ڿ��� �ο��϶�. 
  �̶� u_insert����ڿ��� �ο��� ������Ʈ������ �ý��� ��� Ȯ���Ͻÿ�.*/
  
--������ ����
create sequence seq_itemno
increment by 1 start with 1 maxvalue 100 nocache nocycle; 

set role r_owner;

create role r_insert;
grant insert, select on s_item to r_insert;
grant r_insert to u_insert;

--u_insert>>
/*
set role r_insert;
set role r_guest;

SELECT * FROM role_tab_privs;
*/

/*4. u_owner����ڰ� r_query���� �����ϰ� ���̺��� ������ �˻������� 
�ѿ� �ο��ϰ� �� ���� u_query����ڿ��� �ο��϶�. 
�̶� u_query����ڿ��� �ο��� ������Ʈ������ �ý��� ��� Ȯ���Ͻÿ�. */

create role r_query;
grant select on t_item to r_query;
grant r_query to u_query;

--u_query>>

/*
set role r_guest;
set role r_query;

SELECT * FROM role_tab_privs;
*/

/*
5. u_owner����ڰ� t_item���̺� ���Ͽ� public �ó���� s_item�� �����Ͻÿ�.
*/

create public synonym s_item for u_owner.t_item;

/*
6. u_owner����ڰ� t_item���̺��� itemno�� ���Ͽ� seq_item�������� �����Ͻÿ�.
*/

/*
create sequence seq_itemno
increment by 1 start with 1
maxvalue 100 nocache nocycle;
*/

/*7. u_insert����ڰ� t_item���̺��� itemno�� ���Ͽ� 
seq_itemno�������� �̿��Ͽ� �Է��� �� �ֵ���
u_owner����ڰ� r_insert�ѿ� ������Ʈ ������ �ο��Ͻÿ�.
�̶� u_insert����ڿ��� �ο��� ��� �ý��� ���Ѱ� ������Ʈ ������ 
�ý��� ��� Ȯ���Ͻÿ�.*/
select * from t_item;
insert into t_item(itemno) values(seq_itemno.nextval);

grant insert on s_item to r_insert;
grant select on seq_itemno to r_insert;

grant r_insert to u_insert;

--u_insert>>
/*
set role r_insert;
SELECT * FROM role_tab_privs;
*/

/*
10. �� ����ں��� ��� ������Ʈ�� ���Ͽ� �ý��� �並 �̿��Ͽ� Ȯ���� �� 
   sys����ڷ� �����Ͽ� checktbs ���̺����̽��� ���õ� ��� �������Ǳ��� �����Ͻÿ�. */
select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;


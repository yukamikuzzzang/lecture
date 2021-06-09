set role r_insert;
set role r_guest;

SELECT * FROM role_tab_privs;

create synonym s_itemno for u_owner.seq_itemno;

insert into s_item(itemno) values(seq_itemno.nextval);
/*������ �Ǿ��ϴµ� ���� �𸣰� ���ΰ� ����..*/
select * from s_item;

select privilege from role_sys_privs;

select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;
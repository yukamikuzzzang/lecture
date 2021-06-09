set role r_guest;
set role r_query;

SELECT * FROM role_tab_privs;

select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;
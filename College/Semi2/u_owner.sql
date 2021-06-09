show user;
 /*2. u_owner사용자로 접속하여 t_item테이블을 생성하고 테이블 변경을 통하여 
 모든 제약조건을 추가하시오. 이때 u_owner 
 사용자 본인이 소유한 테이블과 제약조건을 시스템 뷰로 확인하시오.*/
 create table t_item (
    itemno char(3),
    itemname char(10)
 );
 
 alter table t_item
 add primary key (itemno);
 
 select * from user_constraints, user_tables;
 
 /*3. u_owner사용자가 r_insert롤을 생성하고 
 테이블의 데이터 입력과 검색권한을 롤에 부여하고 
  그 롤을 u_insert사용자에게 부여하라. 
  이때 u_insert사용자에게 부여된 오브젝트권한을 시스템 뷰로 확인하시오.*/
  
--시퀀스 생성
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

/*4. u_owner사용자가 r_query롤을 생성하고 테이블의 데이터 검색권한을 
롤에 부여하고 그 롤을 u_query사용자에게 부여하라. 
이때 u_query사용자에게 부여된 오브젝트권한을 시스템 뷰로 확인하시오. */

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
5. u_owner사용자가 t_item테이블에 대하여 public 시노님인 s_item을 생성하시오.
*/

create public synonym s_item for u_owner.t_item;

/*
6. u_owner사용자가 t_item테이블의 itemno에 대하여 seq_item시퀀스를 생성하시오.
*/

/*
create sequence seq_itemno
increment by 1 start with 1
maxvalue 100 nocache nocycle;
*/

/*7. u_insert사용자가 t_item테이블의 itemno에 대하여 
seq_itemno시퀀스를 이용하여 입력할 수 있도록
u_owner사용자가 r_insert롤에 오브젝트 권한을 부여하시오.
이때 u_insert사용자에게 부여된 모든 시스템 권한과 오브젝트 권한을 
시스템 뷰로 확인하시오.*/
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
10. 각 사용자별로 모든 오브젝트에 대하여 시스템 뷰를 이용하여 확인한 후 
   sys사용자로 접속하여 checktbs 테이블스페이스를 관련된 모든 제약조건까지 삭제하시오. */
select owner, table_name, privilege from user_tab_privs
union
select owner, table_name, privilege from role_tab_privs;


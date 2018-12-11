create or replace view sys_pianqu as
select d."ID",d."NAME",d."NAMEALL",d."INPUT_DATE",d."TELEPHONE",d."ADDRESS",d."SORTBY",d."IS_REC",d."TYPE_NUM" from sys_department d where d.type_num = 2;

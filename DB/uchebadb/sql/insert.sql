connect  'D:\PR 11-03\uchebadb\demo.gdb'
user 'SYSDBA' password 'masterkey';
insert into GROUPS(GroupName,sYear) values ('��11-10',2011);
commit;
insert into GROUPS(GroupName,sYear) values ('�11-09',2011);
commit;
insert into GROUPS(GroupName,sYear) values ('��11-01',2011);
commit;
insert into PREDMET (predmnamekratk) values('����');
commit;
insert into PREDMET (predmnamekratk) values('���');
commit;
insert into PREDMET (predmnamekratk) values('�����');
commit;
insert into PREDMET (predmnamekratk) values('�����');
commit;
insert into PREDMET (predmnamekratk) values('�-��');
commit;





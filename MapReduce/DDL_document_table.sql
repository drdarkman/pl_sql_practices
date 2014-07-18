
create table documents
as 
select rownum as doc_id, column_name as text from sys.dba_tab_columns;
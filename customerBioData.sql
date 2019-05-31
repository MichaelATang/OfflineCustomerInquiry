set colsep ,
set headsep off
set page size 0
set trimspool on
set linesize 2
set numwidth 10

spool /home/test.csv

select firstname, lastname
from table_name;


spool off

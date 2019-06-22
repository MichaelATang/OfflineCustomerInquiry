set heading off
set newpage none

spool /tmp/customerdata/biodata_dbtest.csv

select trim(account#) || ',' || trim(name) || ',' || trim(address)
from biodata;

spool off

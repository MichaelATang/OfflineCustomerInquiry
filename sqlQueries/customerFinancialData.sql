set heading off
set newpage none

spool /tmp/customerdata/financialdata.csv

select trim(firstname) || ',' || trim(lastname)
from tablename;

spool off

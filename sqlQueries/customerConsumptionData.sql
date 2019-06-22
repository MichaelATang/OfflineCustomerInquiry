set heading off
set newpage none

spool /tmp/customerdata/consumptiondata_dbtest.csv

select trim(account#) || ',' || trim(readingdate) || ',' || reading || ',' || consumption
from consumptiondata;

spool off

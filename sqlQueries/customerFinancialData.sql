set heading off
set newpage none

spool /tmp/customerdata/financialdata_dbtest.csv

select trim(account#) || ',' || trim(paymentdate) || ',' || amount
from financialdata;

spool off

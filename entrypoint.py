#!/usr/bin/env python3

import os

confphp = os.path.isfile('/opt/gistpb/app/config/propel/config.php')

if confphp == False:
    os.chdir('/opt/gistpb')
    os.system('chmod +x /usr/bin/firsttime.sh')
    os.system('/usr/bin/firsttime.sh')
else:
    execcmd = ["/usr/bin/supervisord", "-n", "-c", "/data/spvisord/supervisord.conf"]
    cmdstr = ' '.join(execcmd)
    os.system(cmdstr)

setenforce Permissive
sed --in-place s/SELINUX=enforcing/SELINUX=permissive/g /etc/selinux/config

rpm --install /media/sf_DPF_Upgrade/12.2.1/cntlm-0.92.3-1.x86_64.rpm
mkdir /var/run/cntlm
chgrp cntlm /var/run/cntlm/
chmod g+w /var/run/cntlm/
usermod --home /home/cntlm --move-home cntlm
sed --in-place s#'PIDFILE="/var/run/cntlm/cntlmd.pid"'#'PIDFILE="/tmp/cntlmd.pid"'#g /etc/sysconfig/cntlmd

yum install -y ansible
yum install bind-utils

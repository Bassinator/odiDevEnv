basic image: http://yum.oracle.com/boxes

WICHTIG: bei passwort wechsel für den NT account muss unbedingt das .secrets
file gelöscht werden und die VM neu provisioniert werden. Ansosnten werden
sofort mehrere Anmeldungen am Helsana Proxy mit dem Alten PW gemacht und der
Account wird gelöscht

prerequisite:
- svn client
- VirtualBox (actual version >= 5.2) installed
- Vagrant installed

setup:
- checkout
- download box onto disk http://yum.oracle.com/boxes/oraclelinux/ol74/ol74.box
- vagrant box add ol74 ol74.box (in the folder you downloaded the box image)
- vagrant init ol74
- vagrant up (this may take approx one hour)
  you can login to the machine with vagrant ssh to monitor the process
  (top for running processes, iftop for network traffic [availalbe after the
  ansible baseconfig role finished])
- login with user: helsi pass:oracle

- debug: vagrant ssh to login to the VM, if no graphical interface is available


hints:
- if you get feedback when provisioning the vm, that another process is holding
  the yum lock. It may be the PackageKit looking for updates, which may take a
  few minutes. Just be patient. Provisioning will proceed just after PackageKit
  finished checking for updates.

Basic Info & README

This directory contains all sub directories that are not vault directories. It also holds the primary inventory.yml file, the primary Log file, the README, and the playRunner.sh.
The log file stores logs of all ansible executions, it overwrites itself with each new execution, so capture the log files before it runs again.
Welcome to the Ansible server. Everything should be pretty well organized here. Docker books are in the Docker directory, SSH in the SSH directory, etc. Everything you need should be found pretty easily by category.


To set up new servers, do the following:
1. Copy the SSH public key (/etc/ssh/ssh_host_ed25519_key.pub) to your clipboard.
2. Go to the remote server and open the ~/.ssh/authorized_keys file. Paste it in there. Restart ssh (systemctl restart ssh).
3. Run the playbook NewUser.yaml (<path>/ansible_dir/SSHBooks). This will create the <user> user on the machines, as well as create the .ssh directory, and inject the public key.
4. Copy the new password that was created. Create a new vault (newVault.sh) and put the password in there as su_password: *password* (userPass.sh).
5. Run the StripRootKeys.yaml playbook (<path>/ansible_dir/SSHBooks). This will strip the public key from the root directories so there is no root access.
6. Then, run any playbooks that you wish. You can use playRunner.sh to help navigate them.

- Blake Miller
luckyblake02@gmail.com

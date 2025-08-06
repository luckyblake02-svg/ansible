# Ansible Automation Repository

This repository contains Ansible playbooks, YAML inventory files, and shell scripts designed to automate the administration and setup of Linux machines. It provides organized automation to manage tasks like user creation, SSH key management, Docker setups, and more.

## Overview

- Contains primary inventory (`inventory.yml`) and a logging system that captures execution logs.
- Separate directories for categorized playbooks and scripts, such as Docker, SSH, etc., for easy navigation.
- Includes shell scripts (e.g., `playRunner.sh`, `newVault.sh`, `userPass.sh`) to assist with Ansible playbook execution and password management.
- Playbooks cover key administrative functions:
  - `NewUser.yaml` - creates users, manages `.ssh` directories and injects public SSH keys.
  - `StripRootKeys.yaml` - removes SSH public keys from root directories to restrict root access.

## Getting Started

1. Copy the SSH public key from `/etc/ssh/ssh_host_ed25519_key.pub` on the Ansible server.
2. Add it to the remote machine’s `~/.ssh/authorized_keys` file and restart SSH (`systemctl restart ssh`).
3. Run `NewUser.yaml` from the `SSHBooks` directory to set up new users with SSH access.
4. Store any generated passwords securely using the provided `newVault.sh` script.
5. Run `StripRootKeys.yaml` to remove root access keys for security.
6. Use `playRunner.sh` to execute additional playbooks as needed.

## Structure

/ansible_dir
├── DockerBooks/         # Playbooks related to Docker administration
├── SSHBooks/            # Playbooks related to SSH and user access
├── inventory.yml        # Main inventory file defining managed hosts
├── playRunner.sh        # Shell script to facilitate running playbooks
├── newVault.sh          # Script to create new Ansible vaults
├── userPass.sh          # Script to manage generated passwords
└── ansible.log          # Logs of the last Ansible run (overwritten each run)

## Requirements

- Ansible installed on the control machine.
- SSH access configured as described.
- Sudo privileges for user management.

## License

This project is licensed under the GNU General Public License v3.0 (GPLv3). See the LICENSE file for details.


For questions or support, contact Blake Miller at luckyblake02@gmail.com.

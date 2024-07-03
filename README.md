# user-management-script

## Overview

This repository contains a Bash script (`create_users.sh`) designed to automate the process of creating new users, assigning them to specified groups, generating random passwords, and logging all actions. This script is intended for use by SysOps engineers or system administrators to streamline user management tasks, especially in environments with frequent onboarding of new developers.

## Features

- **User Creation**: Creates users based on input from a text file (`users.txt`), assigning them to specified groups.
- **Group Management**: Automatically creates personal groups for each user with the same name as the username.
- **Password Generation**: Generates random passwords for each user and securely stores them in `/var/secure/user_passwords.csv`.
- **Logging**: Logs all actions to `/var/log/user_management.log` for audit and troubleshooting purposes.
- **Security**: Ensures that sensitive files (`user_passwords.csv` and `user_management.log`) have appropriate permissions (readable only by root).

## Usage

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/daniell-olaitan/user-management-script.git
   cd user-management-script
   ```

2. **Prepare Input File**:

   Create a text file (`users.txt`) containing usernames and groups in the format `username;group1,group2`.

   Example (`users.txt`):
   ```
   john;developers,admins
   jane;admins
   ```

3. **Run the Script**:

   Execute the script with `./create_users.sh users.txt`. Ensure you have necessary permissions to execute and write to `/var/log` and `/var/secure`.

4. **Check Logs and Passwords**:

   - Logs of all actions are stored in `/var/log/user_management.log`.
   - User passwords are securely stored in `/var/secure/user_passwords.csv`.

## Files

- `create_users.sh`: The main Bash script for user management automation.
- `users.txt`: Sample input file demonstrating the format for usernames and groups.
- `README.md`: This file, providing an overview of the project and instructions for usage.

## Security Considerations

- Ensure that sensitive files (`user_passwords.csv` and `user_management.log`) are only accessible by the root user.
- Use caution when handling and distributing passwords.

## Contributions

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to submit an issue or pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

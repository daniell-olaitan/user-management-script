#!/usr/bin/env bash

# Check if the input file is provided
if [ -z "$1" ]; then
    echo "Usage: bash create_users.sh <name-of-text-file>"
    exit 1
fi

INPUT_FILE="$1"
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.csv"

# Create log and password directories/files with appropriate permissions
sudo mkdir -p /var/log
sudo touch $LOG_FILE
sudo chmod 644 $LOG_FILE
sudo chown root:root $LOG_FILE

sudo mkdir -p /var/secure
sudo touch $PASSWORD_FILE
sudo chmod 600 $PASSWORD_FILE
sudo chown root:root $PASSWORD_FILE

# Function to create a user
create_user() {
    local username=$1
    local groups=$2
    local password=$(openssl rand -base64 12)

    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User $username already exists. Skipping..." | sudo tee -a $LOG_FILE
    else
        # Create user with home directory and personal group
        sudo useradd -m -G "$username,$groups" "$username"
        echo "$username:$password" | sudo chpasswd

        # Set permissions and ownership for the home directory
        sudo chmod 700 /home/"$username"
        sudo chown "$username":"$username" /home/"$username"

        # Log the user creation
        echo "Created user $username with groups $groups and home directory /home/$username" | sudo tee -a $LOG_FILE

        # Save the password securely
        echo "$username,$password" | sudo tee -a $PASSWORD_FILE
    fi
}

# Read the input file and process each line
while IFS=';' read -r username groups; do
    # Remove leading/trailing whitespace
    username=$(echo "$username" | xargs)
    groups=$(echo "$groups" | xargs)

    # Replace commas with spaces for group list
    groups=$(echo "$groups" | tr ',' ' ')

    # Create the user
    create_user "$username" "$groups"
done < "$INPUT_FILE"

# Change ownership and permissions of the log and password files for security
sudo chmod 600 $PASSWORD_FILE
sudo chown root:root $PASSWORD_FILE

echo "User creation process completed. Check $LOG_FILE for details and $PASSWORD_FILE for passwords."

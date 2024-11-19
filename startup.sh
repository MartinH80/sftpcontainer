# start syslog daemon
/sbin/syslogd

# create sftp group
addgroup sftpg

# Create required users and their personal directory
# Read each line from /data/userlist.txt
while IFS=' ' read -r username password; do
  # Check if both username and password are not empty
  if [ -n "$username" ] && [ -n "$password" ]; then
    # create user
    #   without home directory (-H)
    #   without asking for a password (-D)
    #   without shell access (-s /sbin/nologin)
    #   in group sftpg
    adduser -H -D -s /sbin/nologin $username -G sftpg
    # Set the user's password
    echo "$username:$password" | chpasswd
    echo "Created user $username with specified password."
    # make user directory
    mkdir /data/$username
    chown root:sftpg /data/$username
  else
    echo "Skipping line: either username or password is missing."
  fi
done < /data/userlist.txt

# create ssh keys
/usr/bin/ssh-keygen -A

# start sshd service
/usr/sbin/sshd -D

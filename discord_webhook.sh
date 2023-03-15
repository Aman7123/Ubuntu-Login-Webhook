#!/bin/bash
# Setup Discord vars
DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/abcd1234
ADMIN_CONTACT="<@176355202687959051>"
# For Discord notification that a user connected to the server
if [ -n "$SSH_CLIENT" ]; then
    # Store stating splitter
    OIFS=${IFS}
    # Set new splitter
    IFS=" "
    # Define some stating variables
    HOSTNAME=$(hostname)
    DATE_CMD=$(date -u)
    # Parse the SSH connection info
    read -a CONNECTION <<< "${SSH_CLIENT}"
    # Store the parsed values
    IP=${CONNECTION[0]}
    PORT=${CONNECTION[2]}
    # Make webhook POST request
    curl -f \
        -H "Content-Type: application/json" \
        -d "{\"content\":\"${ADMIN_CONTACT}\",\"embeds\":[{\"type\":\"rich\",\"title\":\"❗️New Remote Connection 🖥❗️\",\"description\":\"A connection from \`${IP}\` has been established to \`${HOSTNAME}:${PORT}\` via SSH\",\"color\":16776960,\"footer\":{\"text\":\"${DATE_CMD}\"}}]}" \
        "${DISCORD_WEBHOOK_URL}"
    # Restore the old splitter
    IFS=${OIFS}
fi
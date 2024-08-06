# Automatically appends the profile to aws commands
# Uses 'terrafor-user' profile for aws cli commands by default but can be overridden by setting AWS_PROFILE
aws() {
  local profile=${AWS_PROFILE:-terraform-user}
  command aws "$@" --profile $profile
}

# Get the current AWS SSO expiration time. Used by p10k to display the AWS SSO expiration time in the prompt.
aws_sso_expiry() {
    local cache_dir="$HOME/.aws/cli/cache"
    local latest_file
    local expires_at
    local now
    local time_diff
    local days
    local hours
    local minutes
    local result

    # Find the most recently updated JSON file
    latest_file=$(find "$cache_dir" -type f -name "*.json" -print0 | xargs -0 ls -t | head -n 1)

    if [[ -z "$latest_file" ]]; then
        echo "No SSO cache files found"
        return 1
    fi

    # Extract expiresAt value using jq
    expires_at=$(jq -r '.Credentials.Expiration' "$latest_file")

    if [[ -z "$expires_at" || "$expires_at" == "null" ]]; then
        echo "No Expiration value found"
        return 1
    fi

    # Get current time in UTC
    now=$(date -u +%s)

    # Convert expiresAt to Unix timestamp (macOS compatible)
    expires_at=$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$expires_at" "+%s")

    # Calculate time difference
    time_diff=$((expires_at - now))

    if ((time_diff < 0)); then
        echo "expired"
    else
        # Convert to days, hours, minutes
        days=$((time_diff / 86400))
        hours=$(( (time_diff % 86400) / 3600 ))
        minutes=$(( (time_diff % 3600) / 60 ))

        # Construct result string, omitting zero values
        result=""
        [[ $days -gt 0 ]] && result+="${days}d|"
        [[ $hours -gt 0 ]] && result+="${hours}h|"
        result+="${minutes}m"

        echo "$result"
    fi
}

# Update zinit and plugins
update_zinit() {
    zinit self-update
    zinit update --parallel 40
}

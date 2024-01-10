#!/bin/bash

# Your Spotify API credentials
CLIENT_ID="96561ca40eda4d009f730ddd00c8e0dc"
CLIENT_SECRET=$(cat /Users/sejersen/dev/shell_scripts/spotify/auth_scripts/secret.txt)
REFRESH_TOKEN=$(cat /Users/sejersen/dev/shell_scripts/spotify/auth_scripts/refresh_token.txt)

# Base64 encode client ID and client secret
BASE64_AUTH=$(echo -n "$CLIENT_ID:$CLIENT_SECRET" | base64)

# Spotify API token endpoint
TOKEN_ENDPOINT="https://accounts.spotify.com/api/token"

# Make a request to refresh the access token
RESPONSE=$(curl -s -X POST -H "Authorization: Basic $BASE64_AUTH" \
  -d "grant_type=refresh_token&refresh_token=$REFRESH_TOKEN" \
  $TOKEN_ENDPOINT)

# Extract the new access token from the response
NEW_ACCESS_TOKEN=$(echo "$RESPONSE" | jq -r '.access_token')

echo "$NEW_ACCESS_TOKEN" > /Users/sejersen/dev/shell_scripts/spotify/auth_scripts/access_token.txt
echo "Succesfully requested new acces token!"

#!/bin/bash

source /Users/sejersen/dev/shell_scripts/spotify/auth_scripts/refresh_token.sh

# Your access token
ACCESS_TOKEN=$(cat "/Users/sejersen/dev/shell_scripts/spotify/auth_scripts/access_token.txt")

# API endpoint you want to request
API_ENDPOINT="https://api.spotify.com/v1/me/player/currently-playing"

# Make a GET request with the access token in the Authorization header
curl -s -H "Authorization: Bearer $ACCESS_TOKEN" "$API_ENDPOINT" > /Users/sejersen/dev/shell_scripts/spotify/now_playing.json

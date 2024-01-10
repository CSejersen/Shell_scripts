#!/bin/bash

# Spotify API credentials
CLIENT_ID="96561ca40eda4d009f730ddd00c8e0dc"
CLIENT_SECRET=$(cat secret.txt)
REDIRECT_URI="http://localhost:8888/callback"

# Authorization code manually obtained with python flask server by pasting the link from the get auth_link script in the browser.
AUTH_CODE=$(<auth_code.txt)

# Exchange authorization code for access token
# Client ID and Secret in the header and Authcode + redirect_URI sent in body of POST request
TOKEN_RESPONSE=$(curl -s -X POST -H "Authorization: Basic $(echo -n "$CLIENT_ID:$CLIENT_SECRET" | base64)" \
  -d "grant_type=authorization_code&code=$AUTH_CODE&redirect_uri=$REDIRECT_URI" \
  https://accounts.spotify.com/api/token)

echo "$TOKEN_RESPONSE"

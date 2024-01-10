#!/bin/bash

URI=$(jq -r '.item.uri' now_playing.json)
ARTIST=$(jq -r '.item.artists[0].name' now_playing.json)
TITLE=$(jq -r '.item.name' now_playing.json)

ACCESS_TOKEN=$(cat "/Users/sejersen/dev/shell_scripts/spotify/auth_scripts/access_token.txt")

# Hard coding id for "Hacking" playlist
API_ENDPOINT="https://api.spotify.com/v1/playlists/6e1dvoMYW27TeDgdzMLqB3/tracks?uris=$URI"

# Post request with the access token in the Authorization header - redirecting output to /dev/null
curl -s -o /dev/null -X POST -H "Authorization: Bearer $ACCESS_TOKEN" "$API_ENDPOINT"

echo "Added: $TITLE - $ARTIST"

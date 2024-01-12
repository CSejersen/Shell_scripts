#!/bin/bash
#
# Now playing info (gets updated by get_now_playing.sh when "add" alies is called)
ARTIST=$(jq -r '.item.artists[0].name' /Users/sejersen/dev/shell_scripts/spotify/now_playing.json)
TITLE=$(jq -r '.item.name' /Users/sejersen/dev/shell_scripts/spotify/now_playing.json)
URI=$(jq -r '.item.uri' /Users/sejersen/dev/shell_scripts/spotify/now_playing.json)

# Fresh access token (gets updated by "/auth_scripts/refresh_token.sh" when "add" alias is called)
ACCESS_TOKEN=$(cat "/Users/sejersen/dev/shell_scripts/spotify/auth_scripts/access_token.txt")

#
PLAYLIST_ID=6e1dvoMYW27TeDgdzMLqB3
LIMIT=5
OFFSET=0
RUN=1

# Endpoint for adding track to Hacking playlist
API_ENDPOINT_ADD_TRACK="https://api.spotify.com/v1/playlists/$PLAYLIST_ID/tracks?uris=$URI"

# Get all tracks currently on the playlist in chunks of size $LIMIT
while [ $RUN -eq 1 ]; do
TRACKS=$(curl -s --request GET \
  --url "https://api.spotify.com/v1/playlists/$PLAYLIST_ID/tracks?fields=items(track(uri))&limit=$LIMIT&offset=$OFFSET" \
  --header "Authorization: Bearer $ACCESS_TOKEN" | jq -r .items[].track.uri)
  
  # Loop over individual tracks in chunk
  # IFS= is good practice for consistent behavior (making sure to presevere leading and trailing white space)
  while IFS= read -r track; do
    if [ "$track" = "$URI" ]; then
      echo "Match found: $TITLE by $ARTIST is already in your playlist!"
      exit 0 # Exit in case of match
    fi
    done <<< "$TRACKS"

  # Get number of songs returned by request
  LINENUMS=$(echo "$TRACKS" | wc -l )

  # Check if end of playlist is reached
  # -lt = less than operator
  if [ "$LINENUMS" -lt "$LIMIT" ]; then
    # Stop of end of playlist
    RUN=0
  fi

  OFFSET=$((OFFSET + LIMIT))
done

# Add track if this is reached
# Post request with the access token in the Authorization header - redirecting output to /dev/null for silent execution 
curl -s -o /dev/null -X POST -H "Authorization: Bearer $ACCESS_TOKEN" "$API_ENDPOINT_ADD_TRACK"

echo "Added: $TITLE - $ARTIST"

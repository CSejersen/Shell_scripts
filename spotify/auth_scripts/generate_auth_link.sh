RESPONSE_TYPE="code"
CLIENT_ID="96561ca40eda4d009f730ddd00c8e0dc"
REDIRECT_URI="http://localhost:8888/callback"
# Using %20 for space
SCOPE="user-read-playback-state%20playlist-modify-public%20playlist-modify-private%20playlist-read-private"

# Create the authorization URL
AUTH_URL="https://accounts.spotify.com/authorize?response_type=$RESPONSE_TYPE&client_id=$CLIENT_ID&scope=$SCOPE&redirect_uri=$REDIRECT_URI"

echo "$AUTH_URL"


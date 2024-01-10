from flask import Flask, request

app = Flask(__name__)

f = open('secret.txt', 'r')
secret = f.readline()

CLIENT_ID = '96561ca40eda4d009f730ddd00c8e0dc'
CLIENT_SECRET = secret
REDIRECT_URI = 'http://localhost:8888/callback'

@app.route('/')
def home():
    return 'Authorization Server is running.'

@app.route('/callback')
def callback():
    # Get the authorization code from the callback
    auth_code = request.args.get('code')


    return f'Authorization Code: {auth_code}'

if __name__ == '__main__':
    app.run(port=8888)


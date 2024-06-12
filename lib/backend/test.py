from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS

# Mock database of users
users = {
    "nik": "123",  # username user: password user
    "admin": "admin123" # username admin: password admin
}

# Color codes for terminal messages
class TerminalColors:
    OKGREEN = '\033[92m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'

# Endpoint to handle login
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    if username in users and users[username] == password:
        print(f"{TerminalColors.OKGREEN}[INFO] Login successful for user: {username}{TerminalColors.ENDC}")
        return jsonify({"message": "Login successful", "status": "success"}), 200
    else:
        print(f"{TerminalColors.FAIL}[ERROR] Login failed for user: {username}{TerminalColors.ENDC}")
        return jsonify({"message": "Invalid credentials", "status": "failure"}), 401

if __name__ == '__main__':
    print(f"{TerminalColors.OKGREEN}[INFO] Flask server running at http://127.0.0.1:5000{TerminalColors.ENDC}")
    app.run(debug=True)

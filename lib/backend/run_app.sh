# run_app.sh
#!/bin/bash

# Start the Python server in the background
python3 test.py &

# Save the process ID (PID) of the Python server
PYTHON_PID=$!

# Start the Flutter app
flutter run

# Kill the Python server when the Flutter app exits
kill $PYTHON_PID

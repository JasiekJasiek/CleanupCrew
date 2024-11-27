#!/bin/bash

FILE=$1

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

EXTENSION="${FILE##*.}"  
BASENAME="${FILE%.*}"   

if [ "$EXTENSION" = "py" ]; then
    echo "Detected Python script."
    python3 "$FILE" &
    PROGRAM_PID=$!
    echo "Started Python script '$FILE' with PID=$PROGRAM_PID. Monitoring subprocesses."
elif [ "$EXTENSION" = "cpp" ]; then
    echo "Detected C++ source file."
    g++ -std=c++20 -Wall -o "$BASENAME" "$FILE"
    if [ $? -ne 0 ]; then
        echo "Error: Compilation of '$FILE' failed."
        exit 2
    fi
    ./"$BASENAME" &
    PROGRAM_PID=$!
    echo "Started compiled C++ program '$BASENAME' with PID=$PROGRAM_PID. Monitoring subprocesses."
else
    echo "Error: Unsupported file extension '$EXTENSION'. Only '.py' and '.cpp' are supported."
    exit 3
fi

sleep 1

SUBPROCESSES=$(pgrep -P "$PROGRAM_PID")
for pid in $SUBPROCESSES; do
    echo "Found subprocess PID: $pid"
done

while kill -0 "$PROGRAM_PID" 2>/dev/null; do
    sleep 1
done

echo "Process '$FILE' (PID=$PROGRAM_PID) has exited."

if [ -n "$SUBPROCESSES" ]; then
    echo "Active subprocesses detected. Terminating them:"
    for pid in $SUBPROCESSES; do
        echo "Terminating subprocess PID=$pid"
        kill -9 "$pid"
    done
else
    echo "No active subprocesses found."
fi

echo "All processes have been handled."

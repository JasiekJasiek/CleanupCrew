# Script: File Executor and Subprocess Monitor

This repository contains a Bash script designed to execute Python or C++ files and monitor their subprocesses. It handles basic error checking, process monitoring, and cleanup of any active subprocesses.

## Features
- Detects file type based on the file extension (`.py` for Python, `.cpp` for C++).
- Executes Python scripts using `python3` or compiles and runs C++ source files using `g++`.
- Monitors subprocesses spawned by the main program.
- Ensures proper cleanup by terminating any active subprocesses when the main process exits.

## Script Usage

### Prerequisites
- Python 3 for running Python scripts.
- A C++ compiler (`g++`) that supports C++20 for compiling C++ files.

### How to Use
1. Clone the repository or download the script.
2. Make the script executable:
   ```bash
   chmod +x cleanup_crew.sh
3. Run the script with a Python or C++ file as an argument:
   ```bash
   ./cleanup_crew.sh python_file.py
   ```
   or
   ```bash
   ./cleanup_crew.sh cpp_file.cpp
   ```

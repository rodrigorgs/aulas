#!/usr/bin/env python3

import os
import sys
import time
import random
import signal
import termios
import tty
import select
from datetime import datetime
import contextlib

# Configuration
# The .sh script used "analyzer/lib/...". 
# Assuming it's run from /Users/scheglov/Source/Dart/sdk.git/sdk/pkg/
FILE_PATH = "analyzer/lib/src/summary2/element_builder.dart" 

MUTATIONS = [
    ("void buildElements({", "void buildElements2({"),
    ("class ElementBuilder {", "class ElementBuilder2 {")
]

# Colors for "Premium" UI
CYAN = "\033[36m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
RED = "\033[31m"
RESET = "\033[0m"
BOLD = "\033[1m"
CLEAR_LINE = "\033[2K"

def revert_to_original():
    print(f"\n{YELLOW}Reverting to original state...{RESET}")
    if not os.path.exists(FILE_PATH):
        # Try relative to current script if called from pkg/analyzer
        alt_path = os.path.join(os.path.dirname(__file__), "../../../", FILE_PATH)
        if os.path.exists(alt_path):
             # Path found
             pass
        else:
            print(f"{RED}Error: File not found at {FILE_PATH}{RESET}")
            return
    
    with open(FILE_PATH, 'r') as f:
        content = f.read()
    
    new_content = content
    # Order matters: revert in reverse order of mutation if needed, 
    # but here replacement is unique enough
    for original, modified in MUTATIONS:
        new_content = new_content.replace(modified, original)
    
    if new_content != content:
        with open(FILE_PATH, 'w') as f:
            f.write(new_content)
        print(f"{GREEN}Reverted successfully.{RESET}")
    else:
        print(f"{CYAN}Already in original state.{RESET}")

def signal_handler(sig, frame):
    revert_to_original()
    sys.exit(0)

@contextlib.contextmanager
def raw_mode(file):
    """Context manager to put the terminal in raw mode and restore it."""
    if not os.isatty(file.fileno()):
        yield
        return
    old_settings = termios.tcgetattr(file.fileno())
    try:
        tty.setraw(file.fileno())
        yield
    finally:
        termios.tcsetattr(file.fileno(), termios.TCSADRAIN, old_settings)

def wait_with_hud(duration):
    """Sleeps while showing a countdown and checking for ESC."""
    end_time = time.time() + duration
    
    # We set raw mode for the entire duration of the sleep to be reliable
    fd = sys.stdin.fileno()
    with raw_mode(sys.stdin):
        while time.time() < end_time:
            remaining = max(0, end_time - time.time())
            # In raw mode, we use \r\n for actual new lines if we needed them, 
            # but for HUD \r is enough.
            msg = f"\r{CLEAR_LINE}{CYAN}Sleeping... {BOLD}{remaining:.1f}s{RESET} remaining. (Press {RED}ESC{RESET} to stop)   "
            sys.stdout.write(msg)
            sys.stdout.flush()
            
            # Check for input without a long block
            rlist, _, _ = select.select([fd], [], [], 0.1)
            if rlist:
                # Use os.read to bypass Python's TextIOWrapper buffer
                char = os.read(fd, 1)
                if char == b'\x03': # Ctrl+C
                    sys.stdout.write(f"\r\n{RED}Ctrl+C pressed.{RESET}\r\n")
                    sys.stdout.flush()
                    break

                if char == b'\x1b':  # ESC
                    # Distinguish between lone ESC and arrow keys/sequences
                    r_seq, _, _ = select.select([fd], [], [], 0.05)
                    if not r_seq:
                        # Lone ESC pressed
                        sys.stdout.write(f"\r\n{RED}ESC pressed.{RESET}\r\n")
                        sys.stdout.flush()
                        # Exit the context manager (restores terminal) then revert
                        break 
                    else:
                        # Sequence (like arrow key), consume and ignore remaining bytes
                        # Read enough to clear typical sequences
                        os.read(fd, 10)
        else:
            # Loop finished normally
            sys.stdout.write(f"\r{CLEAR_LINE}")
            sys.stdout.flush()
            return

    # If we broke out of the loop (ESC), we fall through here
    revert_to_original()
    sys.exit(0)

def mutate(target, replacement):
    if not os.path.exists(FILE_PATH):
        return False

    with open(FILE_PATH, 'r') as f:
        content = f.read()
    
    if target in content:
        new_content = content.replace(target, replacement)
        with open(FILE_PATH, 'w') as f:
            f.write(new_content)
        print(f"{GREEN}Change:{RESET} {YELLOW}{target}{RESET} -> {BOLD}{replacement}{RESET}")
        return True
    return False

def main():
    # Setup signal handling (Ctrl+C)
    signal.signal(signal.SIGINT, signal_handler)

    # Ensure we are in the right directory or the file exists
    global FILE_PATH
    if not os.path.exists(FILE_PATH):
        # Try stripping 'analyzer/' if already in that dir
        if FILE_PATH.startswith("analyzer/"):
            alt_path = FILE_PATH[len("analyzer/"):]
            if os.path.exists(alt_path):
                FILE_PATH = alt_path

    print(f"{BOLD}{CYAN}Starting mutation loop...{RESET}")
    print(f"{CYAN}Target file:{RESET} {FILE_PATH}")

    try:
        while True:
            # Check time limit (23:30)
            now = datetime.now()
            if now.hour == 23 and now.minute >= 30:
                print(f"{RED}Time limit reached (23:30). Stopping.{RESET}")
                revert_to_original()
                break

            # Sequence: Change 1 -> Wait -> Change 2 -> Wait -> Revert 1 -> Wait -> Revert 2 -> Wait
            
            # Change 1
            if mutate(MUTATIONS[0][0], MUTATIONS[0][1]):
                wait_with_hud(random.randint(5, 15))
            
            # Change 2
            if mutate(MUTATIONS[1][0], MUTATIONS[1][1]):
                wait_with_hud(random.randint(5, 15))
                
            # Revert 1
            if mutate(MUTATIONS[0][1], MUTATIONS[0][0]):
                wait_with_hud(random.randint(5, 15))
                
            # Revert 2
            if mutate(MUTATIONS[1][1], MUTATIONS[1][0]):
                wait_with_hud(random.randint(5, 15))

    except Exception as e:
        print(f"\n{RED}Error: {e}{RESET}")
        revert_to_original()

if __name__ == "__main__":
    main()

#!/bin/bash

current_pid=$$
echo "Walking process tree from PID $current_pid:"

for i in {1..20}; do
    [ $current_pid -gt 1 ] || break

    process_name=$(ps -o comm= -p "$current_pid" 2>/dev/null)
    echo "  PID $current_pid: $process_name"

    current_pid=$(ps -o ppid= -p "$current_pid" 2>/dev/null | tr -d ' ')
    [ -z "$current_pid" ] && break
done

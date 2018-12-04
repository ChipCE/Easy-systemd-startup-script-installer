#!/bin/bash
for f in /path/to/shell/folder/*.sh; do
	echo "Execute $f"
	bash "$f" -H   || break # if needed 
done
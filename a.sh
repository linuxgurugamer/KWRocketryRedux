#!/bin/bash

awk '
{	line[NR] = $0
}
/./ {	lastNB = NR
}
END {	for(i = 1; i <= NR; i++)
		if(i != lastNB)
			print line[i]
}' KWRocketryRebalanced.version

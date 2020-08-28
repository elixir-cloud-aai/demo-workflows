#!/bin/bash

output_basename=$(basename $1 .assoc.logistic)
chromosome=$(head -2 $1 | tail -1 | cut -d ',' -f 1)
manhattan_plot.py \
	-i $1 \
	-o $output_basename.png \
	-c $chromosome

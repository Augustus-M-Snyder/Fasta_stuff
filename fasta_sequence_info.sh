#!/bin/bash

# Goals of this script
# (1) Process an array of files and determine:
#    (a) the number of sequences in each file
#    (b) the list of sequence IDs in each file

echo "Here goes!"

files=$(ls ./fasta_files/*.fasta)

# Tests looping over file list
for i in $files
do echo "$i"
done

# Looping over the array of files and creating the output files
for i in $files
	do
	echo "($basename "$i")" >> files_summary.txt
	echo " Number of sequence IDs in '($basename "$i")'" >> files_summary.txt
	grep -c "^>" $i >> files_summary.txt
	echo "($basename "$i")" >> sequenceID_list.txt
# Reads files line-by-line. While reading the file, searches for geneIDs and appends them to the genelist under each file name
(	(	while read -r line
			do
				if
				 echo "$line" | grep -q "^>"
				then
				 awk '/^>/ {printf("\n%s\n",$1)}' >> sequenceID_list.txt
				fi
			done ) < "$i" )
	done



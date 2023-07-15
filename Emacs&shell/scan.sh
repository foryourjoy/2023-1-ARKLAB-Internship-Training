#!/bin/bash

scan_file="LDLR_scan.txt"; tf_name=""; class_name=""; range="";
option_name="default"
m=0; n=999999999;

option_flag=0; tf_flag=0; class_flag=0; range_flag=0;

function print_help {
    echo "-------------------------"
    echo "Mandatory argument"
    echo "-i : Scan file input"
    echo ""
    echo "Optional argument"
    echo "-o : Option argument"
    echo "-s : Row must contain input string"
    echo "-r : Range"
    echo "-h : Print help"
    echo "-------------------------"
}

# Colon (:) indicates that the flag must have an argument.
# For example -s, -c, -o, -t is marked with :, but -h is not.
# -h can be used independently, but flags such as -i and -o, must have an argument
# ex) ./scan.sh -i "--" -o "--"

while getopts i:o:t:c:r:h getopt
do
    case "$getopt" in
	i) scan_file="$OPTARG";;
	o) option_name="$OPTARG"; option_flag=1;;
	t) tf_name="$OPTARG"; tf_flag=1;;
	c) class_name="$OPTARG"; class_flag=1;;
	r) range="$OPTARG"; range_flag=1;;
	# Task 3
	# If option flag is -h or other, then print help statement.
	h) print_help;;
	*) print_help;;
	:) case $OPTARG in
	       i) print_help;;
	       o) print_help;;
	       t) print_help;;
	       c) print_help;;
	       r) print_help;;
	       h) print_help;;
	   esac; exit;;
    esac
done

# Task 1 fill in the conditional
# Error if no argument is given.
if [ $# -eq 0 ]; then
    print_help
    exit
fi

# Task 2 fill in the conditional
# Error if scan file does not exist.
# Include "$scan_file"
if [ ! -e "$scan_file" ]; then
    echo "Scan file does not exist"
    exit
fi

# Task 4 The input form of -r is 'm,n'. ex)./scan.sh -r 20,52
# Split -r into array. If first element is equal or larger than second element, error (m >= n).
if [[ "$range_flag" -eq 1 ]]; then
    IFS=',' read -a range <<< "$range"

	 # Split $range into array


    if [[ ${range[0]} == "" || ${range[1]} == "" ]]; then
	echo "m or n is empty"
	exit
    
    elif [[ ${range[0]} -ge ${range[1]} ]]; then
	echo "m >= n: Error"
	exit
    fi

    m=${range[0]}
    n=${range[1]}
fi

# Task 5 fill in the conditional
# Error if scan file does not exist.
if [[ ! -e "$scan_file" ]]; then
    case $option_name in
	"default"|"mean"|"plot") ;; # Check whether $option_name contains either three of the possible arguments
	*) echo "Illegal argument for -o: $option_name"; exit;;
    esac
fi

echo $@


if [[ $tf_flag -eq 1 ]]; then
    tf_name=`echo $tf_name | tr ',' '|'`
fi

if [[ $class_flag -eq 1 ]]; then
    class_name=`echo $class_name | tr ',' '|'`
fi

result=$(awk -v tf_search="$tf_name" -v class_search="$class_name" -v m="$m" -v n="$n" \
	     '($1 ~ tf_search || $6 ~ tf_search) && $5 ~ class_search && !($2 > n || $3 < m)' $scan_file)

min=$(awk 'NR > 1 {print $2}' $scan_file | sort -nk1 | head -1) # minimum m value from input file
max=$(awk 'NR > 1 {print $3}' $scan_file | sort -nk1 | tail -1) # maximum n value from input file

case $option_name in
    "mean") echo "$result" > temp.tmp; Rscript scan.R temp.tmp "mean"; rm temp.tmp;;
    "plot") echo "$result" > temp.tmp; Rscript scan.R temp.tmp "plot" $min $max; rm temp.tmp;;
    "default") echo "$result";;
    *) echo "Illegal argument for -o: $option_name"; exit;;
esac

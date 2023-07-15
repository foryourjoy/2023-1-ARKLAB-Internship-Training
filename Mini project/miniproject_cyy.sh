#!/bin/bash
scan_file=""; genotype=""; value=""; tf_index=""; geno_num=""; select_file=""; geno_flag=0;

#help function
function print_help {
    echo "-------------------------"
    echo "-i : Scan file input"
    echo "-g : genotype"
    echo "-v : value(Capf, Caf, CaF, CaFFGF)"
    echo "-t : TF index"
    echo "-h : Print help"
    echo "-------------------------"
}

#option arguments
while getopts i:g:v:t:h getopt
do
    case "$getopt" in
        i) scan_file="$OPTARG";;
        g) genotype="$OPTARG"; geno_flag=1;;
        v) value="$OPTARG";;
        t) tf_index="$OPTARG";;
        ?) print_help;;
    esac
done

#check genotype(from the input option) and assign last number of split file name(geno_num)
if [ $geno_flag == 1 ]; then

    if [ $genotype == "M3_2_lox" ]; then
        geno_num=0
    elif [ $genotype == "M32_lox" ]; then
        geno_num=1
    elif [ $genotype == "M23_lox" ]; then
        geno_num=2
    elif [ $genotype == "M2_3_lox" ]; then
        geno_num=3
    elif [ $genotype == "p1700" ]; then
        geno_num=4
    elif [ $genotype == "MSE2" ]; then
        geno_num=5
    elif [ $genotype == "MSE3" ]; then
        geno_num=6
    fi
fi

#Error if no argument is given
if [ $# -eq 0 ]; then
    echo "Error: no argument is given"
    print_help
    exit
fi

#Error if scan file does not exist
if [ ! -d $scan_file  ]; then
    echo "Error: scan file is not a directory"
    print_help
    exit
fi

# use a file one by one from a input directory with multiple xml files
for file in $scan_file/*.xml
do  
    #split files by genotype (filename: genotype0~) from xml files
    csplit -z -f "genotype" $file '/xml/' '{*}'

    #find index and put it into $test(just checking existence of index)
    test=`awk '{print $2}' genotype0$geno_num | grep $tf_index`

    #if $test is null(no index)
    if [ ! -n "$test" ]; then
        echo "no such index"
    
    #if $test is not null(index exists!)
    else
        # put file argument(ex: genotype03)
        select_file=genotype0$geno_num

        #pass arguments to R script
        Rscript mini2.R "$select_file" "$value" "$tf_index" "$file" "$genotype"
    fi
    
done
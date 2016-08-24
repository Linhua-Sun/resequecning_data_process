#!/bin/bash

## Refer to "http://snpeff.sourceforge.net/SnpSift.html#Extract"

## You can use command line option -s to specify multiple field separator and -e to specify how to represent empty fields. 

## If we prefer to have one effect per line, then we can use the vcfEffOnePerLine.pl provided with SnpEff distribution


## Input file
input=$1
ID=$(basename $1 .vcf.gz) 

zcat ${input}| \
./snpEff/scripts/vcfEffOnePerLine.pl | \
java -jar ./snpEff/SnpSift.jar extractFields - \
CHROM POS REF ALT DP RO AO \
"ANN[*].ALLELE" \
"ANN[*].EFFECT" \
"ANN[*].IMPACT" \
"ANN[*].FEATURE" \
"ANN[*].FEATUREID" \
"ANN[*].GENE" \
"ANN[*].GENEID" \
"ANN[*].BIOTYPE" \
"ANN[*].HGVS_C" \
"ANN[*].HGVS_P" |sed "s/#//g" > ${ID}_multilines_results.tsv




java -jar ./snpEff/SnpSift.jar extractFields -s "_" -e "." ${input} \
CHROM POS REF ALT DP RO AO \
"ANN[*].ALLELE" \
"ANN[*].EFFECT" \
"ANN[*].IMPACT" \
"ANN[*].FEATURE" \
"ANN[*].FEATUREID" \
"ANN[*].GENE" \
"ANN[*].GENEID" \
"ANN[*].BIOTYPE" \
"ANN[*].HGVS_C" \
"ANN[*].HGVS_P" |sed "s/#//g" > ${ID}_single_line_results.tsv
	

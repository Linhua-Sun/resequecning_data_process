#!/bin/bash

## Refer to "http://snpeff.sourceforge.net/SnpSift.html#Extract"

## You can use command line option -s to specify multiple field separator and -e to specify how to represent empty fields. 

## If we prefer to have one effect per line, then we can use the vcfEffOnePerLine.pl provided with SnpEff distribution


zcat SNP_annotated_mix_test.vcf.gz| \
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
"ANN[*].HGVS_P" |sed "s/#//g" > multilines_results.tsv




java -jar ./snpEff/SnpSift.jar extractFields -s "_" -e "." SNP_annotated_mix_test.vcf.gz \
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
"ANN[*].HGVS_P" |sed "s/#//g" > single_line_results.tsv
	

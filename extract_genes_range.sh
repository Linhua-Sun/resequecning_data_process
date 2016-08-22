#!/bin/bash

# Extract the range of the gene from gff files

cat  methylation_genes_list.txt | while read line
do
    echo "File:${line}"
    grep "gene" ../../TAIR10_ANNOTATION/TAIR10_GFF3_genes_transposons.gff|grep "${line}" >> results.txt	
done

mv results.txt methylation_genes_ranges_results.txt

gff2bed < methylation_genes_ranges_results.txt > methylation_genes_ranges_results.bed


bedtools slop -i methylation_genes_ranges_results.bed -g ATH_genome_size.txt -b 3000 > extend_3K_methylation_genes_ranges_results.bed

## create the ATH_genome_size.txt by samtools fadix

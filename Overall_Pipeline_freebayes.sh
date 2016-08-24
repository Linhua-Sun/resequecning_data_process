#!/bin/bash

set -e
set -u 
set -o pipefail

## Linhua Sun
## 2016-08-24 
## Aim: Use to call SNV.
## Usage: sh this_script TTTTT_1.fq.gz

rm -rf *.bam
rm -rf *.vcf.gz*


REFGENOME="/sdd1/users/linhua/QIAN_LAB/ATH_SHORTSTARK/Athaliana_167.fa"
ID=$(basename $1 _1.fq.gz)
SnpSift="/sdd1/users/linhua/QIAN_LAB/PROJECT-2016/resequecning_data_process/snpEff/SnpSift.jar"
snpEff="/sdd1/users/linhua/QIAN_LAB/PROJECT-2016/resequecning_data_process/snpEff/snpEff.jar"

# 1.align
speedseq align -t 10 \
    -o ${ID}_speedseq_aln_out \
    -R "@RG\tID:${ID}\tSM:${ID}\tLB:ILLUMINA" \
    $REFGENOME \
    ${ID}_1.fq.gz \
    ${ID}_2.fq.gz

echo "@@@@@@ Align is finished! @@@@@@"

# 2.variants calling
freebayes -f $REFGENOME -F 0.01 -C 1 --pooled-continuous ${ID}_speedseq_aln_out.bam |bgzip > ${ID}_freq.vcf.gz
tabix -p vcf ${ID}_freq.vcf.gz

echo "@@@@@@ calling is finished! @@@@@@"

# 3.extract useful info
zcat ${ID}_freq.vcf.gz|vcfsnps|vcfbiallelic|vcfintersect -b extend_3K_methylation_genes_ranges_results.bed |bgzip > biallelic_snps_intervaled_${ID}_freq.vcf.gz
tabix -p vcf biallelic_snps_intervaled_${ID}_freq.vcf.gz

echo "@@@@@@ extract is finished! @@@@@@"

# 4.annotation
java -jar ${snpEff} TAIR10.29 biallelic_snps_intervaled_${ID}_freq.vcf.gz | bgzip > annotated_biallelic_snps_intervaled_${ID}_freq.vcf.gz
tabix -p vcf annotated_biallelic_snps_intervaled_${ID}_freq.vcf.gz

echo "@@@@@@ annotation is finished! @@@@@@"

# 5.extract nice fields from VCF file

zcat annotated_biallelic_snps_intervaled_${ID}_freq.vcf.gz| \
/sdd1/users/linhua/QIAN_LAB/PROJECT-2016/resequecning_data_process/snpEff/scripts/vcfEffOnePerLine.pl | \
java -jar ${SnpSift} extractFields - \
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

echo "@@@@@@ extract nice fields is finished! @@@@@@"

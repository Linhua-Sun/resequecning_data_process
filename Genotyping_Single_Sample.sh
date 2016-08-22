#!/bin/bash



REFGENOME="/sdd1/users/linhua/QIAN_LAB/ATH_SHORTSTARK/Athaliana_167.fa"



# mix_fang_1.fq.gz
# mix_fang_2.fq.gz

# 1. Use speedseq align to produce a sorted, duplicate-marked, BAM alignment from paired-end fastq data.

ID=$(basename $1 _1.fq.gz)

speedseq align -t 10 \
    -o ${ID}_speedseq_aln_out \
    -R "@RG\tID:${ID}\tSM:${ID}\tLB:ILLUMINA" \
    $REFGENOME \
    ${ID}_1.fq.gz \
    ${ID}_2.fq.gz
    

# 2. Use speedseq var to call SNVs and indels on a single sample.

# Refer to https://github.com/ekg/freebayes

#Assume a pooled sample with a known number of genome copies. Note that this means that each sample identified in the BAM file is assumed to have 32 genome copies. When running with highh --ploidy settings, it may be required to set --use-best-n-alleles to a low number to limit memory usage.

freebayes -f $REFGENOME -p 8 --use-best-n-alleles 4 --pooled-discrete ${ID}_speedseq_aln_out.bam > ${ID}.vcf

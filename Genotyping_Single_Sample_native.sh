#!/bin/bash



REFGENOME="/sdd1/users/linhua/QIAN_LAB/ATH_SHORTSTARK/Athaliana_167.fa"



# mix_fang_1.fq.gz
# mix_fang_2.fq.gz

# 1. Use speedseq align to produce a sorted, duplicate-marked, BAM alignment from paired-end fastq data.

ID=$(basename $1 _1.fq.gz)

#speedseq align -t 10 \
 #   -o ${ID}_speedseq_aln_out \
  #  -R "@RG\tID:${ID}\tSM:${ID}\tLB:ILLUMINA" \
   # $REFGENOME \
    #${ID}_1.fq.gz \
   # ${ID}_2.fq.gz
    

# 2. Use speedseq var to call SNVs and indels on a single sample.

# Refer to https://github.com/ekg/freebayes

#Assume a pooled sample with a known number of genome copies. Note that this means that each sample identified in the BAM file is assumed to have 32 genome copies. When running with highh --ploidy settings, it may be required to set --use-best-n-alleles to a low number to limit memory usage.

#freebayes -f $REFGENOME -F 0.01 -C 1 --pooled-continuous ${ID}_speedseq_aln_out.bam > ${ID}_freq.vcf


freebayes -f $REFGENOME --haplotype-length 0 --min-alternate-count 1 \
    --min-alternate-fraction 0 --pooled-continuous --report-monomorphic ${ID}_speedseq_aln_out.bam > ${ID}_naive.vcf  


#Naive variant calling: simply annotate observation counts of SNPs and indels:

#freebayes -f ref.fa --haplotype-length 0 --min-alternate-count 1 \
 #   --min-alternate-fraction 0 --pooled-continuous --report-monomorphic >var.vcf





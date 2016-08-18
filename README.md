# Call variants on a single sample

> Refer to https://github.com/hall-lab/speedseq

1. Use speedseq align to produce a sorted, duplicate-marked, BAM alignment from paired-end fastq data.

```
speedseq align \
    -o NA12878 \
    -R "@RG\tID:NA12878.S1\tSM:NA12878\tLB:lib1" \
    human_g1k_v37.fasta \
    NA12878.1.fq.gz \
    NA12878.2.fq.gz
```

2. Use speedseq var to call SNVs and indels on a single sample.

```
speedseq var \
    -o NA12878 \
    -w annotations/ceph18.b37.include.2014-01-15.bed \
    human_g1k_v37.fasta \
    NA12878.bam
```


> Refer to https://github.com/ekg/freebayes

Assume a pooled sample with a known number of genome copies. Note that this means that each sample identified in the BAM file is assumed to have 32 genome copies. When running with highh --ploidy settings, it may be required to set --use-best-n-alleles to a low number to limit memory usage.

`freebayes -f ref.fa -p 32 --use-best-n-alleles 4 --pooled-discrete aln.bam >var.vcf`



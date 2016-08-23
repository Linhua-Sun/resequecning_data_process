#!/bin/bash

zcat mix_fang_freq.vcf.gz|vcfsnps|vcfbiallelic|vcfintersect -b extend_3K_methylation_genes_ranges_results.bed |bgzip > biallelic_snps_mix_intervaled.vcf.gz

tabix -p vcf biallelic_snps_mix_intervaled.vcf.gz

zcat mix_fang_freq.vcf.gz|vcfsnps|vcfintersect -b extend_3K_methylation_genes_ranges_results.bed |bgzip > snps_mix_intervaled.vcf.gz

tabix -p vcf snps_mix_intervaled.vcf.gz


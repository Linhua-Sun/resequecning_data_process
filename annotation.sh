#!/bin/bash
java -jar ./snpEff/snpEff.jar TAIR10.29 snps_mix_intervaled.vcf.gz | bgzip > annotated_snps_mix_intervaled.vcf.gz 

tabix -p vcf annotated_snps_mix_intervaled.vcf.gz 


java -jar ./snpEff/snpEff.jar TAIR10.29 biallelic_snps_mix_intervaled.vcf.gz | bgzip > annotated_biallelic_snps_mix_intervaled.vcf.gz 

tabix -p vcf annotated_biallelic_snps_mix_intervaled.vcf.gz 


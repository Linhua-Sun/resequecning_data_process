#!/usr/bin/env Rscript

VCF_DATA<-read.table("annotated_biallelic_snps_mix_intervaled_table.txt",header = F)
names(VCF_DATA)<-c("QUAL","DP","AO")

VCF_freq<-VCF_DATA$AO/VCF_DATA$DP

## plot the distribution of the log2(QUAL)
plot(density.default(log2(VCF_DATA$QUAL)),main = "Distribution of the log2(QUAL)",lwd=2)
abline(v=log2(20),col="red",lwd=2)
text(log2(20),0.1,labels = "QUAL=20",adj=c(-0.1,0),col = "blue")
abline(v=log2(0.1),col="red",lwd=2)
text(log2(0.1),0.1,labels = "QUAL=0.1",adj=c(1.2,0),col = "blue")
rug(log2(VCF_DATA$QUAL))


## Plot the "Distribution of log10(AO/DP)" in selected genes list region.
plot(density.default(log10(VCF_freq)),main = "",lwd=2,cex.aex=3)
title("Distribution of log10(AO/DP)")
abline(v=log10(0.2),col="red",lwd=2)
text(log10(0.2),4.5,"AO/DP=0.2", col = "blue", adj = c(-0.1, 0))
abline(v=log10(0.01),col="red",lwd=2)
text(log10(0.01),4.5,"AO/DP=0.01", col = "blue", adj = c(-0.1, 0))


## Plot the "Distribution of log2(AO/DP)" in selected genes list region.

plot(density.default(log2(VCF_freq)),main = "",lwd=2,cex.aex=3)
title("Distribution of log2(AO/DP)")

abline(v=log2(0.2),col="red",lwd=2)
text(log2(0.2),1.25,"AO/DP=0.2", col = "blue", adj = c(-0.1, 0))

abline(v=log2(0.01),col="red",lwd=2)
text(log2(0.01),1.25,"AO/DP=0.01", col = "blue", adj = c(-0.1, 0))

## plot the distribution of DP and AO in selected region.
plot(density.default(VCF_DATA$AO),main = "Distribution of AO",lwd=2,cex.aex=3)
plot(density.default(VCF_DATA$DP),main = "Distribution of DP",lwd=2,cex.aex=3)


# In the whole genome scale!

da<-read.table("~/Desktop/Pooled_Seq_Analysis/biallelic_snps_mix_table_QUAL_DP_AO.txt",header=F)

head(da)
names(da)<-c("QUAL","DP","AO")
head(da)
## Plot the dis of QUAL!
plot(density.default(log2(da$QUAL)),main = "Distribution of the log2(QUAL)",lwd=2)
abline(v=log2(20),col="red",lwd=2)
text(log2(20),0.1,labels = "QUAL=20",adj=c(-0.1,0),col = "blue")
abline(v=log2(0.1),col="red",lwd=2)
text(log2(0.1),0.1,labels = "QUAL=0.1",adj=c(1.2,0),col = "blue")
rug(log2(da$QUAL))

## plot the dis of AO/DP
freq<-da$AO/da$DP

plot(density.default(log2(freq)),main = "",lwd=2,cex.aex=3)
title("Distribution of log2(AO/DP)")

abline(v=log2(0.2),col="red",lwd=2)
abline(v=log2(0.01),col="red",lwd=2)

text(log2(0.2),1.25,"AO/DP=0.2", col = "blue", adj = c(-0.1, 0))

text(log2(0.01),1.25,"AO/DP=0.01", col = "blue", adj = c(-0.1, 0))















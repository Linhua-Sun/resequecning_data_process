#!/lustre1/deng_pkuhpc/slh_RICE_data/SOFTWARE/R-3.2.5/bin/Rscript

Args <- commandArgs()

START <- Args[6]
STOP <- Args[7]
FILE<-Args[8]

print(START)
print(STOP)
print(FILE)

library(PopGenome)

chr <- tolower(strsplit(FILE,split = "_")[[1]][1])

print(chr)

Test <-
  readVCF(
    FILE,
    numcols = 10000,
    tid = chr,
    from = START,
    to = STOP,
    approx = FALSE,
    out = "",
    parallel = FALSE,
    gffpath = FALSE,
    include.unknown = TRUE
  )


# sliding windows

Test.slide <-
  sliding.window.transform(Test,
                           width = 300,
                           jump = 100,
                           type = 2)

Test.slide <- neutrality.stats(Test.slide)

Tajima.D <- get.neutrality(Test.slide)[[1]][, 1]
Fu.Li.F <- get.neutrality(Test.slide)[[1]][, 4]
Fu.Li.D <- get.neutrality(Test.slide)[[1]][, 5]
theta<-Test.slide@theta_Watterson

Test.slide <- diversity.stats(Test.slide)
nuc.diversity.within <- get.diversity(Test.slide)[[1]][, 1]
pi <- nuc.diversity.within / (Test.slide@n.sites[1])

contents <- paste(Test.slide@region.names, Tajima.D, Fu.Li.F, Fu.Li.D, pi,theta)

filename <- paste(START,"_",STOP,"_",FILE,"_PopGenome_stat.txt",sep="")

write(contents, file = filename)

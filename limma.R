#We used the same sorted .bam files from Hisat2 and samtools in Linux as our input.
library(Rsamtools)
library(GenomicFeatures)
library(GenomicAlignments)
library(dplyr)
library(limma)
library(edgeR)
bamfiles = BamFileList(dir(pattern = ".bam$"))
txdb <- makeTxDbFromGFF("Homo_sapiens.GRCh38.92.chr.gtf",format="gtf")
(ebg<-exonsBy(txdb,by="gene"))

se1<-summarizeOverlaps(features=ebg,reads=bamfiles,
                      mode="Union",
                      singleEnd=T,
                      ignore.strand=T
                      )
counts=assay(se1)
head(counts)

dge<-DGEList(counts)
ss_alpha<-read.table("alpha.tsv",header=T)
ss_alpha

isexpr<-rowSums(dge$counts>12)>=6
sum(isexpr)/nrow(dge)

dge<-dge[isexpr,,keep.lib.sizes=F]
dim(dge)

dge<-calcNormFactors(dge)
design<-model.matrix(~condition,data=ss_alpha)
v<-voom(dge,design)
fit<-lmFit(v,design)
fit2<-eBayes(fit)
colnames(fit2)

R_ND_vs_T2D=topTable(fit2,coef="conditionT2D",number=nrow(dge$counts))
adjusted=R_ND_vs_T2D[R_ND_vs_T2D$adj.P.Val<=0.05,]

sigGenes=adjusted[adjusted$P.Value<=0.05,]
sigGenes=sigGenes[abs(sigGenes$logFC)>=1,]
sigGenes

#Search ID in ensembl database, we have the 7 genes: TSG101, CPNE8, VMP1, DFFA, USP2, SLC35A4, POGLUT1

library(ggplot2)
plot_data<-dge$counts[rownames(sigGenes[1:3,]),]
names<-c("TSG101_non","TSG101_T2D", "CPNE8_non","CPNE8_T2D"," VMP1_non","VMP1_T2D")
mean_data<-cbind(rowMeans(plot_data[,1:6]),rowMeans(plot_data[,7:12]))
means<-as.numeric(mean_data)
sem <- function(x){sqrt(var(x)/length(x))}
sem_data<-c(sem(plot_data[1,1:6]),sem(plot_data[2,1:6]),sem(plot_data[3,1:6]),sem(plot_data[1,7:12]),sem(plot_data[2,7:12]),sem(plot_data[3,7:12]))
plotTop <- max(means+sem_data*2)
barCenters<-barplot(means,names.arg = names,col = c("lightblue","red"),las=1,ylim = c(0,plotTop))
segments(barCenters,means-sem_data*2,barCenters,means+sem_data*2,lwd = 1.5)
arrows(barCenters,means-sem_data*2,barCenters,means+sem_data*2,lwd = 1.5,angle = 90,code = 3)

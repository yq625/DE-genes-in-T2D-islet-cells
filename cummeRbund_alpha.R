#source("https://bioconductor.org/biocLite.R")
#biocLite("cummeRbund")
library("cummeRbund")
##alpha cell
#Creat a CummeRbund database for alpha cells
cuff_alpha <- readCufflinks('diff_alpha')
cuff_alpha

#Plot the distribution of expression levels for each sample of alpha cells
csDensity(genes(cuff_alpha))

#Compare the expression of each gene in two conditions
csScatter(genes(cuff_alpha),"q1","q2")

#Create a volcano plot
csVolcano(genes(cuff_alpha),"q1","q2",alpha=0.05,showSignificant=TRUE)

gene_diff_data<-diffData(genes(cuff_alpha))
sig_gene_data <- subset(gene_diff_data,(significant=='yes'))
nrow(sig_gene_data)

tss_diff<-diffData(TSS(cuff_alpha),'q1',"q2")
sig_tss<-subset(tss_diff,(significant=="yes"))
nrow(sig_tss)

cds_diff<-diffData(CDS(cuff_alpha),'q1',"q2")
sig_cds<-subset(cds_diff,(significant=="yes"))
nrow(sig_cds)

promoter_diff_data <- distValues(promoters(cuff_alpha))
sig_promoter_data <- subset(promoter_diff_data, (significant == 'yes'))
nrow(sig_promoter_data)

splicing_diff_data <- distValues(splicing(cuff_alpha))
sig_splicing_data <- subset(splicing_diff_data, (significant == 'yes'))
nrow(sig_splicing_data)

isoform_diff_data <- diffData(isoforms(cuff_alpha),"q1","q2")
sig_isoform_data <- subset(isoform_diff_data,(significant == 'yes'))
nrow(sig_isoform_data)

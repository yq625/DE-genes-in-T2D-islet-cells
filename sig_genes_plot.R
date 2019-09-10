
##Polt expression levels for genes of interest
#alpha
mysiggene<-getGene(cuff_alpha,"XLOC_000324")
expressionBarplot(mysiggene,logMode = T)
mysiggene_2<-getGene(cuff_alpha,"XLOC_001120")
expressionBarplot(mysiggene_2,logMode = T)
mysiggene_3<-getGene(cuff_alpha,"XLOC_001168")
expressionBarplot(mysiggene_3,logMode = T)

#beta
mysiggene_beta<-getGene(cuff_beta,"XLOC_000897")
mysiggene_beta_2<-getGene(cuff_beta,"XLOC_003096")
mysiggene_beta_3<-getGene(cuff_beta,"XLOC_003517")
expressionBarplot(mysiggene_beta,logMode = T)
expressionBarplot(mysiggene_beta_2,logMode = T)
expressionBarplot(mysiggene_beta_3,logMode = T)
```
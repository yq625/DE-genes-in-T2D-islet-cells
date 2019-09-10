#Reads Mapping of Samples of α Cells from People without Type 2 Diabetes
cd $SCRATCH 
cd final-ag/alpha 
module load hisat2/intel/2.0.5 
for file in non_T2D/*.trimmed; 
do 
outfile=${file}".sam" 
hisat2 --threads 1 \
-x \
/genomics/genomes/Public/Vertebrate_mammalian/Homo_sapiens/Ensembl/GRCh38.p10/grch38_hisat_ind ex/genome \
-U $file \
-S $outfile \
--dta-cufflinks 
done

#this process provides giles can be recognized by cufflinks

#Then we used the score of 25 to control the quality of our results, and converted them to the .bam files as well as sorted them
#Quality Control and Obtaining .BAM Files of α Cells from People without Type 2 Diabetes:
module load samtools/intel/1.6 
cd $SCRATCH 
cd final-ag/alpha 
for file in non_T2D/*.sam;
do
outfile=${file}".sorted.bam" 
samtools view -bSq 25 $file | samtools sort -o $outfile 
done

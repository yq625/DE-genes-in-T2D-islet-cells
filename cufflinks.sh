#We used the soted .bam files as out inputs and Cufflinks output .gtf files containing assembled isoforms by using a .gtf file of GRCh38 as the reference annotation

#Cufflinks of .BAM Files of α Cells from People without Type 2 Diabetes:
module load cufflinks/2.2.1 
cd $SCRATCH 
cd final-ag/alpha 
for file in non_T2D/*.bam; 
do 
outfile=${file}".gtf" 
cufflinks -G \
/genomics/genomes/Public/Vertebrate_mammalian/Homo_sapiens/Ensembl/GRCh38.p10/Homo_sapiens.GRC h38.88.gtf \ 
-o $outfile $file 
done

#Cuffmerge (optional)
#Cuffmerge merges together the input assemblies.
#Codes for Cuffmerge of α Cells
cuffmerge \ 
-g \
/genomics/genomes/Public/Vertebrate_mammalian/Homo_sapiens/Ensembl/GRCh38.p10/Homo_sapiens.GRC h38.88.gtf \ 
-s \ 
/genomics/genomes/Public/Vertebrate_mammalian/Homo_sapiens/Ensembl/GRCh38.p10/Homo_sapiens.GRC h38.dna.toplevel.fa \ 
-o merged_alpha alpha_assemblies.txt

#Cuffdiff is a software that we can use to find significant changes in RNA expression, splicing and promoter use.
#Codes for Cuffdiff of α Cells
cuffdiff -o diff_alpha -p 16 \ 
-b \ 
/genomics/genomes/Public/Vertebrate_mammalian/Homo_sapiens/Ensembl/GRCh38.p10/ Homo_sapiens.GR Ch38.dna.toplevel.fa \ 
-u \ 
merged_alpha/merged.gtf \ 
non_T2D/SRR3541510_sorted.bam,non_T2D/SRR3541566_sorted.bam,non_T2D/SRR3541570_sorted.bam,non_ T2D/SRR3541579_sorted.bam,non_T2D/SRR3541605_sorted.bam,non_T2D/SRR3541644_sorted.bam,non_T2D/ SRR3541650_sorted.bam,non_T2D/SRR3541686_sorted.bam,non_T2D/SRR3541714_sorted.bam,non_T2D/SRR3 541733_sorted.bam,non_T2D/SRR3541781_sorted.bam,non_T2D/SRR3541872_sorted.bam \ 
T2D/SRR3542251_sorted.bam,T2D/SRR3542272_sorted.bam,T2D/SRR3542279_sorted.bam,T2D/SRR3542295_s orted.bam,T2D/SRR3542301_sorted.bam,T2D/SRR3542315_sorted.bam,T2D/SRR3542332_sorted.bam,T2D/SR R3542346_sorted.bam,T2D/SRR3542527_sorted.bam,T2D/SRR3542572_sorted.bam,T2D/SRR3542687_sorted. bam,T2D/SRR3542723_sorted.bam

#We got an output file containing all the results of analysis.
#After obtaining the files with all the analysis data, we used CommeRbund in R to plot the scatter plot, volcano plot and so on to visualize our results. We also used this package to find out some significant genes between people with and without type 2 diabetes. (Codes are shown in CummeRbund_alpha.R and sig_genes_plot.R)

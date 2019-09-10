#Obtaining Samples of α Cells from People without Type 2 Diabetes
module load sra-tools/intel/2.8.1-2
cd $SCRATH 
cd final/non_diabetic/non_T2D_fastq 
fastq-dump \
SRR3541510 SRR3541566 SRR3541570 SRR3541579 SRR3541605 SRR3541644 SRR3541650 SRR3541686 SRR3541714 SRR3541733 SRR3541781 SRR3541872

#Trimming Samples of α Cells from People without Type 2 Diabetes
module purge
module load trimmomatic/0.36
for file in non_diabetic/non_T2D_fastq/*.fastq; 
do 
outfile=${file}".trimmed"
java -jar $TRIMMOMATIC_JAR SE \
-threads 8 \
$file \
$outfile \
ILLUMINACLIP:$TRIMMOMATIC_JAR/adapters/TrueSeq3-SE:2:30:10 \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 
done

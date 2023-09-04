##### Littorina stairway plot 
##### written by Arka Pal
##### last updated: May 24, 2022

cat groups.txt | sed 's/_A\t/\t/' | head -108 | sort -k 2 > pop_sorted.txt
# make each population list
cat pop_sorted.txt | grep arcana | cut -f 1 > sample_arcana.list
cat pop_sorted.txt | grep compressa | cut -f 1 > sample_compressa.list
cat pop_sorted.txt | grep Atlantic | cut -f 1 > sample_NorthAtlantic.list
cat pop_sorted.txt | grep Spain | cut -f 1 > sample_spain.list

# subset vcf files by each population.

#arcana
sbatch scripts/job-subvcf.slurm snail_VCFs/PHASED_all_sites_108_littorina.vcf.gz sample_info/sample_arcana.list pop_VCFs/arcana_all.vcf.gz
sbatch scripts/job-trimvcf.slurm pop_VCFs/arcana_all.vcf.gz pop_VCFs/arcana_variants.vcf.gz

#compressa
sbatch scripts/job-subvcf.slurm snail_VCFs/PHASED_all_sites_108_littorina.vcf.gz sample_info/sample_compressa.list pop_VCFs/compressa_all.vcf.gz
batch scripts/job-trimvcf.slurm pop_VCFs/compressa_all.vcf.gz pop_VCFs/compressa_variants.vcf.gz

#northatlantic
sbatch scripts/job-subvcf.slurm snail_VCFs/PHASED_all_sites_108_littorina.vcf.gz sample_info/sample_NorthAtlantic.list pop_VCFs/northatlantic_all.vcf.gz
sbatch scripts/job-trimvcf.slurm pop_VCFs/northatlantic_all.vcf.gz pop_VCFs/northatlantic_variants.vcf.gz

#spain (repeat for each population)
sbatch scripts/job-subvcf.slurm snail_VCFs/PHASED_all_sites_108_littorina.vcf.gz sample_info/sample_spain.list pop_VCFs/spain_all.vcf.gz
sbatch scripts/job-trimvcf.slurm pop_VCFs/spain_all.vcf.gz pop_VCFs/spain_variants.vcf.gz
#### Preprocessing for stairwayplots
#### written by Arka Pal
#### last updated 
Sys.time()
# [1] "2021-11-22 15:16:33 CET"


### R packages 
#lapply(c("devtools","vcfR"), install.packages, character.only = T)
lapply(c("devtools","vcfR"), require, character.only = T)

##set working directory
setwd("/fs3/home/apal/Project-Littorina-stairwayplot")

##read vcf file
vcf_data <- read.vcfR("full_Q40_maxmiss1_mac1_PHASED.vcf")

##read population info file
pop <- read.table("groups.txt", stringsAsFactors = F)

##reoder the list of individuals to match the order in population info text file. 
vcf_data@gt <- vcf_data@gt[,c("FORMAT",pop[,1])] 

##check the vcf file
# vcf_data@meta
# vcf_data@fix
# vcf_data@gt

##write the modified vcf file
write.vcf(vcf_data, file = "full_ordered.vcf")

##read functions from guthib repo: vcf2sfs
## https://github.com/shenglin-liu/vcf2sfs
source_url("https://github.com/shenglin-liu/vcf2sfs/raw/master/vcf2sfs.r")
##ℹ SHA-1 hash of file is c5459a27126699674032c7c5ee8f1609d0a21796
##checking if functions are loaded correctly
c("vcf2gt","gt2sfs.raw") %in% ls()

##read vcf file and pop info file to create a gt object
vcf_ordered <- "full_ordered.vcf"
popmap <- "groups.txt"
gt <- vcf2gt(vcf_ordered, popmap) #lists all populations and genotypes. 

##manipulating gt object
# str(gt)
##levels(as.factor(gt$popmap)) 
# [1] "arcana"        "compressa"     "NorthAtlantic" "Spain"  
viewMissing(gt) #no data missing
samSize(gt)
# arcana  compressa NorthAtlantic Spain 
# 24      4         68            12 

save(gt, file = "full_genotypes_pop.gt") # save for later access

## choosing populations directly from the genotypes
# gt_arcana <- choose.pops(gt,"arcana")
# gt_compressa <- choose.pops(gt,"compressa")
# gt_northatlantic <- choose.pops(gt,"NorthAtlantic")
# gt_spain <- choose.pops(gt,"Spain")

## making unfolded site-frequency spectrum
sfs_arcana <- gt2sfs.raw(gt,"arcana")
sfs_compressa <- gt2sfs.raw(gt,"compressa")
sfs_northatlantic <- gt2sfs.raw(gt,"NorthAtlantic")
sfs_spain <- gt2sfs.raw(gt,"Spain")

## making folded site-frequency spectrum
sfs_folded_arcana <- fold.sfs(sfs_arcana)
sfs_folded_compressa <- fold.sfs(sfs_compressa)
sfs_folded_northatlantic <- fold.sfs(sfs_northatlantic)
sfs_folded_spain <- fold.sfs(sfs_spain)



#### For reproducibility ----
sessionInfo()
# R version 4.0.3 (2020-10-10)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Big Sur 10.16
# 
# Matrix products: default
# LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] devtools_2.4.2 usethis_2.1.3  vcfR_1.12.0   
# 
# loaded via a namespace (and not attached):
#   [1] pinfsc50_1.2.0    Rcpp_1.0.5        pillar_1.6.1      compiler_4.0.3    remotes_2.4.1     prettyunits_1.1.1
# [7] tools_4.0.3       digest_0.6.25     testthat_3.1.0    pkgbuild_1.2.0    pkgload_1.2.3     tibble_3.0.3     
# [13] memoise_2.0.0     lifecycle_1.0.0   nlme_3.1-149      lattice_0.20-41   viridisLite_0.3.0 mgcv_1.8-33      
# [19] pkgconfig_2.0.3   rlang_0.4.11      Matrix_1.2-18     rstudioapi_0.13   cli_3.1.0         curl_4.3         
# [25] yaml_2.2.1        parallel_4.0.3    fastmap_1.0.1     httr_1.4.2        withr_2.4.2       cluster_2.1.0    
# [31] vctrs_0.3.8       desc_1.4.0        fs_1.5.0          rprojroot_1.3-2   grid_4.0.3        glue_1.4.1       
# [37] R6_2.4.1          processx_3.5.2    fansi_0.4.1       sessioninfo_1.2.1 purrr_0.3.4       callr_3.7.0      
# [43] magrittr_2.0.1    backports_1.1.8   ps_1.6.0          ellipsis_0.3.2    MASS_7.3-53       splines_4.0.3    
# [49] memuse_4.2-1      permute_0.9-5     ape_5.4           utf8_1.1.4        cachem_1.0.6      crayon_1.4.1     
# [55] vegan_2.5-7      

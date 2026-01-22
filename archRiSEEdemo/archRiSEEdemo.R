# if needed, or to update:
#
# BiocManager::install("trichelab/archRiSEE")
#
library(archRiSEE)
packageVersion("archRiSEE")
# [1] '0.2.6'

(ewsSub <- readRDS("ewsSub.rds"))
# ...time passes...
#
# class: SingleCellExperiment 
# dim: 6062095 6000 
# metadata(2): NMF NMF_UMAP
# assays(2): TileMatrix logcounts
# rownames(6062095): chr1:0-499 chr1:500-999 ... chrX:156040000-156040499
#   chrX:156040500-156040999
# rowData names(33): idx assay ... nmf29 nmf30
# colnames(6000): CHLA10_Bulk_Edit_JAAM7_WHLT4#AAAGATGTCCTATCAT-1
#   CHLA10_Bulk_Edit_JAAM7_WHLT4#AAAGGATAGTCAGCCC-1 ...
#   TC71_Subclone_Preimplantation_JAAM10#TTAACGGGTTTGAAGA-1
#   TC71_Subclone_Preimplantation_JAAM10#TTCGATTCATGGCCCA-1
# colData names(61): Sample TSSEnrichment ... nmf29 nmf30
# reducedDimNames(4): UMAP LSI NMF NMF_UMAP
# mainExpName: FragmentCounts
# altExpNames(3): GeneScores mtVariants CNA
# 

# start igvR
library(igvR)
igv <- igvR()
setGenome(igv, "hg38")

# navigate to some gene you care about...
showGenomicRegion(igv, "NKX2-2") 

# add some NMF tracks from the EWS mtscATAC model 
for (n in c("nmf1", "nmf3", "nmf5", "nmf10")) addIgvTrack(ewsSub, n, igv)
# takes a second to transcribe each weight track onto igv.js
# ...
# Try zooming out a bit to really see the differences around NKX2-2 ;-) 
#
# igv.js can run in the background while iSEE runs in the foreground 


# need to play with `mirai` to make igvR and iSEE tasks non-blocking :-/ 
#
iSEEarchR(ewsSub)
#
# Adding LSI1 as colData(SCE)$LSI1
# ...
# Adding nmf1 as colData(SCE)$NMF1
# ...
# Loading required package: shiny
# 
# Listening on http://127.0.0.1:7657
# Warning in .nextMethod(se = se) :
#   rowRanges (GRanges) detected - copying values to rowData
#

# Suggested exercises:
# 
# * modify the middle box to model and facet MT variants by condition
# * use dynamic variable selection so middle/right boxes "listen" to UMAP (left)
# * poke around at subclusters of cells or mask off entire cell lines to explore
#
# (Ctrl-C will stop the iSEE task and hand control back to R)
#

# things I'd like to add:
#
# * per-pseudobulk or per-cluster CNA tracks (like with the nmf tracks above)
# * on-the-fly reclustering or per-cluster views in iSEE (not unlike item 1) 
# * better handling of MT variant associations with other phenomena 
#

# Convert this into a quarto document so I can dump it onto trichelab.github.io
library(quartify)
rtoqmd("archRiSEEdemo.R", "archRiSEEdemo.qmd") 
# ✔ Quarto markdown file created: archRiSEEdemo.qmd
# Rendering Quarto document to HTML...
# ✔ HTML file created: archRiSEEdemo.html

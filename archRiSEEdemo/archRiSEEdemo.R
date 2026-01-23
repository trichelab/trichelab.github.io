# if needed, or to update:
#
# BiocManager::install("trichelab/archRiSEE")
#
library(archRiSEE)

date()
# [1] "Thu Jan 22 18:37:14 2026"

packageVersion("archRiSEE")
# [1] '0.2.22'

system.time(ewsSub <- readRDS("ewsSub.rds"))
#    user  system elapsed 
# 145.217   4.084 149.362 

show(ewsSub)
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

# start igvR
library(igvR)
igv <- igvR()
setGenome(igv, "hg38")

# add chromatin state maps for a few Ewing sarcoma patients to spruce it up
library(rtracklayer) 
displayTrack(igv,
             GRangesAnnotationTrack("EWS119_chromHMM", 
                                    displayMode="COLLAPSED", 
                                    import("EWS119.chromHMM.hg38.bed.gz")))
displayTrack(igv,
             GRangesAnnotationTrack("EWS120_chromHMM",
                                    displayMode="COLLAPSED", 
                                    import("EWS120.chromHMM.hg38.bed.gz")))
displayTrack(igv,
             GRangesAnnotationTrack("EWS121_chromHMM",
                                    displayMode="COLLAPSED", 
                                    import("EWS121.chromHMM.hg38.bed.gz")))

# check and see if these lifted-over chromatin state maps are complete crap
showGenomicRegion(igv, "CD99") 

# actually this is a bit better. they are not complete and total garbage
showGenomicRegion(igv, "chrX:2,689,731-2,696,233") 

# add some NMF tracks from the EWS mtscATAC model 
for (n in c("nmf1", "nmf3", "nmf5", "nmf10")) addIgvTrack(ewsSub, n, igv)

# navigate to some gene you care about...
showGenomicRegion(igv, "NKX2-2") 
# Try zooming out a bit to really see the differences around NKX2-2 ;-) 
# igv.js can run in the background while iSEE runs in the foreground 

# compare with CD99 from previously 
showGenomicRegion(igv, "chrX:2,689,731-2,696,233")
# notice that compared to NKX2-2 or similar,
# there's not much information to distinguish the NMF factors around CD99
# which is kind of expected given that it's expressed in most EWS cells

# look at some variants with a cutoff (can also just look at raw freqs)
grouping <- c("cellLine", "edited")
loci <- c(G11922A="11922G>A",
          C11925T="11925C>T",
          C11946T="11946C>T")
cutoff <- 0.05 # five percent
res <- variantFreq(ewsSub, grouping=grouping, loci=loci, cutoff=cutoff) 
names(res)[seq_along(loci)] <- names(loci) # rename to avoid annoyances

with(res, xtabs(G11922A ~ edited + cellLine))
# |            | *CHLA10* | *TC32* | *TC71* |
# |-----------:|---------:|-------:|-------:|
# |   *edited* |     1086 |   1040 |   1335 |
# | *unedited* |        1 |      0 |     15 |

with(res, xtabs(C11925T ~ edited + cellLine))
# |            | *CHLA10* | *TC32* | *TC71* |
# |-----------:|---------:|-------:|-------:|
# |   *edited* |        3 |    414 |    846 |
# | *unedited* |        0 |      1 |      1 |

with(res, xtabs(C11946T ~ edited + cellLine))
# |            | *CHLA10* | *TC32* | *TC71* |
# |-----------:|---------:|-------:|-------:|
# |   *edited* |        0 |      0 |      2 |
# | *unedited* |        0 |      2 |      0 |

# toss these in to play with them in iSEE (e.g. facet the middle panel)
ewsSub$G11922A <- assay(altExp(ewsSub, "mtVariants"))['11922G>A', ]
ewsSub$C11925T <- assay(altExp(ewsSub, "mtVariants"))['11925C>T', ]
ewsSub$C11946T <- assay(altExp(ewsSub, "mtVariants"))['11946C>T', ]
# if this looks suspiciously like `res`, that's because it is

iSEEarchR(ewsSub)
# Listening on http://127.0.0.1:7657

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
#

# Convert this into a quarto document so I can dump it onto trichelab.github.io
library(quartify)
rtoqmd("archRiSEEdemo.R", "archRiSEEdemo.qmd", 
       title="archRiSEE demo", author="Tim Triche, Jr.")
# ✔ Quarto markdown file created: archRiSEEdemo.qmd
# Rendering Quarto document to HTML...
# ✔ HTML file created: archRiSEEdemo.html

---
layout: post
title:  "Welcome to the Triche Lab!"
date:   2020-04-27 11:36:38 -0400
categories: jekyll update
---

# Getting Started!

	First things first, if you're doing dry work, you'll need a GitHub ID.
  
    set up a GitHub account, if you don't already have one

If you are new to GitHub create an account [here](https://github.com/join)

Once/if you have an account, join the [Triche Lab organization](https://github.com/trichelab/) on GitHub

    Fork the repository trichelab.github.io (these pages) to your account, 
    you can do this by opening a repository and clicking on the "Fork" tab
    on the right hand side of the page, this will allow you to access and 
    edit a repository (I don't care what you edit, just do something useful), 
    `git add`, `git commit`, `git push`, and open a pull request against 
    the parent (trichelab) repository to merge the changes (or not). 

    Find someone to code review the merge.  Congratulations, you're a 10x 
    dry lab developer!  (or not... but at least you passed 'hello world') 
	
### Notes: 
    Please don't get us sued if you can help it. 

    What all else can we drag in?  Surely there's rather a lot.
    
    What kind of computer/OS should I use for dry lab stuff?
	
    That all depends -- if you're going to build R packages, just use Linux.
   
    The Linux Subsystem for Windows version 2 (LS2) can be enabled on Windows.
 
    If you're a normal human being, you can use Mac OS X, but it'll be rough if
    you later decide to maintain a Bioconductor package (looks good on your CV):

>
The lack of Mac binary packages for R-devel on CRAN together with the
high turnover of Mac OS versions are a major PITA and the reason why
when R/Bioconductor newbies ask me what OS I recommend for package
development I always say Linux, without hesitation. Unless they want to
suffer ;-)

[Herve Pages](https://stat.ethz.ch/pipermail/bioc-devel/2020-January/016010.html) Herve Pages

    Whatever you use, put a lot of RAM in it, and execute your long-running 
    jobs on HPC or AWS so that you don't lock up your own machine and miss 
    deadlines, panic, etc.  Local machines are for exploration and development, 
    ONLY, and if you don't have multiple copies/backups of code/data/documents
    (ideally version controlled), it must not be very important.  

    The best way I know of to ensure that code, experiments, and manuscripts 
    (work products) are durable and reproducible is to automate them, and then 
    set up continuous integration (for code products) so their reproducibility 
    is either continually verified or an alert raised. We did this for Arkas, 
    Bioconductor does it for packages, Casey does it for analyses, and Travis 
    or GitHub Actions can do it for your code/analyses. Get used to it; it
    sucks to set up but it's a lot better than trying to recreate everything 
    from scratch when a reviewer squawks 18 months from now.


# Additional Resources

	If you are working in the dry lab at all you will be working with R, if you have
	not worked with R, and/or have no coding experience, the following links may help
	get you started,

[Download R](https://repo.miserver.it.umich.edu/cran/)

[Download the free version of RStudio](https://rstudio.com/products/rstudio/download/#download)

[Free Basic R Tutorials](https://www.udemy.com/course/r-basics/)

	There is also a high chance that you will be working with command line, 
	"5 – FILE AND DIRECTORY COMMANDS" is a good starting point.

	
[Linux command line cheat sheet](https://www.linuxtrainingacademy.com/linux-commands-cheat-sheet/)

	Equally likely is the probability that you will be working with RNA-seq techniques,
	below are some resources that will give background information on dry lab and wet 
	lab techniques

[Current best practices in single-cell RNA-seq analysis: a tutorial](https://www.embopress.org/doi/full/10.15252/msb.20188746)

[Benchmarking Single-Cell RNA Sequencing Protocols for Cell Atlas Projects](https://www.nature.com/articles/s41587-020-0469-4)

[Orchestrating Single-Cell Analysis with Bioconductor](https://osca.bioconductor.org)

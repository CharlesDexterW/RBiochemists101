# this is the link to the data

link <- "https://github.com/brennanpincardiff/RforBiochemists/raw/master/R_for_Biochemists_101/data/mcp.M114.044479-2.xls"


# the download.file() function downloads and saves the file with the name given

download.file(url=link, destfile="file.xls", mode="wb")
install.packages("readxl")
install.packages("tidyverse")
library(readxl)


# then we can open the file and extract the data using the read_excel() function. 

dataxl <- read_excel("file.xls", col_names=TRUE)

View(dataxl)
#Now try to extract the columns we need check (and change) column names. 
#Add your threshold. Draw your plot. 

colnames(dataxl) <- c("Prot_Names", "Acc_No", "M1", "M2", "M3", "M4", "M5", "M6",
                      "M7", "M8", "M9", "UM1", "UM2", "UM3", "UM4", "UM5", "UM6",
                      "UM7", "UM8", "UM9", "N", "Log2_Fold_Change", "Fold_Change", "P_Value")

some_drug <- select(dataxl, Prot_Names, Log2_Fold_Change, P_Value)

#the select function doesn't allow to have spaces among column names unless you use quotation marks.
# that's why I stupidly changed each column name before selecting the columns.

ggplot(data=some_drug, 
       aes(x=Log2_Fold_Change, 
           y =-log10(P_Value))) +
  geom_point() 

View(some_drug)
some_drug$threshold = as.factor(some_drug$P_Value < 0.01)
ggplot(some_drug, 
       aes(Log2_Fold_Change, -log10(P_Value), 
           colour=threshold)) +
  geom_point(alpha=1, size=1.75)

volc_d <- ggplot(some_drug, 
                 aes(Log2_Fold_Change, -log10(P_Value), 
                     colour=threshold)) +
  geom_point(alpha=1, size=1.75)

liv_volc <- volc_d %+% some_drug
liv_volc
liv_volc <- liv_volc  + 
  labs(title = "CLL Proteomics Data from Liverpool",
       subtitle = "Comparing two patient cohorts (unmutated vs mutated)
source: Eagle et al (2015) Mol Cell Proteomics, 14, 933-945")
liv_volc
liv_volc_2 <- ggplot(data=some_drug, 
                     aes(x=Log2_Fold_Change, y =-log10(P_Value), 
                         colour=threshold)) +
  geom_point(alpha=0.4, size=1.75) +
  xlim(c(-6, 6)) +
  labs(x = "log2 fold change",         # label x-axis
       y = "-log10 P-Value",  # label y-axis
       title = "CLL Proteomics Data from Liverpool",
       subtitle = "Comparing two patient cohorts (unmutated vs mutated)
source: Eagle et al (2015) Mol Cell Proteomics, 14, 933-945") +
  theme_bw() +
  theme(legend.position="none")
liv_volc_2
# With the data from the first exercise and the plot from the second, try 
#labelling some of the points. I recommend a fold change cut off of 1.5 and a 
#p value of <0.001.
#You will need to do absolute Fold Change using the abs() function and then use 
#the filter() function as before.

some_drug$absFC <- abs(some_drug$Log2_Fold_Change)
some_druglabel <- filter(some_drug, absFC>1.5, P_Value <0.001)
# add points and colour them with Color Brewer pallette
library(RColorBrewer)

our_palette <- brewer.pal(nrow(some_druglabel), "Set1")
liv_volc +  geom_point (data = some_druglabel,
                        aes(x = Log2_Fold_Change, 
                            y = -log10(P_Value)), 
                        colour = our_palette) +
  geom_text(data = some_druglabel, 
            aes(x = Log2_Fold_Change, 
                y = -log10(P_Value), 
                label = Prot_Names), 
            colour = our_palette,
            vjust = 0, nudge_y = 0.2)

#Using these data, try assembling a data.frame and plot the data yourself before 
#you turn the page...

exp <- c("WT", "WT", "WT", "WT", "WT", "WT", "WT", "WT", 
         "WT", "WT", "mut", "mut", "mut", "mut", "mut", 
         "mut", "mut", "mut", "mut", "mut")

Sub <- c(0, 1, 2, 4, 8, 12, 16, 20, 30, 40, 0, 1, 2, 4, 8, 
         12, 16, 20, 30, 40)

vel <- c(0, 15.7, 29.4, 45.6, 62.6, 75.8, 69.9, 75.3, 89.6, 
         86.8, 0, 2.2, 5.3, 9.0, 15.6, 20.8, 25.4, 26.6, 
         32.4, 33.3)
# step 1. assemble data in data.frame

Enzyme_Data <- as.data.frame(exp)

Enzyme_Data$Sub <- Sub
Enzyme_Data$vel <- vel

View(Enzyme_Data)

#Step 2 build a plot with it.

ggplot(data = Enzyme_Data, 
       aes(x = Sub,
           y = vel,
           colour = exp)) + 
      geom_point()

#step 3 make an item using previous graph

Enzyme_plot <- ggplot(data = Enzyme_Data, 
                      aes(x = Sub,
                          y = vel,
                          colour = exp)) + 
  geom_point()
#playing with themes

Enzyme_plot + theme_bw()
Enzyme_plot + theme_minimal()
Enzyme_plot + theme_light()

#adding facet

Enzyme_plot + facet_wrap(~exp)
Split_plot <- Enzyme_plot + theme_light() + facet_wrap(~exp)
Split_plot

# adding geom_smooth lines.

enzyme_plot_lines <- Enzyme_plot +
    geom_smooth(data = subset(Enzyme_Data, Enz = "WT"),
                method = "nls",
                method.args = list(formula = y ~ Vmax * x/(Km + x), # NOTE: values belonging to Vmax and Km are just rough estimates.
                                   start = list(Vmax = 70, Km = 10)),
                se = F, linewidth = 1) +
  geom_smooth(data = subset(Enzyme_Data, Enz = "mut"),
              method = "nls",
              method.args = list(formula = y ~ Vmax * x/(Km + x),
                                 start = list(Vmax = 70, Km = 10)),
              se = F, linewidth = 1) + theme_light()


enzyme_plot_lines                            
enzyme_plot_lines + facet_wrap(~ exp)

#using Exercise_3.R environment lets make subsets
MMcurve <- formula(vel~Vmax*Sub/(Km+Sub))

WT <- subset(Enzyme_Data, exp == "WT")
fitWT <- nls(MMcurve, WT, start = list(Vmax=75, Km=10))

summary(fitWT)

Vmax_WT <- summary(fitWT)$coefficients[1]
Km_WT <- summary(fitWT)$coefficients[2]
paste("Vmax", round(Vmax_WT, 1))
paste("Km", round(Km_WT, 2))

mut <- subset(Enzyme_Data, exp == "mut")
fitmut <- nls(MMcurve, mut, start = list(Vmax=25, Km=15))

summary(fitmut)

Vmax_mut <- summary(fitmut)$coefficients[1]
Km_mut <- summary(fitmut)$coefficients[2]
paste("Vmax", round(Vmax_mut, 1))
paste("Km", round(Km_mut, 2))

# Using annotation() function on graph 
#Answer

Chart <- enzyme_plot_lines + 
  annotate(geom="text", x= 30, y=25, label="km") +
  annotate(geom="text", x= 35, y=25, label="Vmax") +
  annotate(geom="text", x= 25, y=20, label="WT") +
  annotate(geom="text", x= 25, y=10, label="mut") +
  annotate(geom="text", x= 30, y=20, label=round(Km_WT, 3)) +
  annotate(geom="text", x= 35, y=20, label=round(Vmax_WT, 1)) +
  annotate(geom="text", x= 30, y=10, label=round(Km_mut, 3)) +
  annotate(geom="text", x= 35, y=10, label=round(Vmax_mut, 1))

  Chart 
#load environment from Module_3.R 
#generate a subset of data for H297F mutant enzyme

H297F <- subset(enzdata, Enz=="H297F")

# Third, we create the fit using the nls() function. 
fitH297F <- nls(MMcurve, H297F, start=list(Vmax=40,Km=0.5))

# look at the info using the summary() function
summary(fitH297F)

# we extract our Km and Vmax constants from the fit. 
# make them look a bit nicer with the round() function
Vmax_H297F <- summary(fitH297F)$coefficients[1]
Km_H297F <- summary(fitH297F)$coefficients[2]
paste("Vmax: ", round(Vmax_H297F, 1))
paste("Km: ", round(Km_H297F, 3))

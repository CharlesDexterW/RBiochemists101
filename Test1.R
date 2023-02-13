#Protein concentration object. it's shown in the environment section. 
prot_conc <- c(0.000, 0.016, 0.031, 0.063, 0.125, 0.250, 0.500, 1.000, 
               0.000, 0.016, 0.031, 0.063, 0.125, 0.250, 0.500, 1.000)

#Protein absorbance object. it's properly paired with protein concentration
abs <- c(0.329, 0.352, 0.349, 0.379, 0.417, 0.491, 0.668, 0.956, 
         0.327, 0.341, 0.355, 0.383, 0.417, 0.446, 0.655, 0.905)

#plot function makes a plot from the two previous objects. The result is a curve, shown in plot section

plot(prot_conc, abs)


Exercise #1
#Rehearsal of what you just learned
sample1 <- c(0.0, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6, 0.0, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6)

abs2 <- c(0.29, 0.35, 0.375, 0.4, 0.525, 0.75, 1.2, 0.305, 0.33, 0.395, 0.42, 0.545, 0.73, 1.3)


plot(sample1, abs2)

# this is how we format the data of an object as a frame.
data <- as.data.frame(prot_conc)

#we can look at the structure of an object this way:

str(data)

View(data)

### make a plot with ggplot2
#you want to make a graph with ggplot2 because of the high amount of options for
#customizing
p <- ggplot(data=)

library(ggplot2)

#exercise 2. try  Use the data below to create another plot and play with the code. 
#Complete the exercise before continuing the course, results are shown in the next 
#page.

year <- c("2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014")

mentIll <- c(9.3, 9.2, 9.3, 9.4, 9.4, 10.0, 10.3, 11.0, 11.3, 11.8, 12.1)

data2 <- data.frame(year, mentIll)

p2 <- ggplot(data2,             # a data.frame with the data           
             aes(x=year, y=mentIll)) +       # columns of data.frame 
  geom_point(colour = "red", size = 3)     # type of plot 
      + stat_smooth(method = "lm", formula = y ~ x)
p2 #shows the plot


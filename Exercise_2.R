#exercise 2
#Using the following data, please draw a graph, fit a line and calculate 
#the slope and intercept of the line.

prot_conc <- c(0.0, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6, 0.0, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6)

abs <- c(0.29, 0.35, 0.375, 0.4, 0.525, 0.75, 1.2, 0.305, 0.33, 0.395, 0.42, 0.545, 0.73, 1.3)



data <- as.data.frame(prot_conc)
colnames(data) <- ("prot_conc")
data$abs <- (abs)
plot(data$prot_conc, #x axis
     data$abs,       # y axis
     pch = 17)      # point shape or color

line <- lm(data$abs ~ data$prot_conc) # when calculating lineal model y comes first, then comes x

abline(line,
       col = "purple",
       lwd = 1)

summary(line) 
summary(line)$coefficients  # shows both coefficients
#exercise template. follow code and compare results
  # 1. Create the data frame

prot_conc2 <- c(0.0, 0.05, 0.1, 0.2, 0.4, 0.8, 1.6, 0.0,         
                0.05, 0.1, 0.2, 0.4, 0.8, 1.6)

abs2 <- c(0.29, 0.35, 0.375, 0.4, 0.525, 0.75, 1.2, 0.305, 
          0.33, 0.395, 0.42, 0.545, 0.73, 1.3)

data2 <- as.data.frame(prot_conc2)

data2$abs <- abs2

  #2. Plot the graph with a line

plot(data2$prot_conc, data2$abs)

line2 <- lm(data2$abs ~ data2$prot_conc) 

abline(line2, col = "blue", lwd = 2)

  # 3. Show the summary statistics

summary(line2)

  # 4. Show just the coefficients of the line

summary(line2)$coefficients  # shows both coefficients


line3 <- lm(data$abs, data$prot_conc)

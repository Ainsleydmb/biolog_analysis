#install.packages("gplots") #Install 
#library(gplots) #Load, may prefer to do these two parts in the conole if using multiple times. If so just Markdown these lines compleatly 
#install.packages("viridis")  # Install
#library("viridis")           # Load
#Load data for plate 1
data <- read.csv("/Users/path/to/file/.csv") #CHANGE THIS TO THE FIRST PLATE YOU WANT TO COMPARE
mat_data <- data.matrix(data[,2:ncol(data_1)])
rnames <- data[,1]
rownames(mat_data) <- rnames
par(lend = 1)           # square line ends for the color legend
distance = dist(mat_data, method = "manhattan")
cluster = hclust(distance, method = "ward.D")
png("/Users/ainsleybeaton/Documents/fine_name.png",        # create PNG for the heat map CHANGE THIS TO BE WHERE YOU WANT IT SAVE AND UNDER WHAT NAME       
    width = 15*300,        # 5 x 300 pixels
    height = 15*300,
    res = 300,            # 300 pixels per inch
    pointsize = 8)  
heatmap.2(mat_data,
          cellnote = mat_data,  # same data set for cell labels
          main = "TITLE", # heat map title CHANGE DEPENDING ON THE PLATE TYPE YOU ARE PUTTING IN
          density.info="none",  # turns off density plot inside color legend
          trace="none",         # turns off trace lines inside the heat map
          notecex=0.01,
          scale = c("none"),
          na.rm=TRUE,
          notecol="black",
          margins =c(12,6),  # widens margins around plot
          col=plasma(300), # can also use 'viridis', 'magma' or 'inferno' from the loaded package or built in colours 'rainbow', 'heat.colors', 'cm.colors' or load something else entirly. The number is how many colours it uses in the graph so a higher number = smoother transitions.  
          dendrogram="column",     # only draw a column dendrogram
          Rowv="NA")            # turn off column clustering
dev.off() 
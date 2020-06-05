#install.packages("gplots") #Install 
#library(gplots) #Load, may prefer to do these two parts in the conole if using multiple times.If so just Markdown these lines compleatly 
#install.packages("viridis")  # Install
#library("viridis")           # Load
#Load data for plate 1
data_1 <- read.csv("/Users/ainsleybeaton/Documents/Bio_heatmaps/Data/Yeast/CSVs_for_mapping/PM9_Ang.csv") #CHANGE THIS TO THE FIRST PLATE YOU WANT TO COMPARE
mat_data_4_norm_1 <- data.matrix(data_1[,2:ncol(data_1)])
start_value_1 <- mat_data_4_norm_1[1,]
mat_data_norm_1 <- sweep(mat_data_4_norm_1,2,c(start_value_1),FUN = "-")
#Load data for plate 2
data_2 <- read.csv("/Users/ainsleybeaton/Documents/Bio_heatmaps/Data/Yeast/CSVs_for_mapping/PM9_ER.csv") ##CHANGE THIS TO THE SECOND PLATE YOU WANT TO COMPARE
mat_data_4_norm_2 <- data.matrix(data_2[,2:ncol(data_2)]) #Read it as a matrix under the name mat_data
start_value_2 <- mat_data_4_norm_2[1,] #creating a vector from the first line of the matrix i.e the growth measured at time zero
mat_data_norm_2 <- sweep(mat_data_4_norm_2,2,c(start_value_2),FUN = "-")

#Subtract normalised values in plate 2 from plate 1
mat_data_norm_compar <- mat_data_norm_1-mat_data_norm_2
mat_data_norm_compar

rnames <- data_1[,1]
rownames(mat_data_4_norm_1) <- rnames
par(lend = 1)           # square line ends for the color legend
distance = dist(mat_data_4_norm_1, method = 'manhattan')
cluster = hclust(distance, method = 'ward.D')
png("/Users/ainsleybeaton/Documents/Bio_heatmaps/Images/Test_PM9",        # create PNG for the heat map CHANGE THIS TO BE WHERE YOU WANT IT SAVE AND UNDER WHAT NAME       
    width = 15*300,        # 5 x 300 pixels
    height = 15*300,
    res = 300,            # 300 pixels per inch
    pointsize = 8)  
heatmap.2(mat_data_norm_compar,
          cellnote = mat_data_norm_compar,  # same data set for cell labels
          main = "test", # heat map title CHANGE DEPENDING ON THE PLATE TYPE YOU ARE PUTTING IN
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
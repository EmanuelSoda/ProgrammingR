# script to create a .txt file from the files get from GECO

# create the dataframe from the input files 
prepare.data <- function (path){
  fileNames <- Sys.glob(path)
  dataFrame <- data.frame()
  for(elem in fileNames){
    tmp <- read.table(elem, sep = '\t', header = FALSE) [c(5,11)]
    dataFrame <- rbind(dataFrame, tmp)
  }
  colnames(dataFrame) <- c('ensembl_gene_id', 'fpkm')
  return(dataFrame)
}

# create a dataframe for the healthy samples
data.healthy <- prepare.data("provaData/healthy/*.bed")
data.healthy["is_healthy"] <- rep(1, times = dim(data.healthy)[1])

# create a dataframe for the tumoral samples
data.tumor <- prepare.data("provaData/tumor/*.bed")
data.tumor["is_healthy"] <- rep(0, times = dim(data.tumor)[1])

# combine the two dataframe 
data <- rbind(data.healthy, data.tumor)

# create a file contaning the data 
write.table(data, 'data.txt', sep="\t")

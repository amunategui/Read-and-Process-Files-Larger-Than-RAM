

# this code will not work as is as it requires transactions.csv which is way
# too big to upload, but you should easily be able to port this for your needs

# connection/read.table example #1
transactFile <- 'transactions.csv'
con <- file(description= transactFile, open="r")   
data <- read.table(con, nrows=chunkSize, header=T, fill=TRUE, sep=",")
close(con)

# looping through chunks using read.table
index <- 0
chunkSize <- 100000
counter <- 0
purchaseamount <- 0
con <- file(description=transactFile,open="r")   
dataChunk <- read.table(con, nrows=chunkSize, header=T, fill=TRUE, sep=",")
actualColumnNames <- names(dataChunk)
repeat {
        index <- index + 1
        print(paste('Processing rows:', index * chunkSize))

		purchaseamount <- purchaseamount + sum(dataChunk$purchaseamount)
        counter <- counter + nrow(dataChunk)
 
        if (nrow(dataChunk) != chunkSize){
                print('Processed all files!')
                break}
       
        dataChunk <- read.table(con, nrows=chunkSize, skip=0, header=FALSE, fill = TRUE, sep=",",
        	col.names=actualColumnNames)
        print(head(dataChunk))
        break
}
close(con)

print(paste0('Purchase mean: ',  purchaseamount / counter, "$"))
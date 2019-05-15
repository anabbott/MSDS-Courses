spamPath = "SpamAssassin"
dirNames = list.files(paste(spamPath, sep=.Platform$file.sep))
fullDirNames = paste(spamPath, dirNames, sep=.Platform$file.sep)
fileNames = list.files(fullDirNames[1], full.names = TRUE)
sampleEmail = sapply(fileNames, readLines)
sampleEmail[1]

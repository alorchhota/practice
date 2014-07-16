library(KEGGgraph)
library(KEGG.db)

pName <- "p53 signaling pathway"
pId <- mget(pName, KEGGPATHNAME2ID)[[1]]

# Download kgml file
dlfile <- paste0("results/", pId, ".xml")
retrieveKGML(pId, organism="hsa", destfile=dlfile, method="internal", quiet=TRUE)


# parse the downloaded file
kgraph <- parseKGML2Graph(dlfile, expandGenes=TRUE)

# get the nodes and edges
knodes <- nodes(kgraph)
kedges <- edges(kgraph)

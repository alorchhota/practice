############################################################################################
#### This script manually creates an R object which can be used as a cytoscape network #####
#### sample network:  http://cytoscapeweb.cytoscape.org/documentation/elements         #####
############################################################################################

library(jsonlite)

## define schema obj
nodeAttr1 <- list(name="label", type="string")
nodeAttr2 <- list(name="expression", type="string")

schemaNodes <- list()
schemaNodes[[1]] <- nodeAttr1
schemaNodes[[2]] <- nodeAttr2

edgeAttr1 <- list(name="type", type="string")

schemaEdges <- list()
schemaEdges[[1]] <- edgeAttr1

dataSchema <- list()
dataSchema[['nodes']] <- schemaNodes
dataSchema[['edges']] <- schemaEdges

## defien value obj
node1 <- list(id='1', label='G1', expression='underexpressed')
node2 <- list(id='2', label='G2', expression='overexpressed')
node3 <- list(id='3', label='G3')

edge1 <- list(id='1', source='1', target='2')
edge2 <- list(id='2', source='1', target='3')
edge3 <- list(id='3', source='3', target='3')

nodes <- list()
nodes[[1]] <- node1
nodes[[2]] <- node2
nodes[[3]] <- node3

edges <- list()
edges[[1]] <- edge1
edges[[2]] <- edge2
edges[[3]] <- edge3

dataValues <- list()
dataValues[['nodes']] <- nodes
dataValues[['edges']] <- edges

## define full network
network <- list()
network[['dataSchema']] <- dataSchema
network[['data']] <- dataValues


jsonObj <- toJSON(network)
cat(prettify(jsonObj))

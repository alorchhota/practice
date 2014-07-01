############################################################################################
#### This script defines some methods to create an R object                            #####
#### which can be used as a cytoscape network.                                         #####
#### sample network:  http://cytoscapeweb.cytoscape.org/documentation/elements         #####
############################################################################################

library(jsonlite)
library(RCurl)

createDataSchemaObj <- function(dataAttrNames, dataAttrTypes, edgeAttrNames, edgeAttrTypes){
  #if(class(dataAttrNames) != 'character' || class(dataAttrTypes) != 'character'|| class(edgeAttrNames) != 'character'|| class(edgeAttrTypes) != 'character')
  #  stop('Node and edge attribute names and types must be string.')
  
  if(length(dataAttrNames) != length(dataAttrTypes))
    stop('Node attribute names and values must be of same length.')
  
  if(length(edgeAttrNames) != length(edgeAttrTypes))
    stop('Edge attribute names and values must be of same length.')
  
  ## create node attributes
  schemaNodes <- list()
  dataLen <- length(dataAttrNames)
  if(dataLen > 0)
    schemaNodes <- lapply(1:dataLen, function(idx) list(name=dataAttrNames[idx], type=dataAttrTypes[idx]))
  
  ## create edge attributes
  schemaEdges <- list()
  edgeLen <- length(edgeAttrNames)
  if(edgeLen>0)
    schemaEdges <- lapply(1:edgeLen, function(idx) list(name=edgeAttrNames[idx], type=edgeAttrTypes[idx]))
  
  ## create schema
  dataSchema <- list()
  dataSchema[['nodes']] <- schemaNodes
  dataSchema[['edges']] <- schemaEdges

  return(dataSchema)
}

createEmptyNetwork <- function(dataAttrNames, dataAttrTypes, edgeAttrNames, edgeAttrTypes){
  dataSchema <- createDataSchemaObj(dataAttrNames, dataAttrTypes, edgeAttrNames, edgeAttrTypes);
  dataValues <- list(nodes=list(), edges=list())
  network <- list(dataSchema=dataSchema, data=dataValues)
  return(network)  
}

network.addNode <- function(network, nodeId, ...){
  d <- list(id=nodeId)
  d <- merge.list(d, list(...))
  len <- length(network[['data']][['nodes']])
  network[['data']][['nodes']][[len+1]] <- d
  return(network)
}

network.addEdge <- function(network, edgeId, ...){
  d <- list(id=edgeId)
  d <- merge.list(d, list(...))
  len <- length(network[['data']][['edges']])
  network[['data']][['edges']][[len+1]] <- d
  return(network)
}


#### network creation example #######
network <- createEmptyNetwork(dataAttrNames = c('label','expression'), 
                           dataAttrTypes = c('string', 'string'), 
                           edgeAttrNames = c('type'),
                           edgeAttrTypes = c('string'));

network <- network.addNode(network, '1', label="G1", expression="underexpressed")
network <- network.addNode(network, '2', label="G2", expression="overexpressed")
network <- network.addNode(network, '3', label="G3")

network <- network.addEdge(network, '1', source='1', target='2')
network <- network.addEdge(network, '2', source='1', target='3')
network <- network.addEdge(network, '3', source='2', target='3')


jsonObj <- toJSON(network)
cat(prettify(jsonObj))

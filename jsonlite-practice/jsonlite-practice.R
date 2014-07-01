library(jsonlite)
#library(rjson)

txt <- '{
  "dataSchema": {
    "nodes": [ { "name": "label", "type": "string" },
{ "name": "score", "type": "number" } ],

"edges": [ { "name": "label", "type": "string" },
{ "name": "weight", "type": "number" },
{ "name": "directed", "type": "boolean", "defValue": true} ]
  },

"data": {
  "nodes": [ { "id": "n1", "label": "Node 1", "score": 1.0 },
{ "id": "n2", "label": "Node 2", "score": 2.2 },
{ "id": "n3", "label": "Node 3", "score": 3.5 } ],

"edges": [ { "id": "e1", "label": "Edge 1", "weight": 3, "source": "n1", "target": "n3" },
{ "id": "e2", "label": "Edge 2", "weight": 3.3, "source":"n2", "target":"n1"} ]
}
}'

jsonObj <- fromJSON(txt)

txt2 <- toJSON(jsonObj)

cat(prettify(txt2))
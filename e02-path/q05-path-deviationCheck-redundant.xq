(:~
 : Returns the task ids of all tasks with same values in @deviation on //cacheFile and its parent. 
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q05-path-deviationCheck-redundant.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

return
    $docs//cacheFileConfig[@deviation = ./cacheFile/@deviation]/ancestor::task/taskId/string()

(:~
 : Returns the task ids of all tasks with a @deviation attribute on //cacheFileConfig.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q03-path-deviationCheck-yes.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

return
    (:$docs//cacheFileConfig[@deviation]/../../../task/taskId/string():)
    $docs//cacheFileConfig[@deviation]/ancestor::task/taskId/string()

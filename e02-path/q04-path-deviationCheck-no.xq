(:~
 : Returns the task ids of all tasks without a @deviation attribute on //cacheFileConfig.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q04-path-deviationCheck-no.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

return
    $docs//cacheFileConfig[not(@deviation)]/ancestor::task/taskId/string()

(:~
 : Returns the task ids with the number of cache files appended.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q06-path-cacheFiles.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

(:
(:Just for educational purposes:)
$docs//taskId/concat(./string(), " (", (./../config/cacheFileConfig/*/last())[1], ")")
:)

return
    sort(
            $docs/task !
            concat(taskId, " (", count(config/cacheFileConfig/cacheFile), ")")
    )

(:~ TODO: How exactly does it happen that if XPath in count() returns an empty sequence, this entry is dropped? :)

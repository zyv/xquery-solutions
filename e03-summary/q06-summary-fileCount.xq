(:~
 : Returns a sorted list of task reports, including a count of cache files.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q06-summary-fileCount.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config[tourOperator]/concat(
                    tourOperator, " / ", productionType, " / ", duration, " (", count(cacheFileConfig/cacheFile), ")"
            )
    )

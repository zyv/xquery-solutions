(:~
 : Returns a sorted list of task reports, including a count of cache files, the task id and the relative file path.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q08-summary.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config[tourOperator]/concat(
                    tourOperator, " / ", productionType, " / ", duration,
                    " (", count(cacheFileConfig/cacheFile), ")",
                    " # ", ../taskId,
                    " # ", substring-after(document-uri(root()), "/cfg/")
            )
    )

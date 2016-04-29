(:~
 : Returns a CSV document where each row is a task report.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q09-summary-csv.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config[tourOperator]/concat(
                    tourOperator,
                    ",", productionType,
                    ",", duration,
                    ",", count(cacheFileConfig/cacheFile),
                    ",", ../taskId,
                    ",", substring-after(document-uri(root()), "/cfg/")
            )
    )

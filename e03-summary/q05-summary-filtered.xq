(:~
 : Returns a sorted list of basic task reports, excluding tasks without tour operator.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q05-summary-filtered.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config[tourOperator]/concat(tourOperator, " / ", productionType, " / ", duration)
    )

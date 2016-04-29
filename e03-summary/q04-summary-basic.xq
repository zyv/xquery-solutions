(:~
 : Returns a sorted list of basic task reports (tour operator / production type / duration).
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q04-summary-basic.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config/concat(tourOperator, " / ", productionType, " / ", duration)
    )

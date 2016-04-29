(:~
 : Returns a sorted list of tour operators, duplictes removed.
 : are identified by a document catalog.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q03-summary-tourOperator-distinct.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values($docs/task/config/tourOperator))

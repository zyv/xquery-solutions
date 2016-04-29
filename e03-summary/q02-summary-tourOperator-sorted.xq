(:~
 : Returns a sorted list of tour operators, including duplictes.
 : are identified by a document catalog.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q02-summary-tourOperator-sorted.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort($docs/task/config/tourOperator/string())

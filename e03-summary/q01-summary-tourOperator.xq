(:~
 : Returns a list of tour operators found in the input documents.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q01-summary-tourOperator.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    $docs/task/config/tourOperator/string()

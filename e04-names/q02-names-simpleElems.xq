(:~
 : Returns the names of all elements which do not have child elements.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q02-names-simpleElems.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values($docs//*[not(child::*)]/local-name()))

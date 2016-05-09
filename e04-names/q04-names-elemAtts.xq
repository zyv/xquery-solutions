(:~
 : Returns element names followed by the element's attribute names.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q04-names-elemAtts.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values(
            $docs//concat(local-name(), attribute()[1]/' @ ',
                    string-join(sort(attribute()/local-name()), " "))
    ))

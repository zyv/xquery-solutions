(:~
 : Returns a list of all attribute names followed by the name of the attribute's parent element.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q05-names-atts.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values(
            $docs//attribute()/concat('@', local-name(), ' \ ', parent::*/local-name())
            (:
            Also possible:

            $docs//attribute()/concat('@', local-name(), ' \ ', ../local-name())
            :)
    ))

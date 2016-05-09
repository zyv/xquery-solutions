(:~
 : Returns all element names, appending a / if the element has child elements.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q03-names-elemsFlagged.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values(
            (:
            This trick is crazy, the point is that *[1] in the context of this expression either evaluates to an empty
            sequence or else to a sequence of one element, in the context of which ' /' is then evaluated, and so
            the answer is either an empty sequence, or ' /'. The reason why it doesn't give an error is that applying
            a non-matching predicate on an empty sequence is still simply an empty sequence.
            :)
            $docs//concat(local-name(), *[1]/' /')
    ))

(:~
 : Returns the names of all elements.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q01-names-elems.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
(:
    Sadly, intellij-xquery doesn't support XQuery 3.1 syntax yet:

        https://github.com/ligasgr/intellij-xquery/issues/156

    $docs//*/local-name() => distinct-values() => sort()
:)
    sort(distinct-values($docs//*/local-name()))

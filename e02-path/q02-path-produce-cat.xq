(:~
 : Returns a document catalog containing the URIs of all produce tasks.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs.xml q02-path-produce-cat.xq > docs-produce.xml
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

return
    <docs creationTime="{current-dateTime()}">{
        $docs[task/parent/processId = 'otc_produce']/document-uri(.) ! <doc uri="{.}"/>
    }</docs>

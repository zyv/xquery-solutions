(:~
 : Returns a document catalog containing the URIs of all produce tasks.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs.xml writeCatalogProduce.xq > docs-produce.xml
 :)
declare variable $cat external := 'docs.xml';
declare variable $docs := doc($cat)//doc/@uri/doc(.);

<docs creationTime="{current-dateTime()}">{
    $docs[task/parent/processId = 'otc_produce']/document-uri(.) ! <doc uri="{.}"/>
}</docs>

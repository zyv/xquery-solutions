(:~
 : Returns the document uris of all produce tasks.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q01-path-produce-uri.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
let $uris := $docs[task/parent/processId = 'otc_produce']/document-uri(.)
(:let $uris := $docs/task/parent[processId = 'otc_produce'] ! root(.) ! document-uri(.):)

return
    sort($uris)

(:~
 : Extracts task ids from documents identified by a document catalog.
 :
 : Example call:
 :    basex -b cat=docs-produce.xml q05-taskId-cat.xq
 :)

declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri

return
    sort($docs/doc(.)/task/taskId/string())

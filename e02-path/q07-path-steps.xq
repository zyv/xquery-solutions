(:~
 : Returns the tasks ids with step names appended.
 :
 : External variables: cat - URI of a document catalog
 : Example call:
 :    basex -b cat=docs-produce.xml q07-path-steps.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)

return
    sort(
            $docs/task/concat(
                    substring-after(taskId, "testing.otdsprod.de."),
                    " => ",
                    string-join(config/step/@name, " + ")
            )
    )

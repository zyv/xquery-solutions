(:~
 : Returns a sorted list of task reports, including a count of cache files and the task id.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q07-summary-taskid.xq
 :)
declare variable $cat external;

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(
            $docs/task/config[tourOperator]/concat(
                    tourOperator, " / ", productionType, " / ", duration,
                    " (", count(cacheFileConfig/cacheFile), ")",
                    " # ", ../taskId
            )
    )

(:~ TODO: I wonder if there are better string interpolation facilities in XQuery other than concat?

Python, for instance, has "".format() and now even literal string interpolation:

    https://www.python.org/dev/peps/pep-0498/
:)

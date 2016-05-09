(:~
 : Replaces the task id with the string '${taskId}'.
 :
 : External variables: 
 :    doc - URI of a task configuration document
 : 
 : Example call:
 :    basex -b doc=task-fti.xml q01-typeswitch-taskId.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $doc external := 'task-fti.xml';

declare function f:edit($n as node())
as node()* {
    typeswitch ($n)
        case document-node() return
            document {for $c in $n/node() return f:edit($c)}
    (:
        Another possibility without screening the curly braces:

        case element(taskId) return <taskId>{"${taskId}"}</taskId>
    :)
        case element(taskId) return <taskId>${{taskId}}</taskId>
        case element() return
            element {node-name($n)} {
                for $a in $n/@* return f:edit($a),
                for $c in $n/node() return f:edit($c)
            }
        default return $n
};

f:edit(doc($doc))

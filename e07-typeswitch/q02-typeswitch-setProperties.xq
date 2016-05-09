(:~
 : Replaces the text content of several elements with property references.
 : The elements to be modified are specified by an external variable.
 :
 : External variables: 
 :    doc - URI of a task configuration document
 :    elems - whitespace separated list of element names
 :
 : Example call:
 :    basex -b doc=task-fti.xml -b "elems=taskId tourOperator otdsInputFileName" q02-typeswitch-setProperties.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $doc external := 'task-fti.xml';
declare variable $elems external := 'taskId tourOperator otdsInputFileName';

declare function f:edit($n as node(), $props as xs:string*)
as node()* {
    typeswitch ($n)
        case document-node() return
            document {for $c in $n/node() return f:edit($c, $props)}
        case element()
            return
                let
                    $elem := local-name($n),
                    $attrs := for $a in $n/@* return f:edit($a, $props),
                    $chlds := for $c in $n/node() return f:edit($c, $props)
                return
                    element {node-name($n)} {
                        $attrs,
                        if ($props = $elem)
                        then
                            "${" || $elem || "}"
                        else
                            $chlds
                    }
        default return $n
};

f:edit(doc($doc), tokenize(normalize-space($elems), ' '))

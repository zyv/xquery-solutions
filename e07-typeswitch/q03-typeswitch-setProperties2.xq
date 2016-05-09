(:~
 : Replaces the text and value of specified elements and/or attributes with property references.
 : The elements/attributes to be modified are specified by an external variable.
 :
 : External variables: 
 :    doc - URI of a task configuration document
 :    elems - whitespace separated list of element names
 :
 : Example call:
 :    basex -b doc=task-fti.xml -b "items=taskId tourOperator otdsInputFileName/inputFile @method" q03-typeswitch-setProperties2.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $doc external := 'task-fti.xml';
declare variable $items external := 'taskId tourOperator otdsInputFileName/inputFile @method';

(:
If one wants to work with documents that contain namespaces, one needs to use

    string(node-name($n))

instead of

    local-name($n)

but then the namespaces should be specified accordingly in $items.
:)

declare function f:edit($n as node(), $props as element(Properties))
as node()* {
    typeswitch ($n)
        case document-node() return
            document {for $c in $n/node() return f:edit($c, $props)}
        case element()
            return
                let
                (:$elem := string(node-name($n)),:)
                    $elem := local-name($n),
                    $attrs := for $a in $n/@* return f:edit($a, $props),
                    $chlds := for $c in $n/ node() return f:edit($c, $props)
                return
                    element {$elem} {
                        $attrs,
                        if ($props/Element/@name = $elem) then
                            $props/Element[@name = $elem]/@replacement/string()
                        else
                            $chlds
                    }
        case attribute()
            return
                let $elem := local-name($n)
                (:let $elem := string(node-name($n)):)
                return
                    if ($props/Attribute/@name = $elem) then
                        attribute {$elem} {$props/Attribute[@name = $elem]/@replacement/string()}
                    else
                        $n

        default return $n
};

declare function f:split($s as xs:string) as xs:string* {
    let $tokens := tokenize($s, "/")
    let $key :=
        if (starts-with($tokens[1], "@")) then
            substring-after($tokens[1], "@")
        else
            $tokens[1]
    let $value :=
        if (count($tokens) = 1) then
            $key
        else
            $tokens[2]
    return
        ($key, $value)
};

declare function f:parse($s as xs:string*) as element(Properties) {

    <Properties>
        {
            for $e in $s
            let $kv := f:split($e)
            return
                let $name := if (starts-with($e, "@")) then "Attribute" else "Element"
                return
                    element {$name} {
                        attribute name {$kv[1]}, attribute replacement {"${" || $kv[2] || "}"}
                    }
        }
    </Properties>
};

f:edit(
        doc($doc),
        trace(
                f:parse(tokenize(normalize-space($items), ' '))
                , "Properties: "
        )
)

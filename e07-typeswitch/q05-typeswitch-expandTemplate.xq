(:~
 : Transforms an XML document containing property references by replacing the property references by 
 : property values.
 :
 : External variables: 
 :    template - URI of the XML document
 :    properties - URI of the properties config
 : Example call:
 :    basex -b template=template-task.xml -b properties=properties-task.xml q05-typeswitch-expandTemplate.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $template external := 'template-task.xml';
declare variable $properties external := 'template-properties.xml';

declare function f:edit($n as node(), $props as element(properties))
as node()* {
    typeswitch ($n)
        case document-node() return
            document {for $c in $n/node() return f:edit($c, $props)}
        case element()
            return
                let
                    $attrs := for $a in $n/@* return f:edit($a, $props),
                    $chlds := for $c in $n/ node() return f:edit($c, $props)
                return
                    element {string(node-name($n))} {
                        $attrs,
                        if ($props/property/@pattern = $n) then
                            $props/property[@pattern = $n]/@value/string()
                        else
                            $chlds
                    }
        case attribute()
            return
                if ($n = $props/property/@pattern) then
                    attribute {string(node-name($n))} {$props/property[@pattern = $n]/@value}
                else
                    $n

        default return $n
};


f:edit(
        doc($template),
        trace(
                <properties>{
                    for $p in doc($properties)/properties/*
                    return
                        <property pattern="{"${" || $p/@name || "}"}" value="{$p/@value}"/>
                }</properties>
                , "Properties: ")
)

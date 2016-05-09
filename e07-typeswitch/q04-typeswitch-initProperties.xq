(:~
 : Generates for a given XML document containing property references a properties config enabling 
 : the setting of all properties referenced in the document.
 :
 : The properties config looks similar to this example:
 :
 : <properties count="4">
 :   <property name="inputFile" value=""/>
 :   <property name="method" value=""/>
 :   <property name="taskId" value=""/>
 :   <property name="tourOperator" value=""/>
 : </properties>

 : External variables: 
 :    doc - URI of a task configuration document
 : Example call:
 :    basex -b doc=template-task.xml q04-typeswitch-initProperties.xq
 :)
declare variable $doc external := 'template-task.xml';

let $tmpl := doc($doc)
return
    let $props := distinct-values($tmpl//(@*, text())[matches(., "^\$\{.+\}$")])
    return
        <properties count="{count($props)}">{
            for $p in $props
            let $n := substring-after(substring-before($p, "}"), "${")
            order by $n
            return
                <property name="{$n}" value=""/>
        }</properties>
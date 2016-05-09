(:~
 : Writes a catalog of document URIs.
 :
 : External variables:
 : dir - a directory
 : name - a name pattern (e.g. foo, bar*, *foobar*); default: *.xml
 : deep - if true(), indirect subdirectories are also searched; default: false
 :
 : Example call:
 :    basex -b dir=../../cfg -b name=*.xml  -b deep=true q06-writeCatalog.xq > docs.xml
 :)

declare variable $dir external := "../../cfg";
declare variable $name external := '*.xml';
declare variable $deep as xs:boolean external := true();

<docs>{
    file:list($dir, $deep, $name) 
    ! concat($dir, '/', .)
    ! file:path-to-uri(.)
    [ doc-available(.) ] 
    ! replace(., '\\', '/') 
    ! <doc uri="{.}"/>
}</docs>

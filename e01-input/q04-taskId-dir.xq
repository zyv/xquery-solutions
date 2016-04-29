(:~
 : Extracts task ids from documents identified by directory, name pattern and deep search flag.
 :
 : External variables:
 :    dir - a directory
 :    name - a name pattern (e.g. foo, bar*, *foobar*)
 :    deep - if true(), indirect subdirectories are also searched
 : 
 : Example call:
 :    basex -b dir=../../cfg  -b deep=true -b name=*.xml q04-taskId-dir.xq
 :)

declare variable $dir external;
declare variable $deep external;
declare variable $name external;

let $docs := file:list($dir, $deep, $name)
    ! concat($dir, '/', .) [doc-available(.)]
    ! doc(.)

return
    sort($docs/task/taskId/string())

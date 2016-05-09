(:~
 : Returns a sorted list of all element data paths.
 :
 : External variables: 
 :    cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q06-names-elemPath.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $cat external;

declare function f:local-path($e as element()) as xs:string {
    string-join($e/ancestor-or-self::*/local-name(), "/")
};

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values(
            $docs//*/f:local-path(.)
    ))

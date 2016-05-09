(:~
 : Returns a sorted list of all element and attribute data paths.
 :
 : External variables: 
 :     cat - URI of a document catalog 
 : Example call:
 :    basex -b cat=docs-produce.xml q07-names-itemPath.xq
 :)
declare namespace f = "http://www.traveltainment.de/xquery-functions";

declare variable $cat external;

declare function f:local-path($n as node()) as xs:string {
(:
    let
        $a := $n/ancestor::*
    return
        concat(
                string-join($a/local-name(), "/"), $a[1]/'/',
                $n/self::attribute()/'@', local-name($n)
        )

    Smarter is to rely on the fact ancestor-or-self axis will only give back elements, not attributes as parents:
:)

    string-join($n/ancestor-or-self::node()/concat(self::attribute()/'@', local-name(.)), "/")

};

let $docs := doc($cat)/docs/doc/@uri/doc(.)
return
    sort(distinct-values(
            $docs//(*, @*)/f:local-path(.)
            (:

            Here is a not so smart way of doing it that I came up with first, but in retrospect,
            it's idealogically the same, only less compact:

            (
                $docs//*/f:local-path(.),
                $docs//attribute()/f:local-path(.)
            )
            :)
    ))

(:~
 : Reports arrival airports.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q08-report-arrivalAirports.xq
 :)
declare namespace o = "http://otds-group.org/otds";

let $airports :=
    for $flights in //o:Flights//o:OnewayFlight
    group by $arrivalAirportCode := $flights/o:ArrivalAirport
    let $count := count($flights)
    let $departureAirports :=
        for $airports in $flights/o:DepartureAirport
        group by $airport := $airports
        order by $airport
        return
            <fromAirport code="{$airport}" count="{count($airports)}"/>
    order by $arrivalAirportCode
    return
        <airport code="{$arrivalAirportCode}" count="{$count}">{$departureAirports}</airport>
let $countArrivalAirports := count($airports)
let $countDepartureAirports := count(distinct-values($airports//fromAirport/@code))
return
    <airports src="{document-uri(.)}" count="{$countArrivalAirports}" countDepartureAirports="{$countDepartureAirports}">{
        $airports
    }</airports>

(:~
 : Reports for each arrival airport the number of flights and the names and frequencies 
 : of departure airports.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q07-report-departureAirportCounts.xq
 :)
declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
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
}</airports>

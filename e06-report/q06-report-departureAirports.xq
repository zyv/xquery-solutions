(:~
 : Reports for each arrival airport the number of flights and the names of departure airports.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q06-report-departureAirports.xq
 :)
declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
    for $flight in //o:OnewayFlight
    group by $airportCode := $flight/o:ArrivalAirport
    let $count := count($flight)
    let $departureAirports := sort(distinct-values($flight/o:DepartureAirport))
    order by $airportCode
    return
        <airport code="{$airportCode}" count="{$count}" departureAirports="{$departureAirports}"/>
}</airports>

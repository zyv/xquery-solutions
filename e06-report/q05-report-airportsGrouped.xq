(:~
 : Reports for each arrival airport the number of flights.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q05-report-airportsGrouped.xq
 :)

declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
    for $flight in //o:OnewayFlight
    group by $airportCode := $flight/o:ArrivalAirport
    let $count := count($flight)
    order by $airportCode
    return
        <airport code="{$airportCode}" count="{$count}"/>
}</airports>

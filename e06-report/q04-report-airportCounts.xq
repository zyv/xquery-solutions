(:~
 : Reports for each arrival airport the number of flights.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q04-report-airportCounts.xq
 :)

declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
    for $airportCode in fn:distinct-values(//o:OnewayFlight/o:ArrivalAirport)
    let $count := fn:count(//o:OnewayFlight[o:ArrivalAirport = $airportCode])
    order by $airportCode
    return
        <airport code="{$airportCode}" count="{$count}"/>
}</airports>

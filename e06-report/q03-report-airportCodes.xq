(:~
 : Reports for each arrival airport the airport code.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q03-report-airportCodes.xq
 :)

declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
    for $airportCode in distinct-values(//o:OnewayFlight/o:ArrivalAirport)
    order by $airportCode
    return
        <airport code="{$airportCode}"/>
}</airports>

(:

(:This is for educational purposes only:)

element airports {
    attribute src {document-uri(.)},
    sort(
            distinct-values(
                    //o:OnewayFlight/o:ArrivalAirport
            )
    )
    ! element airport {attribute code {.}}
}
:)

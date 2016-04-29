(:~
 : Creates a list of arrival airport codes.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q02-report-airportCodeList.xq
 :)
declare namespace o = "http://otds-group.org/otds";

<airports src="{document-uri(.)}">{
    sort(
            distinct-values(
                    //o:OnewayFlight/o:ArrivalAirport
            )
    )
}</airports>

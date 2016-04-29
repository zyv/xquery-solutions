(:~
 : Creates an empty <airports> element with a @src attribute identifying the data source.
 :
 : Context item: 
 :    an OTDS data file 
 : Example call:
 :    basex -i otds-fti q01-report-begin.xq
 :)

<airports src="{document-uri(.)}"/>

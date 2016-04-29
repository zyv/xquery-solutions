(:~
 : Extracts the task id from a document identified by a URI.
 :
 : External variables:
 :    uri - file path or URI of the input document
 :
 : Example call:
 :    basex -b uri=../../cfg/configs/automation/testing/de/otds/import/all/atk.xml q03-taskId-uri.xq
 :)

declare variable $uri external;

doc($uri)/task/taskId/string()

(:~
 : Extracts the task id from a document provided as context item.
 :
 : Example call:
 :    basex -i ../../cfg/configs/automation/testing/de/otds/import/all/atk.xml q02-taskId.xq
 :)

/task/taskId/string()

(:
(:text() is not a function call!:)
/task/taskId/text()
:)

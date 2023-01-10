xquery version "1.0-ml";

let $uris := cts:uris("", (), cts:directory-query("/news/")) (:xdmp:node-uri(cts:search(/, cts:collection-query(("raw")))):)

let $count := fn:count($uris)

return ($count, $uris) 
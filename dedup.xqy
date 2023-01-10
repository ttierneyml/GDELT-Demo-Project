xquery version "1.0-ml";


let $uniqueURLs := fn:distinct-values(fn:doc()//SOURCEURL/text())
for $url in $uniqueURLs
let $list := xdmp:node-uri(cts:search(/, cts:word-query($url)))
return for $i in (2 to fn:count($list))
      return xdmp:document-delete($list[$i]), "deleted"
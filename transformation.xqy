xquery version "1.0-ml";
declare namespace http = "xdmp:http";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";

declare variable $URI as xs:string external;  

declare function local:formatXML($source, $meta, $xhtml, $date, $countryCode, $long, $lat, $formatted-date, $responseCode, $domain, $countryCode1, $countryCode2, $countryCode3, $title){
    let $countryCode2 := if($countryCode1 = $countryCode2)
                        then ()
                        else $countryCode2
    let $countryCode3 := if($countryCode1 = $countryCode3 or $countryCode2 = $countryCode3)
                        then ()
                        else $countryCode3
    let $doc := 
        <envelope>
            <headers>
                <date>{$date}</date>
                { let $ret := if ($countryCode1)
                                then <countryCode>{$countryCode1}</countryCode>
                                else ()
                                return $ret}
                { let $ret := if ($countryCode2)
                                then <countryCode>{$countryCode2}</countryCode>
                                else ()
                                return $ret}
                { let $ret := if ($countryCode3)
                                then <countryCode>{$countryCode3}</countryCode>
                                else ()
                                return $ret}                                                                
                <formatted-date>{$formatted-date}</formatted-date>
                <long>{$long}</long>
                <lat>{$lat}</lat>
                {if($responseCode = "") then (<httpGetError>true</httpGetError>) else (<responseCode>{$responseCode}</responseCode>)}
                <domain>{$domain}</domain>
                <metadata>{$meta}</metadata>
                <title>{$title}</title>
            </headers>
            <instance>
                <article>{$xhtml//*:html}</article>
                <source>{$source}</source> 
            </instance>
                <entityType>GDELT</entityType>
        </envelope>
    return $doc
};

declare function local:formatDate($date){
    let $month := xdmp:month-name-from-date($date)
    let $day := fn:substring($date, 9, 2)
    let $year := fn:substring($date, 1, 4)
    let $formatted-date := fn:concat($month, " ", $day, ", ", $year)
    return $formatted-date
};

declare function local:httpGetRecur($i, $source, $date, $countryCode, $long, $lat, $formatted-date, $domain, $URI, $countryCode1, $countryCode2, $countryCode3){
    let $url := $i
    return  if($countryCode = true())
            then try{
                    let $html := xdmp:http-get($url,
                        <options xmlns="xdmp:http">
                            <verify-cert>false</verify-cert>
                        </options>)
                    let $xhtml := xdmp:tidy($html[2])
                    let $meta := $html[1]
                    let $responseCode := $meta/http:code/text()
                    let $title := $xhtml//xhtml:title/text()
                    let $ret := (: change this check to delete these docs if(xs:int($responseCode) = 301 or xs:int($responseCode) = 302) then local:httpGetRecur($url, $source, $date, $countryCode, $long, $lat, $formatted-date, $domain, $URI, $countryCode1, $countryCode2, $countryCode3) else :) xdmp:document-insert($URI, local:formatXML($source, $meta, $xhtml, $date, $countryCode, $long, $lat, $formatted-date, $responseCode, $domain, $countryCode1, $countryCode2, $countryCode3, $title), (xdmp:permission("rest-reader", "read"), xdmp:permission("rest-writer", "update")), ("GDELT", "canonical", "corb_transformed"))
                    return $ret
                }
                catch($err){
                    let $xhtml := <error>HTML UNRETRIEVABLE. SEE METADATA SECTION FOR ERROR</error>
                    return (:delete these docs:) xdmp:document-insert($URI, local:formatXML($source, $err, $xhtml, $date, $countryCode, $long, $lat, $formatted-date, "", $domain, $countryCode1, $countryCode2, $countryCode3, ""), (xdmp:permission("rest-reader", "read"), xdmp:permission("rest-writer", "update")), ("GDELT", "corb_transformed", "failed" ))
                }
            else xdmp:document-delete($URI)
};

let $source := fn:doc($URI)
let $url := $source//root/SOURCEURL/text()
let $domain := fn:tokenize($url, "/")[3]
let $SQLDATE := $source//root/SQLDATE/text()
let $year := fn:substring($SQLDATE, 1, 4)
let $month := fn:substring($SQLDATE, 5, 2)
let $day := fn:substring($SQLDATE, 7, 2)
let $date := xs:date(fn:concat($year, "-", $month, "-", $day))
let $formatted-date := local:formatDate(<date>{$date}</date>)
let $elements := (<Actor1Code/>, <Actor1CountryCode/>, <Actor2Code/>, <Actor2CountryCode/>, <Actor1Geo_FullName/>, <Actor1Geo_CountryCode/>, <Actor1Geo_ADM1/>, <Actor1Geo_ADM2/>, <Actor1Geo_FeatureID/>, <Actor2Geo_FullName/>, <Actor2Geo_CountryCode/>, <Actor2Geo_ADM1/>, <Actor2Geo_ADM2/>, <Actor2Geo_FeatureID/>, <ActionGeo_FullName/>, <ActionGeo_CountryCode/>, <ActionGeo_ADM1Code/>, <ActionGeo_ADM2Code/>, <ActionGeo_FeatureID/>)
let $codes := (
    "UP", "UKR", "Ukraine"
    )
let $countryCode := cts:contains($source, cts:field-word-query($elements, $codes))
let $countryCode1 := $source//Actor1Geo_CountryCode/text()
let $countryCode2 := $source//Actor2Geo_CountryCode/text()
let $countryCode3 := $source//ActionGeo_CountryCode/text()
let $long := if(fn:normalize-space($source//ActionGeo_Long/text()) = "")
            then 0
            else $source//ActionGeo_Long/text()
let $lat := if(fn:normalize-space($source//ActionGeo_Lat/text()) = "")
            then 0
            else $source//ActionGeo_Lat/text()
return local:httpGetRecur($url, $source, $date, $countryCode, $long, $lat, $formatted-date, $domain, $URI, $countryCode1, $countryCode2, $countryCode3)
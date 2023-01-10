const searchConfig  = {  

    // Search view
    search: {
        "defaultEntity": "GDELT",
    
        "meter": {
            "component": "SummaryMeter",
            "config": {
                "colors": {
                    "all": "#cccccc",
                    "filters": "#1ACCA8"
                },
                "totalPath": "searchResults.recordCount.total"
            }
        },
    
        "facets": {
            "component": "Facets",
            "config": {
                "selected": "#1acca8",
                "unselected": "#dfdfdf",
                "displayThreshold": 3,
                "displayShort": 3,
                "displayLong": 5,
                "items": [
                {
                    "type": "string",
                    "name": "countryCode",
                    "tooltip": "Filter by country code."
                },
                {
                    "type": "string",
                    "name": "domain",
                    "tooltip": "Filter by domain."
                }
                ]
            }
        },
    
        "selectedFacets": {
            "component": "SelectedFacets",
            "config": {}
        },
    
        "results": {
            "component": "ResultsList",
            "config": {
                "entityType": {
                    "path": "entityType",
                    "rootRelative": false
                },
                "pageLengths": [10, 20, 40, 80],
                "defaultIcon" : {
                    "type": "faCircle",
                    "color": "lightgrey"
                },
                "sort":{
                    "entities": ["person", "organization"],
                    "label": "Created On",
                    "sortBy": "createdOn",
                    "order": "descending"
                },
                "entities": {
                    "envelope": {
                        "title": {
                            "id": {
                                "path": "uri"
                            },                            
                            "component": "Value",
                            "config": {
                                "arrayPath": "extracted.envelope.headers",
                                "path": "title"
                            }                
                        },
                        "items": [
                        {
                            "component": "Value",
                            "config": {
                            "path": "extracted.envelope.headers.formatted-date"
                            }
                        },
                        {
                            "component": "Value",
                            "config": {
                            "path": "extracted.envelope.headers.domain"
                            }
                        },
                        {
                            "component": "Value",
                            "config": {
                            "path": "uri"
                            }
                        }]
                    }
                }
            }
        }
    }
  
}
  
module.exports = searchConfig;

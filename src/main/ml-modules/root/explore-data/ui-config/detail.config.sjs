const detailConfig  = {  

    // Detail view
detail: {
     "entityType": {
        "path": "entityType"
     },
     "entities": {
        "envelope": {
 
          "heading": {
                        "id": {
                          "path": "uri"
                        },
                        "title": {
                              "component": "Value",
                              "config": {
                                  "path": "envelope.headers.domain"
                              }
                        }
                      },
 
            "membership": {
              // See Membership below for details
            },
 
            "info": {
                "title":"Personal Info",
                "items": [
                    {
                      // See Info below for details
                    }
                ]
            },
 
            "relationships": {
              // See Relationships below for details
            },
 
            "imageGallery": {
              // See ImageGalleryMulti below for details
            },
 
            "geoMap": {
              "component": "GeoMap",
              "config": {
                "title": "Locations",
                "markers": [
                    {
                        "arrayPath": "envelope.headers",
                        "latitude": {
                            "path": "lat"
                        },
                        "longitude": {
                            "path": "long"
                        },
                        "markerStyle": {
                            "markerColor": "red",
                            "icon": "user",
                            "iconColor": "black"
                        },
                        "popover": {
                            "items": [
                                {
                                    "label": "Lat",
                                    "path": "lat"
                                },
                                {
                                    "label": "Long",
                                    "path": "long"
                                }
                            ]
                        }
                    }
                ],
                "shapes": [
                  {
                    "arrayPath": "envelope.headers",
                    "shape": "Circle",
                    "config": {
                      "center": {
                        "latitude": {
                          "path": "lat"
                        },
                        "longitude": {
                          "path": "long"
                        }
                      },
                      "radius": {
                        "miles": 1
                      },
                      "bounds": [
                        [0, 0],
                        [25, 50]
                      ]
                    }
                  },
                ]
              }
            },

            "timeline": {
              // See Timeline below for details
            },
 
            "linkList": {
              // See LinkList below for details
            },
 
        },
        "organization": {
 
          // Configuration for organization entity
         
        }
    }
}

}
  
module.exports = detailConfig;

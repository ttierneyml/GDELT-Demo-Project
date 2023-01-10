const headerConfig  = {  

    // Application header
    header: {
        title: "Project GROW",
        subtitle: "GDELT",
        menus: {
            "component": "Menus",
            "config": [
                {
                    label: "Search",
                    to: "/search"
                },
                {
                    label: "ML Home",
                    url: "http://www.marklogic.com"
                },
                {
                    label: "Submenu",
                    submenu: [
                    {
                        label: "ML Docs",
                        url: "https://docs.marklogic.com/"
                    },
                    {
                        label: "Search",
                        to: "/search"
                    }
                    ]
                }
            ]
        }
    }
};

module.exports = headerConfig;

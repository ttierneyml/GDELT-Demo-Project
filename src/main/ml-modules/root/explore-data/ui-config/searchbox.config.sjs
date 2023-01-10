const searchboxConfig  = {  

    // Application searchbox
    searchbox: {
        component: "SearchBox",
        config: {
            items: [
                {
                    label: "All Entities",
                    value: ["GDELT"],
                    default: true
                },
                {
                    label: "GDELT",
                    value: "GDELT"
                }
            ]
        }
    }
};

module.exports = searchboxConfig;

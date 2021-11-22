// create a network
var container = document.getElementById("mynetwork");
var data = {
    nodes: nodes,
    edges: edges,
};
var options = {
    nodes: {
      shape: "dot",
      size: 10,
    },
};
var network = new vis.Network(container, data, options);
network.on("click", function (params) {
    params.event = "[original event]";
    document.getElementById("eventSpanHeading").innerText = "Click event:";
    document.getElementById("eventSpanContent").innerText = JSON.stringify(
        params,
        null,
        4
    );
    console.log(
        "click event, getNodeAt returns: " +
        this.getNodeAt(params.pointer.DOM)
    );
});
network.on("select", function (params) {
    window.location.href = params.nodes[0]
    // console.log("select Event:", params);
});
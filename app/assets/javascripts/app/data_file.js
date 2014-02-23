PykCharts = {};

PykCharts.columnChart = function(options) {
  nv.addGraph(function() {
    var chart = nv.models.discreteBarChart()
        .x(function(d) { return d.label })
        .y(function(d) { return d.value })
        .staggerLabels(true)   
        .tooltips(false)       
        .showValues(true)      
        .transitionDuration(350);
    d3.select(options.selector)
        .datum(options.data)
        .call(chart);
    nv.utils.windowResize(chart.update);   
    return chart;
  });
}


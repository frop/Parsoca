$('document').ready(function(){
	$.ajax({
		type: "GET",
		url: "/reports/daily.json",
	}).done(function( d ) {
/*
		$.plot($("#graph_placeholder"), [ {
			data: data,
			color: "rgb(30, 180, 20)",
			threshold: { below: 480, color: "rgb(200, 20, 30)" },
			lines: { steps: true }
		} ]);
	});
	
*/
    // helper for returning the weekends in a period
    function weekendAreas(axes) {
        var markings = [];
        var d = new Date(axes.xaxis.min);
        // go to the first Saturday
        d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
        d.setUTCSeconds(0);
        d.setUTCMinutes(0);
        d.setUTCHours(0);
        var i = d.getTime();
        do {
            // when we don't set yaxis, the rectangle automatically
            // extends to infinity upwards and downwards
            markings.push({ xaxis: { from: i, to: i + 2 * 24 * 60 * 60 * 1000 } });
            i += 7 * 24 * 60 * 60 * 1000;
        } while (i < axes.xaxis.max);

        return markings;
    }
    
    var options = {
        xaxis: { mode: "time", tickLength: 25 },
        selection: { mode: "x" },
        grid: { markings: weekendAreas }
    };
    
    var plot = $.plot($("#placeholder"), [ {
			data: d,
			color: "rgb(30, 180, 20)",
			threshold: { below: 480, color: "rgb(200, 20, 30)" },
			lines: { steps: true }
		} ], options);
    
    var overview = $.plot($("#overview"), [ {
			data: d,
			color: "rgb(30, 180, 20)",
			threshold: { below: 480, color: "rgb(200, 20, 30)" }
		} ], {
        series: {
            lines: { show: true, lineWidth: 1 },
            shadowSize: 0
        },
        xaxis: { ticks: [], mode: "time" },
        yaxis: { ticks: [], min: 0, autoscaleMargin: 0.1 },
        selection: { mode: "x" }
    });

    // now connect the two
    
    $("#placeholder").bind("plotselected", function (event, ranges) {
        // do the zooming
        plot = $.plot($("#placeholder"), [ {
			data: d,
			color: "rgb(30, 180, 20)",
			threshold: { below: 480, color: "rgb(200, 20, 30)" },
			lines: { steps: true }
		} ],
                      $.extend(true, {}, options, {
                          xaxis: { min: ranges.xaxis.from, max: ranges.xaxis.to }
                      }));

        // don't fire event on the overview to prevent eternal loop
        overview.setSelection(ranges, true);
    });
    
    $("#overview").bind("plotselected", function (event, ranges) {
        plot.setSelection(ranges);
    });
});
});



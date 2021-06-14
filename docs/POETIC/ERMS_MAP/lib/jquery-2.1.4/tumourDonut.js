var TumourDonut = function(opts) {
    this.cx = (typeof opts.cx != "undefined") ? opts.cx : 0;
    this.cy = (typeof opts.cy != "undefined") ? opts.cy : 0;
    this.r = (typeof opts.r != "undefined") ? opts.r : 50;
    this.element = opts.d3Element;
    this.data = opts.data;
    this.padAngle = (typeof opts.padAngle != "undefined") ? opts.padAngle : 0.03;
    this.cornerRadius = (typeof opts.cornerRadius != "undefined") ? opts.cornerRadius : 8;
    this.innerRadius = (typeof opts.innerRadius != "undefined") ? opts.innerRadius : this.r - 30;
    this.outerRadius = (typeof opts.outerRadius != "undefined") ? opts.outerRadius : this.r - 10;

    this.draw();
}

TumourDonut.prototype.draw = function() {

    this.g = this.element.append("g")
        .classed("donutStuff", true)
        .attr("transform", "translate(" + this.cx + "," + this.cy + ")");

    // underlying white circle 
    this.g.append("circle")
        .attr("cx", 0)
        .attr("cy", 0)
        .attr("r", this.outerRadius)
        .attr("fill", "white");

    var color = d3.scale.ordinal()
        .range(["#7fc97f", "#beaed4", "#fdc086", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

    var arc = d3.svg.arc()
        .outerRadius(this.outerRadius)
        .innerRadius(this.innerRadius)
        .padAngle(this.padAngle)
        .cornerRadius(this.cornerRadius);

    var pie = d3.layout.pie()
        .sort(null)
        .value(function(d) { return d.prev; });        
    
    var slices = this.g.selectAll(".arc")
        .data(pie(this.data))
        .enter().append("g")
        .attr("class", "arcg");

    slices.append("path")
        .attr("class", function(d) {
            return "arc clone_" + d.data.clone;
        })
        .attr("d", arc)
        .style("fill", function(d) { 
            if (!d.data.colour) {
                return color(d.data.clone)
            }
            return d.data.colour; 
        });
}
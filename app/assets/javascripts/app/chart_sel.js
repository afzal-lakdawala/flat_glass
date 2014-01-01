$(function(){

    var lis = $("#viz-types li");
    $(lis[0]).addClass("active"); // Select the first option

    // Render only first option
    $(".viz").hide();
    $(".viz." + $(lis[0]).find("a").attr("data-viz")).show();


    // Events for options
    lis.each(function() {
        var $this = $(this);
        var a = $this.find("a");
        a.on("click", function() {
            $(".viz").hide();
            $(".viz." + $(this).attr("data-viz")).show();
        });
    });


    // Events for visualization
    $(".viz").each(function() {
        var $this = $(this);
        $this.on("click", function() {
            var $this = $(this);
            $(".viz").removeClass("active");
            $this.addClass("active");
            $("#viz_viz_viz_chart_id").val($this.attr("data-id"));
        });
    });

});

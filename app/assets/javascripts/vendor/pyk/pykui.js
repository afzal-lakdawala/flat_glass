$(document).ready(function () {
	
	// Attention
    var original_color = $(".flash_attention").css("background-color");
    $(".flash_attention").css("background-color", "yellow").delay(3300).fadeTo(1200, 0.50, function() {
        $(this).css("background-color", original_color);
    });    
    
    //textarea increase / decrease
    $(".text_area_animate").focus(function () {

        var val_length = $(this).val().length;
        var size = $(this).attr("expand-height");

        if (val_length <= 0) {
            $(this).animate({
                "height": size
            }, "fast");
        }
    });

    $(".text_area_animate").focusout(function () {

        var val_length = $(this).val().length;
        var row = $(this).attr("row"); // 1 row = 16px
        var size = $(this).attr("collapse-height");

        if (val_length <= 0) {

            $(this).animate({
                "height": size
            }, "fast");
        }

    });

    $(".text_area_animate").trigger("focusout");

    //form hint

    $(".form-control").focus(function () {
        var text_hint = $(this).attr("hint");
        if (text_hint.length > 0) {
            var text_id = $(this).attr("id");
            var text_hint = $(this).attr("hint");
            $("#" + text_id).after("<span class='input-error-hint'>" + text_hint + "</span>");
            $(".input-error-hint").css("font-size", "11px").css("color", "grey");
        }
    });

    Tinycon.setOptions({
        width: 7,
        height: 9,
        font: '10px arial',
        colour: '#ffffff',
        background: '#549A2F',
        fallback: true
    });

    // scroll to top
    $("#scroll-topper").hide();
    $("#scroll-topper").click(function () {
        $("html, body").animate({
            scrollTop: 0
        }, 600);
    });

    // header collapser
    $("#collapse-header").click(function () {
        $("#main-nav").toggle();
        $(".breadcrumb-holder").toggle();
        $("#collapse-header span").toggleClass("glyphicon-chevron-up");
        $("#collapse-header span").toggleClass("glyphicon-chevron-down");
        if ($("#collapse-header span").hasClass("glyphicon-chevron-down")) {
            $(this).attr("title", "Show the menu");
            $("body").animate({
                "padding-top": "50px"
            });
        } else {
            $(this).attr("title", "Hide the menu");
            $("body").animate({
                "padding-top": "124px"
            });
        }
    });

    // If the toolbar is not present then there should't be extra
    // padding on the body top
    $("body").css("padding-top", $("#main-header").height());


    // load all the sparklines
    $(".sparkline-holder").each(function (i, e) {
        var data = $(e).attr("data-csv").split(",");
        var graph = $(e).attr("data-graph");
        var color = $(e).attr("data-color");

        if (color === "false") {
            $(e).sparkline(data, {
                type: graph,
                barColor: '#2d2d2d',
                negBarColor: '#2d2d2d',
                zeroColor: '#2d2d2d',

                lineColor: '#2d2d2d',
                fillColor: '#eee',
                spotColor: '#2d2d2d',
                minSpotColor: '#2d2d2d',
                maxSpotColor: '#2d2d2d',
                highlightSpotColor: '#2d2d2d',
                highlightLineColor: '#2d2d2d',

                sliceColors: ["#000", "#222", "#444", "#666", "#888", "#aaa"],

                tooltipOffsetX: 10,
                tooltipOffsetY: 10,
            });
        } else {
            $(e).sparkline(data, {
                type: graph,
                tooltipOffsetX: 10,
                tooltipOffsetY: 10,
            });
        }
    });

    // remove flashed after a while
    var removeFlashes = setTimeout(function () {
        $(".alert-success").fadeOut();
        $(".alert-info").fadeOut();
        $(".alert-warning").fadeOut();
    }, 3000);

});
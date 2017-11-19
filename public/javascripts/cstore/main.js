$(function () {
    // Strict Mood Enable
    "use strict";

    //WOW JS
    new WOW().init();

    // Navbar Srink
    $(window).on('scroll', function () {
        if ($(document).scrollTop() > 0) {
            $('nav').addClass('shrink');
        } else {
            $('nav').removeClass('shrink');
        }
    });

    // Price Slider
    $(function () {
        "use strict";
        var outputValue = $('#price_output');
        var sliderElement = $('#price_slider');

        sliderElement.slider({
            range: true,
            min: 10,
            max: 1000,
            values: [100, 800],
            slide: function (event, ui) {
                outputValue.html(ui.values[0] + ' - ' + ui.values[1] + '');
                $('#priceMin').val(ui.values[0]);
                $('#priceMax').val(ui.values[1]);
            }
        });
        outputValue.html(sliderElement.slider('values', 0) + ' - ' + sliderElement.slider('values', 1));
        $('#priceMin').val(sliderElement.slider('values', 0));
        $('#priceMax').val(sliderElement.slider('values', 1));
    });

    //initiate the plugin and pass the id of the div containing gallery images
    $("#zoom_03").elevateZoom({
        cursor: "crosshair",
        containLensZoom: true,
        zoomType: "lens",
        lensShape: "round",
        lensSize: 200,
        cursor: "crosshair",
        gallery: 'pt_gallery',
        galleryActiveClass: "active"
    });

    //pass the images to Fancybox
    $("#zoom_03").bind("click", function (e) {
        var ez = $('#zoom_03').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });

    //MixItUp
    $('#mixitup').mixItUp();

    // progressbar
    $(".progressround").loading();

    //Counter Up
    $('.counter').counterUp({
        delay: 40,
        time: 2000
    });

    //Back to top
    $(window).on('scroll', function () {
        if ($(this).scrollTop() >= 600) {
            $('#backtotop').fadeIn(500);
        } else {
            $('#backtotop').fadeOut(500);
        }
    });
    $('#backtotop').on('click', function () {
        $('body,html').animate({
            scrollTop: 0
        }, 500);
    });

    //Rev Slider
    jQuery('.tp-banner').revolution({
        delay: 9000,
        startwidth: 1170,
        startheight: 600,
        hideThumbs: 10,
        onHoverStop: "off",
        navigationType: "none",
        navigationArrows: "solo",
        navigationStyle: "preview1",
        hideTimerBar: "on",
        forceFullWidth: "on"
    });

    //Killer Carousel
    $('.kc-wrap').KillerCarousel({
        // Width of carousel.
        width: 800,
        // Item spacing in 3d (CSS3 3d) mode.
        spacing3d: 100,
        // Item spacing in 2d (no CSS3 3d) mode.
        spacing2d: 120,
        // Side shadows on.
        showReflection: true,
        // Looping mode.
        infiniteLoop: true,
        autoScale: 80
    });

    // WOW carosel
    $(".ft_carousel").owlCarousel({
        loop: true,
        items: 4,
        itemsDesktop: [1199, 3],
        itemsDesktopSmall: [979, 2],
        itemsTablet: [768, 2],
        itemsMobile: [479, 1]
    });

    $(".home_company_carousel").owlCarousel({
        autoPlay: true,
        loop: true,
        items: 5,
        itemsDesktop: [1199, 5],
        itemsDesktopSmall: [979, 5],
        itemsTablet: [768, 4],
        itemsMobile: [479, 1]
    });

    $(".feedback_carousel").owlCarousel({
        autoPlay: true,
        responsiveClass: true,
        items: 1,
        itemsTablet: [768, 1],
        itemsDesktop: [1199, 1],
        itemsDesktopSmall: [979, 1],
        itemsMobile: [479, 1]
    });

    $(".rltd_carousel").owlCarousel({
        autoPlay: true,
        loop: true,
        items: 4,
        itemsDesktop: [1199, 3],
        itemsDesktopSmall: [979, 3],
        itemsTablet: [768, 2],
        itemsMobile: [479, 1]
    });

    //Countdown
    $('#clock').countdown('2020/10/10').on('update.countdown', function (event) {
        var $this = $(this).html(event.strftime('' + '<span>%-w</span> week%!w ' + '<span>%-d</span> day%!d ' + '<span>%H</span> hr ' + '<span>%M</span> min ' + '<span>%S</span> sec'));
    });

    //Popup
    $('.popup').magnificPopup({
        type: 'ajax',
    });

    //Preloader
    $("#preloader").fakeLoader({
        timeToHide: 1200, //Time in milliseconds for fakeLoader disappear
        zIndex: "99999999", //Default zIndex
        spinner: "spinner7", //Options: 'spinner1', 'spinner2', 'spinner3', 'spinner4', 'spinner5', 'spinner6', 'spinner7'
        bgColor: "#fff" //Hex, RGB or RGBA colors
    });

    //Dropdown Menu
    $('.dropdown').hover(function () {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(100).fadeIn();
    }, function () {
        $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideUp()
    });

});

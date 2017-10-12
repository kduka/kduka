// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require dataTables/jquery.dataTables
//= require bootstrap-colorpicker
//= require_tree .

/**
 * Created by root on 10/6/17.
 */

$(function () {
    $('textarea').each(function() {
        $(this).height($(this).prop('scrollHeight'));
    });

    $('#auto').click(function () {
        if ($(this).is(':checked')) {
            $.ajax({
                url: '/carts/auto',
                success:function (res) {
                    $(".delivery_options").html(res)
                }
            });
        }
    });

    $('#manual').click(function () {
        if ($(this).is(':checked')) {
            $.ajax({
                url: '/carts/manual',
                success:function (res) {
                    $(".delivery_options").html(res)
                }
            });
        }
    });

    $('#collection').click(function () {
        if ($(this).is(':checked')) {
            $.ajax({
                url: '/carts/collection',
                success:function (res) {
                    $(".delivery_options").html(res)
                }
            });
        }
    });


    $("#ship_email").change(function () {
        email = $("#ship_email").val();
        if (validateEmail(email)){

        }else{

            $("#email_prev").html("<span style='color:red' >This is not a valid email</span>");
        }
    })
});

function geocodeAddress(geocoder, resultsMap) {

    var address = document.getElementById('delivery_location').value;
    geocoder.geocode({
        'address': address, componentRestrictions: {
            country: 'KE'
        }
    }, function (results, status) {
        if (status === 'OK') {

            var string = "";
            console.log(results);
            results.forEach(function (entry) {
                string = string + '<p onclick=\'selectlocation("' + String(entry['formatted_address']) + '");\'>' + String(entry['formatted_address']) + '</p>';


            });
            $('#suggesstion-box').show();
            $('#suggesstion-box').html(string);
            console.log(string);
        } else {
            $('#suggesstion-box').html("Not Found, Try different search words");
        }
    });
}



function selectlocation(val) {

    $("#delivery_location").val(val);
    $("#selected_location").val(val);
    $("#suggesstion-box").hide();
    $.ajax({
        type: 'POST',
        url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + val + '&key=AIzaSyCxt8jyVF7hpNm2gxCjRMvzFt69pgvVYmk',
        success: function (result) {
            results = result['results'];
            console.log(result);

            var latitude = results[0]['geometry']['location']['lat'];
            var longitude = results[0]['geometry']['location']['lng'];
            var location = $("#delivery_location").val();
            var full_name = $("#ship_full_name").val();
            var email = $("#ship_email").val();
            var phone_number = $("#ship_phone_number").val();

            //sendyit2(longitude, latitude);


            $.ajax({
                url:'/carts/location',
                success:function () {

                },
                method:'post',
                data: {
                    'delivery_location':location,
                    'lng': longitude,
                    'lat': latitude,
                    'full_name':full_name,
                    'email':email,
                    'phone_number':phone_number
                }
            });
        },

    });
}

function locate(){
    setTimeout(function () {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 8,
            center: {lat: -34.397, lng: 150.644}
        });
        var geocoder = new google.maps.Geocoder();
        geocodeAddress(geocoder, map);
    }, 1000);
}

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (email.match(re)) {
        return true;
    } else {
        return false;
    }
}

function phonenumbers(phonenumber) {
    //var phoneno = /^(?:(?:254|\+254|0)?(07(?:(?:[12][0-9])|(?:0[0-8])|(9[0-2]))[0-9]{6})|(?:254|\+254|0)?(7(?:(?:[3][0-9])|(?:5[0-6])|(8[5-9]))[0-9        ]{6})    |(?:254|\+254|0)?(77[0-6][0-9]{6})|(?:254|\+254|0)?(76[34][0-9]{6}))$/;
    var phoneno = /(07)([0-3|7])(\d){7}/;
    if (phonenumber.match(phoneno)) {
       return true;
    } else {
        return false;
    }
}

function validate_ship(){
    email = $("#ship_email").val();
    phone = $("#ship_phone_number").val();
    if (not_null("ship_email") && not_null("full_name") && validateEmail(email) && phonenumbers(phone) && (auto() || manual() || collection())){
        $("#process").removeAttr('disabled');
    }else{
        $("#process").attr('disabled','true');
    }
}

function not_null(id){
    if ($("#"+id).val() != ""){
        return true;
    }else{
        return false;
    }
}

function auto(){
    if(($('#auto').is(':checked'))){
        val = $("#delivery_location").val();

        if (val != ""){
            return true;
        }

    }else{
        return false;
    }

}

function collection(){
    if($('#collection').is(':checked')) {
        val = $("#collection_point").val();

        if (val != ""){
            return true;
        }
    }else{
        return false;
    }
}

function manual(){
    if($('#manual').is(':checked')) {
        return true;
    }else{
        return false;
    }
}
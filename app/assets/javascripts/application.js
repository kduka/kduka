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

    $("#checkout").click(function (e) {

    });

    $("#process").click(function (e) {
        e.preventDefault();
        finalize();
        $.ajax({
            url:"/carts/checkout",
            method:'get'
        });
    });

    $("#edit").click(function (e) {
        e.preventDefault();
        $("#process").attr('style',"display:block;margin-top: 1em");
        $("#edit").attr('style',"display:none;margin-top: 1em");
        $('.ship_form').removeAttr('disabled');
    });

    $("#add-delivery").click(function (e) {
        e.preventDefault();
        del_opt = $("#del_opt").val();
        del_price = $("#del_price").val();

        if (del_opt == "") {
            $(".del_opt_err").html("<span style='color:red;'>Please fill the delivery option, It cant be empty</span>");
        } else if (del_price == "") {
            $(".del_opt_err").html("<span style='color:red;'>Please specify the price, It cant be empty</span>");
        } else {
            $.ajax({
                url: '/store_deliveries',
                method: 'post',
                data: {
                    del_opt: del_opt,
                    del_price: del_price
                },
                success: function (e) {
                    $(".del_opt_err").html("");
                    $("#del_opt").val("");
                    $("#del_price").val("");
                }
            })
        }
    });

    $('textarea').each(function () {
        $(this).height($(this).prop('scrollHeight'));
    });

    $('#auto').click(function () {
        $("#process").attr("disabled","true");
        full_name = $("#ship_full_name").val();
        phone = $("#ship_phone_number").val();
        email = $("#ship_email").val();
        var data;
        if (full_name != "" && phonenumbers(phone) && validateEmail(email)) {
            $(".warn_fill_fields").html("<p style='color: green'>Type below to search for your nearest location</p>");
            data = 'true'
        } else {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name, Email and Phone Number First!</p>");
            data = 'false'
        }

        if ($(this).is(':checked')) {
            $.ajax({
                url: '/carts/auto',
                data: {
                    cond: data
                },
                success: function (res) {
                    $(".delivery_options").html(res);
                }
            });
        }
    });

    $('#manual').click(function () {
        $("#process").attr("disabled","true");
        full_name = $("#ship_full_name").val();
        phone = $("#ship_phone_number").val();
        var data;
        if (full_name != "" && phonenumbers(phone)) {
            $(".warn_fill_fields").html("<p style='color: green'></p>");
        } else {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name and Phone Number First!</p>");
            $(".delivery_options").html("");
        }
        if ($(this).is(':checked')  && full_name != "" && phonenumbers(phone)) {
            $.ajax({
                url: '/carts/manual',
                success: function (res) {
                    $(".delivery_options").html(res);
                }
            });
        }
    });

    $('#collection').click(function () {
        $("#process").attr("disabled","true");
        full_name = $("#ship_full_name").val();
        phone = $("#ship_phone_number").val();
        var data;
        if (full_name != "" && phonenumbers(phone)) {
            $(".warn_fill_fields").html("<p style='color: green'></p>");
        } else {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name and Phone Number First!</p>");
            $(".delivery_options").html("");
        }

        if ($(this).is(':checked') && full_name != "" && phonenumbers(phone)) {
            $.ajax({
                url: '/carts/collection',
                success: function (res) {
                    $(".delivery_options").html(res)
                }
            });
        }
    });


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
    $("#sel_loc").val(val);
    $("#suggesstion-box").hide();
    $("#process").attr("value","Processing ... ");
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
                url: '/carts/location',
                success: function () {

                },
                method: 'post',
                data: {
                    'delivery_location': location,
                    'lng': longitude,
                    'lat': latitude,
                    'full_name': full_name,
                    'email': email,
                    'phone_number': phone_number
                }
            });
        },

    });
}

function locate() {
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
    var phoneno = /^(07)([0-9|7])(\d){7}$/;
    if (phonenumber.match(phoneno)) {
        return true;
    } else {
        return false;
    }
}
/*
 function validate_ship(){
 email = $("#ship_email").val();
 phone = $("#ship_phone_number").val();
 if (not_null("ship_email") && not_null("full_name") && validateEmail(email) && phonenumbers(phone) && (auto() || manual() || collection())){
 $("#process").removeAttr('disabled');
 }else{
 $("#process").attr('disabled','true');
 }
 }*/

function val_ship() {

    full_name = $("#ship_full_name").val();
    phone = $("#ship_phone_number").val();
    email = $("#ship_email").val();

    if (full_name != "" && phonenumbers(phone) && validateEmail(email)) {
        if ($("#auto").is(':checked')) {
            $(".warn_fill_fields").html("<p style='color: green'>Type below to search for your nearest location</p>");
        }else{
            $(".warn_fill_fields").html("");
        }
        $("#delivery_location").removeAttr("disabled");
    } else {
        if ($("#auto").is(':checked')) {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name, Email and Phone Number First!</p>");
        }else{
            $("#delivery_location").removeAttr("disabled");
        }
        $("#delivery_location").attr("disabled", "true");

    }
}

function not_null(id) {
    if ($("#" + id).val() != "") {
        return true;
    } else {
        return false;
    }
}

function auto() {
    if (($('#auto').is(':checked'))) {
        selval = $("#sel_loc").val();

        if (selval != "") {
            return true;
        }

    } else {
        return false;
    }

}

function collection() {
    if ($('#collection').is(':checked')) {
        val = $("#collection_point").val();

        if (val != "") {
            return true;
        }
    } else {
        return false;
    }
}

function manual() {
    if ($('#manual').is(':checked')) {
        return true;
    } else {
        return false;
    }
}

    function val_phone() {
        phone = $("#ship_phone_number").val();
        if (!phonenumbers(phone)) {
            $("#phone_prev").html("<p style='color:red;'>This is not a valid phone number, use the format 07XXXXXXXX</p>")
        } else {
            $("#phone_prev").html("")
        }
    }

    function val_email() {
        if (!validateEmail(email)) {
            $("#email_prev").html("<p style='color:red;'>Email is not a valid email address</p>");
        } else {
            $("#email_prev").html("");
        }
    }

    function finalize(){
        full_name = $("#ship_full_name").val();
        phone = $("#ship_phone_number").val();
        email = $("#ship_email").val();
        //delivery_type = $("#delivery").val();
        delivery_order = $("#delivery_order").val();
        delivery_location = $("#sel_loc").val();

        lat = $("#lat").val();
        lng = $("#long").val();
        instructions = $("#instructions").val();

        if($("#auto").is(':checked')){
            delivery_amount = $("#delivery_amount").val();
        }else if($("#manual").is(':checked')){
            delivery_amount = $("input:radio[name=del_opt]").val();
        }else if($("#collection").is(':checked')){
            delivery_amount = 0;
        }



        $.ajax({
            url:'/carts/update_shipping',
            method:'post',
            data:{
                amount:delivery_amount,
                orderid:delivery_order,
                type:$("input:radio[name=delivery]").val(),
                email:$("#ship_email").val(),
                name:$("#ship_full_name").val(),
                phone:$("#ship_phone_number").val(),
                delivery_location:delivery_location,
                lat:lat,
                lng:lng,
                instructions:instructions
            },

            success:function () {
                $('.ship_form').attr('disabled', 'true');
                $("#process").attr('style',"display:none;margin-top: 1em");
                $("#edit").attr('style',"display:block;margin-top: 1em");
            }
        });
    }

    function collect() {
        if ($("#collection").is(':checked')) {
            if (full_name != "" && phonenumbers(phone)) {
                $.ajax({
                    url: '/carts/collection',
                    success: function (res) {
                        $(".delivery_options").html(res)
                    }
                });
                $("#process").removeAttr("disabled");

            } else {
                $(".warn_fill_fields").html("<p style='color: red'>Fill your Name and Phone Number First!</p>");
                $(".delivery_options").html("");
            }
        }
    }

function manual_() {
    if ($("#manual").is(':checked')) {
        if (full_name != "" && phonenumbers(phone)) {
            $.ajax({
                url: '/carts/manual',
                success: function (res) {
                    $(".delivery_options").html(res)
                }
            });
        } else {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name and Phone Number First!</p>");
            $(".delivery_options").html("");
        }
    }
}

function _manual_(){
    if($("input:radio[name=delivery]").val() != ""){
        if($("#other").is(':checked')){
           if ($("#instructions").val() != ""){
               $("#process").removeAttr("disabled");
           }else{
               $("#process").attr("disabled","true");
           }
        }else{
            $("#process").removeAttr("disabled");
            $(".select_instructions").html('');
            $("#instructions").val('');
        }
    }
}





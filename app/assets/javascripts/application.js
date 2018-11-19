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
//= require froala_editor.min.js
//= require plugins/emoticons.min.js
//= require plugins/image.min.js
//= require plugins/image_manager.min.js
//= require_tree .


/**
 * Created by root on 10/6/17.
 */

$(function () {


    $("#nxtBtn").click(function (e) {
        e.preventDefault();
    });

    $(".signup").click(function (e) {
        $.ajax({
            url: '/stores/signup',
            method: 'get',
            success: function (d) {
                $("#signup_modal").html(d);
            }
        });
    });

    $("#url").keyup(function () {
        url = $("#url").val();

        $.ajax({
            url: '/users/remote_santize',
            data: {
                url: url
            },
            method: 'post',
            success: function (res) {
                if (res == 'false') {
                    vall = $("#url").val();
                    $("#url_prev").html("<span style='color:red'>http://" + vall + ".kduka.co.ke is already taken!</span>");
                    $("#url").attr('data-valid', 'false');
                    store_reg();
                } else {
                    $("#url").attr('data-valid', 'true');
                    $("#url_prev").html("<span style='color:green'>We'll create http://" + res + ".kduka.co.ke for you!</span>");
                    //var str = res;
                    //var url = str.replace('.kduka.co.ke', '');
                    //$("#url").val(url);
                    store_reg();
                }
            }
        });
    });

    $("#url_edit").keyup(function () {


        url = $("#url_edit").val();

        $.ajax({
            url: '/users/remote_santize',
            data: {
                url: url
            },
            method: 'post',
            success: function (res) {
                if (res == 'false') {
                    vall = $("#url_edit").val();
                    $("#url_prev").html("<span style='color:red'>http://" + vall + ".kduka.co.ke is already taken!</span>");
                    $("#url_edit").attr('data-valid', 'false');
                } else {
                    $("#url_edit").attr('data-valid', 'true');
                    $("#url_prev").html("<span style='color:green'>http://" + res + ".kduka.co.ke</span>");
                }
                if ($("#url_edit").val() == $("#url_edit").attr('val')) {
                    $("#url_edit").attr('data-valid', 'true');
                    $("#url_prev").html("<span style='color:green'>No Changes</span>");
                }
                if (url.length > 2 && $("#url_edit").attr("data-valid") == "true") {
                    //$("#url_prev").html("");
                    $("#url_edit").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
                    $("#changebtn").removeAttr('disabled');
                    $("#changebtn").removeAttr("style");
                } else {
                    $("#url_edit").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
                    $("#url_prev").html("<p style='color:red;font-size: 15px;'>Your store address needs to be unique and have a minimum 3 characters</p>");
                    $("#changebtn").attr('disabled','true');
                    $("#changebtn").attr("style", "background-color:grey;color:#000;border-color: grey;");
                }

            }

        });
    });


    $("#pass_store").keyup(function () {
        password = $("#pass_store").val();
        if (!pass(password)) {
            $(".store_password_prev").html("<p style='color:red;font-size: 15px;'>Password must be at least 6 characters long, with at least one capital letter and number</p>");
            $("#pass_store").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
            $("#pass_store").attr('data-valid', 'false');
        } else {
            $(".store_password_prev").html("");
            $("#pass_store").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
            $("#pass_store").attr('data-valid', 'true');
        }
        res_check();
    });

    $("#store_pass_confirmation").keyup(function () {
        password = $("#pass_store").val();
        password_c = $("#store_pass_confirmation").val();
        if (password == password_c && pass(password)) {
            $(".store_password_confirmation_prev").html("");
            $("#store_pass_confirmation").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #06B216;');
            $("#store_pass_confirmation").attr('data-valid', 'true');
        } else {
            $(".store_password_confirmation_prev").html("<p style='color:red;font-size:15px;'>Password don't match!</p>");
            $("#store_pass_confirmation").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
            $("#store_pass_confirmation").attr('data-valid', 'false');
        }

        res_check();
    });

    $("#verify").click(function (e) {
        e.preventDefault();
        loc = $("#sel_loc").val();
        user = $("#sendyuser").val();
        passw = $("#sendykey").val();
        lat = $("#store_lat").val();
        lng = $("#store_lng").val();

        $(".status").removeAttr('hidden').html('<i class="icon-spinner icon-spin"></i> Please wait as we verify your credentials');

        $.ajax({
            url: '/stores/sendy',
            method: 'post',
            data: {
                loc: loc,
                user: user,
                passw: passw,
                lat: lat,
                lng: lng
            },
            success: function (e) {

            }
        });
    });

    $('#myOrderTable').DataTable({
        "order": [[1, "desc"]]
    });

    $('#myTable').DataTable({
        "order": [[2, "desc"]]
    });

    $('#myHistoryTable').DataTable({
        "order": [[6, "desc"]]
    });

    $('#myProductTable').DataTable({
        "order": [[1, "asc"]]
    });

    $("#b2c").click(function (e) {
        e.preventDefault();
        if($("#client_name_b2c").val() == "") {
            $(".amount_prev_b2c").html("<span style='color:red;'>The recepient name can't be empty</span>");
        } else if ($("#client_account_b2c").val() == ""){
            $(".amount_prev_b2c").html("<span style='color:red;'>The phone number can't be empty</span>");
        } else if ($("#amount_b2c").val() == ""){
            $("#amount_prev_b2c").html("<span style='color:red;'>Amount can't be empty</span>");
        } else {
            $(".b2c_text").html("Processing");
            $("#b2c").attr("disabled", "true");
            $(".trans_messages").html("<p style=''> Please wait ...</p>");
            thename = $("#client_name_b2c").val();
            phone = $("#client_account_b2c").val();
            amount = $("#amount_b2c").val();
            $.ajax({
                url: '/stores/b2c',
                method: 'post',
                data: {
                    name: thename,
                    phone: phone,
                    amount: amount
                },
                success: function (f) {

                }
            });
        }

    });

    $("#b2bpay").click(function (e) {
        e.preventDefault();
        $(".b2bpay_text").html("Processing");
        $("#b2bpay").attr("disabled", "true");
        $(".trans_messages_pay").html("<p style=''> Please wait ...</p>");
        name = $("#client_name_pay").val();
        account = $("#client_account_pay").val();
        amount = $("#amount_pay").val();

        $.ajax({
            url: '/stores/b2b',
            method: 'post',
            data: {
                name: name,
                account: account,
                amount: amount,
                type: "7"
            },
            success: function (f) {

            }
        });
    });

    $("#b2btill").click(function (e) {
        e.preventDefault();
        $(".b2btill_text").html("Processing");
        $("#b2btill").attr("disabled", "true");
        $(".trans_messages_till").html("<p style=''> Please wait ...</p>");
        name = $("#client_name_till").val();
        account = $("#client_account_till").val();
        amount = $("#amount_till").val();

        $.ajax({
            url: '/stores/b2b',
            method: 'post',
            data: {
                name: name,
                account: account,
                amount: amount,
                type: "6"
            },
            success: function (f) {

            }
        });
    });

    $("#eft").click(function (e) {
        e.preventDefault();
        $(".eft_text").html("Processing");
        $("#eft").attr("disabled", "true");
        $(".trans_messages_eft").html("<p style=''> Please wait ...</p>");
        name = $("#client_name_eft").val();
        account = $("#client_account_eft").val();
        amount = $("#amount_eft").val();
        bankcode = $("#bank_code").val();

        $.ajax({
            url: '/stores/eft',
            method: 'post',
            data: {
                name: name,
                account: account,
                amount: amount,
                type: "6",
                bankcode: bankcode
            },
            success: function (f) {

            }
        });
    });

    $("#confirmation_id").click(function (e) {
        $(".conf_text").html("Confirming Order ...");
        ref = $("#ref").val();
        $.ajax({
            url: '/carts/confirm',
            method: 'post',
            data: {
                ref: ref
            },
            success: function (e) {
                if (e == "complete") {
                    $(".conf_text").html("Success!");
                    $(".conf_message").html("<span style='color: green'>Payment Complete.Your order has been placed. Check the provided email for further details! </span>");
                    window.location = "/carts/success"
                } else if (e == 'none') {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: red'>Payment not complete. Try again after a few seconds</span>");
                } else if (e == 'shipped') {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: #06b216'>Order Complete and Shipped</span>");
                    window.location = "/carts/success"
                } else {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: red'>" + e + "</span>");
                }
            }
        });
    });

    $("#process").click(function (e) {
        e.preventDefault();
        finalize();
    });

    $("#edit").click(function (e) {
        e.preventDefault();
        $("#process").attr('style', "display:block;margin-top: 1em");
        $("#edit").attr('style', "display:none;margin-top: 1em");
        $('.ship_form').removeAttr('disabled');
        $("#complete").attr("disabled", "true");
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
        $("#process").attr("disabled", "true");
        full_name = $("#ship_full_name").val();
        phone = $("#ship_phone_number").val();
        email = $("#ship_email").val();
        var data;
        if (full_name != "" && phonenumbers(phone) && valmail(email)) {
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
        $("#process").attr("disabled", "true");
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
                url: '/carts/manual',
                success: function (res) {
                    $(".delivery_options").html(res);
                }
            });
        }
    });

    $('#collection').click(function () {
        $("#process").attr("disabled", "true");
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

    $("#user_name").change(function (e) {
        user = $("#user_name").val()
        if (user.length < 3) {
            $(".user_name_prev").html("<p style='color:red;font-size: 15px;'>Enter a valid name please</p>");
            $("#user_name").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".user_name_prev").html("");
            $("#user_name").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        }
        user_reg();
    });

    $("#store_name").keyup(function (e) {
        store = $("#store_name").val()
        if (store.length < 4) {
            $(".store_name_prev").html("<p style='color:red;font-size: 15px;'>Store name has a minimum 5 characters</p>");
            $("#store_name").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".store_name_prev").html("");
            $("#store_name").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        }
        store_reg();
    });

    $("#url").change(function (e) {
        url = $("#url").val();
        if (url.length < 3) {
            $(".url_prev").html("<p style='color:red;font-size: 15px;'>Your store address has a minimum 3 characters</p>");
            $("#url").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".url_prev").html("");
            $("#url").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        }
        store_reg();
    });


    $("#store_phone").keyup(function () {
        phone = $("#store_phone").val();
        if ($.isNumeric(phone) && phonecheck(phone)) {
            $(".phone_prev").html("");
            $("#store_phone").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        } else {
            $(".phone_prev").html("<p style='color:red;font-size: 15px;'>Please enter a valid phone number in format 2547xxxxxxxx</p>");
            $("#store_phone").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        }
        store_reg2();
    });

    $("#store_display_email").change(function () {
        email = $("#store_display_email").val();
        if (valmail(email)) {
            $(".display_email_prev").html("");
            $("#store_display_email").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        } else {
            $(".display_email_prev").html("<p style='color:red;font-size: 15px;'>Please enter a valid email</p>");
            $("#store_display_email").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        }
    });

    $("#user_email").keyup(function (e) {
        email = $("#user_email").val();
        validateEmail2(email);
    });

    $("#user_password").keyup(function (e) {
        password = $("#user_password").val();
        if (!pass(password)) {
            $(".user_password_prev").html("<p style='color:red;font-size: 15px;'>Password must be at least 6 characters long, with at least one capital letter and number</p>");
            $("#user_password").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".user_password_prev").html("");
            $("#user_password").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');

        }
        user_reg();
    });

    $("#store_password").keyup(function (e) {
        password = $("#store_password").val();
        if (!pass(password)) {
            $(".store_password_prev").html("<p style='color:red;font-size: 15px;'>Password must be at least 6 characters long, with at least one capital letter and number</p>");
            $("#store_password").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".store_password_prev").html("");
            $("#store_password").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        }
        store_reg2();
    });

    $("#user_password_confirmation").keyup(function (e) {
        password = $("#user_password").val();
        password_c = $("#user_password_confirmation").val();
        if (password == password_c) {
            $("#user_password_confirmation").attr('data-valid', 'true');
            $(".user_password_confirmation_prev").html("");
            $("#user_password_confirmation").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        } else {
            $("#user_password_confirmation").attr('data-valid', 'false');
            $(".user_password_confirmation_prev").html("<p style='color:red;font-size: 15px;'>Password don't match!</p>");
            $("#user_password_confirmation").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        }
        user_reg();
    });

    $("#store_password_confirmation").keyup(function (e) {
        password = $("#store_password").val();
        password_c = $("#store_password_confirmation").val();
        if (password == password_c) {
            $(".store_password_confirmation_prev").html("");
            $("#store_password_confirmation").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
            $("#store_password_confirmation").attr('data-valid', 'true');
        } else {
            $(".store_password_confirmation_prev").html("<p style='color:red;font-size: 15px;'>Password don't match!</p>");
            $("#store_password_confirmation").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
            $("#store_password_confirmation").attr('data-valid', 'false');
        }
        store_reg2();
    });

    $("#sort_product").click(function () {
        val = $("#sorter_id").val();
        cat = $("#category_id").val();
        //alert(cat);
        $.ajax({
            url: '/products/sort',
            method: 'post',
            data: {
                sorter: val,
                cat: cat
            },
            success: function (e) {
                //alert(e);
                $(".product_box").html(e);
            }
        });
    });

    $("#product_search").click(function (e) {
        e.preventDefault();
        key = $("#keywords").val();

        $.ajax({
            url: '/products/search',
            method: 'post',
            data: {
                key: key
            },
            success: function (e) {
                $(".product_box").html(e);
            }
        });
    });

    $("#store_store_font").change(function () {
        font = $("#store_store_font").val();
        //alert(font);
        $(".change_font").attr('style', 'padding:1em;font-family:"' + font + '"');
        $(".change_font").html('The quick brown fox jumps over the lazy dog');
    });

    $("#complete_delivery").click(function () {
        $("#complete_delivery").html('Requesting Delivery ..');
        $(".del_err").html('<p style="color: green">Please Wait .... </p>');
        order_no = $("#del_order").val();
        //alert(order_no);

        $.ajax({
            url: '/stores/complete_order',
            data: {
                orderno: order_no
            },
            method: 'post',
            success: function (e) {

            }
        })
    });

    $("#complete").click(function (e) {
        e.preventDefault();
        code = $("#delivery_code").val();
        ref = $("#order_ref").val();
        $.ajax({
            url: '/stores/close_order',
            method: 'post',
            data: {
                code: code,
                ref: ref
            },
            success: function (e) {
                // alert(e);
            }
        })
    });

    $("#change_shipping_status").click(function () {
        ref = $("#order_ref").val();
        $.ajax({
            url: '/stores/update_order2',
            method: 'post',
            data: {
                status: 3,
                ref: ref
            },
            success: function (e) {
                // alert(e);
            }
        })
    });

    $("#changepass").change(function (e) {
        password = $("#changepass").val();
        if (!pass(password)) {
            $(".store_password_prev").html("<p style='color:red;font-size: 15px;'>Password must be at least 6 characters long, with at least one capital letter and number</p>");
            $("#changepass").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".store_password_prev").html("");
            $("#changepass").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');

        }
        store_change_reg();
    });

    $("#changepassconf").keyup(function (e) {
        password = $("#changepass").val();
        passwordc = $("#changepassconf").val();
        if (password != passwordc) {
            $(".store_password_conf_prev").html("<p style='color:red;font-size: 15px;'>Passwords don't match</p>");
            $("#changepassconf").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        } else {
            $(".store_password_conf_prev").html("");
            $("#changepassconf").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');

        }
        store_change_reg();
    });

    $("#changemail").change(function () {
        email = $("#changemail").val();
        if (valmail(email)) {
            $(".display_email_prev").html("");
            $("#changemail").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
        } else {
            $(".display_email_prev").html("<p style='color:red;font-size: 15px;'>Please enter a valid email</p>");
            $("#changemail").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
        }
        store_change_reg();
    });

    $("#currentpass").keyup(function () {
        store_change_reg();
    });

    $("#store_email").keyup(function () {
        validateEmail($("#store_email").val());
        store_reg();
    });

    $("#add-variant").click(function (e) {
        e.preventDefault();
        variant_name = $("#variant_name").val();
        variant_value = $("#variant_value").val();
        id = $("#num").attr('data');


        if (variant_name == "") {
            $(".var_opt_err").html("<span style='color:red;'>Please fill the variant name, It cant be empty</span>");
        } else if (variant_value == "") {
            $(".var_opt_err").html("<span style='color:red;'>Please specify the variant value, It cant be empty</span>");
        } else {
            $.ajax({
                url: '/products/add_variant',
                method: 'post',
                data: {
                    variant_name: variant_name,
                    variant_value: variant_value,
                    id: id
                },
                success: function (e) {
                    $(".del_opt_err").html("");
                    $("#del_opt").val("");
                    $("#del_price").val("");
                }
            })
        }
    });

    $("#up1").click(function () {
        $.ajax({
            url: '/stores/create_year',
            method: 'post',
            data: {
                type: 'year'
            },
            success: function (e) {
                $("#yearly_modal").html("");
                $("#yearly_modal").html(e);
            }
        })
    });

    $("#up2").click(function () {
        $.ajax({
            url: '/stores/create_bi',
            method: 'post',
            data: {
                type: 'bi'
            },
            success: function (e) {
                $("#bi_modal").html("");
                $("#bi_modal").html(e);
            }
        })
    });

    $("#up3").click(function () {
        $.ajax({
            url: '/stores/create_month',
            method: 'post',
            data: {
                type: 'month'
            },
            success: function (e) {
                $("#monthly_modal").html("");
                $("#monthly_modal").html(e);
            }
        })
    });

    $("#pay_confirm").click(function (e) {
        $(".conf_text").html("Confirming Order ...");
        ref = $("#ref").val();
        $.ajax({
            url: '/store/confirm_sub',
            method: 'post',
            data: {
                ref: ref
            },
            success: function (e) {
                if (e == "complete") {
                    $(".conf_text").html("Success!");
                    $(".conf_message").html("<span style='color: green'>Payment Complete.Your order has been placed. Check the provided email for further details! </span>");
                    window.location = "/stores/premium"
                } else if (e == 'none') {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: red'>Payment not complete. Try again after a few seconds</span>");
                } else if (e == 'shipped') {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: #06b216'>Order Complete and Shipped</span>");
                    window.location = "/stores/premium"
                } else {
                    $(".conf_text").html("Confirm");
                    $(".conf_message").html("<span style='color: red'>" + e + "</span>");
                }
            }
        });
    });

    $(".delete_var").click(function (e) {
        //alert($(this).attr('data') + " " + $(this).attr('data-attr'));
        id = $("#num").attr('data');
        //$(".delete_var").off("click");
        $.ajax({
            url: '/products/delete_variant',
            method: 'post',
            data: {
                name: $(this).attr('data'),
                index: $(this).attr('data-attr'),
                product_id: id,
            },
            success: function () {

            }

        })
    });

    $(".add_var").click(function () {
        $('.var_rev').html("<input type='text' id='new_var' /> <span class='add_value' style='cursor: pointer'> Add Variant </span>");
        //$(this).attr("class","add_var_temp label");
        $("#new_var").focus();
    });

    $(".var_sel").click(function () {

        var_class = $(this).attr('data-name');
        $("." + var_class).attr('style', 'border-style: dashed;border-width: 1px;padding: 5px 10px;');
        $("." + var_class).attr('data-sel', 'false');
        $(this).attr('style', 'border-style:solid;border-width:2px;');
        $(this).attr('data-sel', 'true');
    });


});



function pass(pass) {
    var re = /^(?=.*[A-Z])(?=)(?=.*[0-9])(?=.).{6,}$/;
    if (pass.match(re)) {
        return true;
    } else {
        return false;
    }

}

function geocodeAddress(geocoder, resultsMap) {

    var address = document.getElementById('delivery_location').value;
    geocoder.geocode({
        'address': address, componentRestrictions: {
            country: 'KE'
        }
    }, function (results, status) {
        if (status === 'OK') {

            var string = "<br> <p>Click on a location below</p> <br>";
            //console.log(results);
            results.forEach(function (entry) {
                string = string + '<p style="border-color:black;padding: 1px;border-style: solid" onclick=\'selectlocation("' + String(entry['formatted_address']) + '");\'>' + String(entry['formatted_address']) + '</p>';


            });
            $('#suggesstion-box').show();
            $('#suggesstion-box').html(string);
            //.log(string);
        } else {
            $('#suggesstion-box').html("Not Found, Try different search words");
        }
    });
}

function selectlocation(val) {

    $("#delivery_location").val(val);
    $("#sel_loc").val(val);
    $("#suggesstion-box").hide();
    $("#process").attr("value", "Processing ... ");
    $.ajax({
        type: 'POST',
        url: 'https://maps.googleapis.com/maps/api/geocode/json?address=' + val + '&key=AIzaSyAymkYR_w0NJSr-bn_N5BQ4vzdseuCMmsM',
        success: function (result) {
            results = result['results'];
            //console.log(result);

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
    $('#suggesstion-box').html("<br><br><p style='color: blue'>Please Wait. Searching for location ...</p>");
    setTimeout(function () {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 8,
            center: {lat: -34.397, lng: 150.644}
        });
        var geocoder = new google.maps.Geocoder();
        geocodeAddress(geocoder, map);
    }, 1000);
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

function phonecheck(phonenumber) {
    //var phoneno = /^(?:(?:254|\+254|0)?(07(?:(?:[12][0-9])|(?:0[0-8])|(9[0-2]))[0-9]{6})|(?:254|\+254|0)?(7(?:(?:[3][0-9])|(?:5[0-6])|(8[5-9]))[0-9        ]{6})    |(?:254|\+254|0)?(77[0-6][0-9]{6})|(?:254|\+254|0)?(76[34][0-9]{6}))$/;
    var phoneno = /^(2547)([0-9|7])(\d){7}$/;
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

    if (full_name != "" && phonenumbers(phone) && valmail(email)) {
        if ($("#auto").is(':checked')) {
            $(".warn_fill_fields").html("<p style='color: green'>Type below to search for your nearest location</p>");
        } else {
            $(".warn_fill_fields").html("");
        }
        $("#delivery_location").removeAttr("disabled");
    } else {
        if ($("#auto").is(':checked')) {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name, Email and Phone Number First!</p>");
        } else {
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
        $("#phone_prev").html("");
    }
}

function val_phone2() {
    phoneno = $("#client_account_b2c").val();
    if (!phonecheck(phoneno)) {
        $("#phone_prev").html("<p style='color:red;'>This is not a valid phone number, use the format 2547XXXXXXXX</p>")
    } else {
        $("#phone_prev").html("");
    }
}

function val_email() {
    if (!valmail(email)) {
        $("#email_prev").html("<p style='color:red;'>Email is not a valid email address</p>");
    } else {
        $("#email_prev").html("");
    }
}

function finalize() {
    full_name = $("#ship_full_name").val();
    phone = $("#ship_phone_number").val();
    email = $("#ship_email").val();
    //delivery_type = $("#delivery").val();
    delivery_order = $("#delivery_order").val();
    lat = $("#lat").val();
    lng = $("#long").val();
    instructions = $("#instructions").val();
    coupon = $("#coupon").val();
    address = $("#ship_address").val();

    if ($("#auto").is(':checked')) {
        delivery_amount = $("#delivery_amount").val();
    } else if ($("#manual").is(':checked')) {
        delivery_amount = $("input[name='del_opt']:checked").val();

    } else if ($("#collection").is(':checked')) {
        delivery_amount = 0;
    }

    if ($("#auto").is(':checked')) {
        delivery_location = $("#sel_loc").val();
    } else if ($("#manual").is(':checked')) {
        delivery_location = $("input[name='del_opt']:checked").attr("area");
    } else if ($("#collection").is(':checked')) {
        delivery_location = $("#collection_point").val();
    }


    $.ajax({
        url: '/carts/update_shipping',
        method: 'post',
        data: {
            amount: delivery_amount,
            orderid: delivery_order,
            type: $("input[name='delivery']:checked").val(),
            email: $("#ship_email").val(),
            name: $("#ship_full_name").val(),
            phone: $("#ship_phone_number").val(),
            delivery_location: delivery_location,
            lat: lat,
            lng: lng,
            instructions: instructions,
            coupon: coupon,
            address: address
        },

        success: function () {
            $('.ship_form').attr('disabled', 'true');
            $("#process").attr('style', "display:none;margin-top: 1em");
            $("#edit").attr('style', "display:block;margin-top: 1em");
            $("#complete").removeAttr("disabled");
        }
    });
}

function collect() {
    if ($("#collection").is(':checked')) {
        if (full_name != "" && phonenumbers(phone)) {
            $.ajax({
                url: '/carts/collection',
                success: function (res) {
                    $(".delivery_options").html(res);
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
                    $(".delivery_options").html(res);
                }
            });
        } else {
            $(".warn_fill_fields").html("<p style='color: red'>Fill your Name and Phone Number First!</p>");
            $(".delivery_options").html("");
        }
    }
}

function _manual_() {
    if ($("input:radio[name=delivery]").val() != "") {
        if ($("#other").is(':checked')) {
            if ($("#instructions").val() != "") {
                $("#process").removeAttr("disabled");
            } else {
                $("#process").attr("disabled", "true");
            }
        } else {
            $("#process").removeAttr("disabled");
            $(".select_instructions").html('');
            $("#instructions").val('');
        }
    }
}

function b2c_val() {
    client_name = $("#client_name_b2c").val();
    client_account = $("#client_account_b2c").val();
    amount = $("#amount_b2c").val();

    if (client_name != "" && phonecheck(client_account) && (amount != "" && $.isNumeric(amount) && parseInt(amount) != 0 && parseInt(amount) > 0)) {
        $("#b2c").removeAttr("disabled");
        $("#b2c").removeAttr("style");
    } else {
        $("#b2c").attr("disabled", "true");
        $("#b2c").attr("style", "background-color: grey;color: white");
    }
}

function b2bpay_val() {
    client_name = $("#client_name_pay").val();
    client_account = $("#client_account_pay").val();
    amount = $("#amount_pay").val();

    if (client_name != "" && (client_account != "" && $.isNumeric(client_account)) && (amount != "" && $.isNumeric(amount) && parseInt(amount) != 0)) {
        $("#b2bpay").removeAttr("disabled");
    } else {
        $("#b2bpay").attr("disabled", "true");
    }
}

function b2btill_val() {
    client_name = $("#client_name_till").val();
    client_account = $("#client_account_till").val();
    amount = $("#amount_till").val();

    if (client_name != "" && (client_account != "" && $.isNumeric(client_account)) && (amount != "" && $.isNumeric(amount) && parseInt(amount) != 0)) {
        $("#b2btill").removeAttr("disabled");
    } else {
        $("#b2btill").attr("disabled", "true");
    }
}

function eft_val() {
    client_name = $("#client_name_eft").val();
    client_account = $("#client_account_eft").val();
    amount = $("#amount_eft").val();
    bank_code = $("#bank_code").val();

    if (client_name != "" && (bank_code != "" && $.isNumeric(bank_code)) && (client_account != "" && $.isNumeric(client_account)) && (amount != "" && $.isNumeric(amount) && parseInt(amount) != 0)) {
        $("#eft").removeAttr("disabled");
    } else {
        $("#eft").attr("disabled", "true");
    }
}

function set_max(post) {
    max = $('.charge', '.conditions_' + post).attr('data');
    amt = $("#amount_" + post).val();
    full = $(".charge", '.conditions_' + post).attr('data-full');
    if (parseInt(amt) > parseInt(max)) {
        $("#amount_" + post).val(max);
    }
}

function set_bal(post) {
    max = $('.charge', '.conditions_' + post).attr('data');
    amt = $("#amount_" + post).val();
    full = $(".charge", '.conditions_' + post).attr('data-full');

    if (amt == "") {
        $('.charge', '.conditions_' + post).html("0");
    } else if (parseInt(amt) > 500) {
        $('.charge', '.conditions_' + post).html("Ksh: " + (parseInt(45) + parseInt(parseFloat(amt) * 0.01)));
        $('.bal', '.conditions_' + post).html("Ksh: " + (parseInt(full) - (parseInt(amt) + (45 + parseInt(amt * 0.01)))));
    } else {
        bal = (parseInt(full) - (parseInt(amt) + (52 + parseInt(amt * 0.01))));
        $('.charge', '.conditions_' + post).html("Ksh: " + (52 + parseInt(parseFloat(amt) * 0.01)));
        if (bal <= 0) {
            bal = 0;
            $('.charge', '.conditions_' + post).html("Ksh: 0");
        }

        $('.bal', '.conditions_' + post).html("Ksh: " + bal);
    }
}

function check_num(post) {
    amt = $("#amount_" + post).val();

    if ($.isNumeric(amt) && amt > 0) {
        $("#amount_prev_" + post).html("");
    } else {
        $("#amount_prev_" + post).html("<p style='color: red'>Amount must be a number and greater than zero</p>");
    }
}

function val_b2bpay() {
    val = $("#client_account_pay").val();
    if ($.isNumeric(val)) {
        $(".pay_acc_prev").html("")
    } else {
        $(".pay_acc_prev").html("<p style='color: red'>Paybill is a Number!</p>")
    }
}

function val_b2btill() {
    val = $("#client_account_till").val();
    if ($.isNumeric(val)) {
        $(".till_acc_prev").html("")
    } else {
        $(".till_acc_prev").html("<p style='color: red'>Till Number is a Number!</p>")
    }
}

function val_eft() {
    val = $("#client_account_eft").val();
    if ($.isNumeric(val)) {
        $(".eft_acc_prev").html("")
    } else {
        $(".eft_acc_prev").html("<p style='color: red'>Account Number must be a Number!</p>")
    }
}

function val_eft2() {
    val = $("#bank_code").val();
    if ($.isNumeric(val)) {
        $(".code_acc_prev").html("")
    } else {
        $(".code_acc_prev").html("<p style='color: red'>Bank code is a five digit number!</p>")
    }
}

function user_reg() {
    user_name = $("#user_name").val();
    user_email = $("#user_email").val();
    user_password = $("#user_password").val();
    user_password_confirmation = $("#user_password_confirmation").val();

    if (user_name.length > 3 && valmail(user_email) && pass(user_password) && $("#user_email").attr('data-valid') == 'true' && $("#user_password_confirmation").attr('data-valid') == 'true') {
        $("#user_sign_up").removeAttr("disabled");
        $("#user_sign_up").removeAttr("style");
    } else {
        $("#user_sign_up").attr("disabled", "true");
        $("#user_sign_up").attr("style", 'color:white;background-color:grey');

    }
}

function valmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if (email.match(re)) {
        return true;
    } else {
        return false;
    }
}


function store_reg() {

    store_name = $("#store_name").val();
    url = $("#url").val();
    email = $("#store_email").val();

    //setTimeout(console.log('timeout'),1000);

    if (store_name.length > 3 && url.length > 2 && $("#store_email").attr('data-valid') == 'true' && $("#url").attr('data-valid') == 'true') {
        $('#nxtBtn').prop("disabled", false);
        $('#nxtBtn').removeAttr("style");
    } else {
        //alert(false);
        $("#nxtBtn").attr("disabled", "true");
        $("#nxtBtn").attr("style", "background-color:grey;color:#000;border-color: grey;");

    }
}

function store_reg2() {
    store_phone = $("#store_phone").val();
    store_password = $("#store_password").val();
    store_password_confirmation = $("#store_password_confirmation").val();
    if (phonecheck(store_phone) && pass(store_password) && pass(store_password_confirmation) && $("#store_password_confirmation").attr('data-valid') == 'true') {
        $("#submitter").removeAttr("disabled");
        $("#submitter").removeAttr("style");
        $("#submitter").off("click");
    } else {
        $("#submitter").attr("disabled", "true");
        $("#submitter").attr("style", "background-color:grey;color:#000;border-color: grey;");
    }

}

function store_change_reg() {
    password = $("#changepass").val();
    passwordc = $("#changepassconf").val();
    email = $("#changemail").val();
    curr = $("#currentpass").val();
    if ((password == passwordc && pass(password) && valmail(email)) || (password == "" && passwordc == "" && valmail(email) && curr != "")) {
        $("#changebtn").removeAttr("disabled");
    } else {
        $("#changebtn").attr("disabled", "disabled");
    }

}

function validateEmail(email) {
    var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;

    if (regex.test(email)) {

        $.ajax({
            url: '/users/checkmail',
            data: {
                email: email
            },
            method: 'post',
            success: function (res) {
                $("#email_prev").html(res);
                if (res == "<span style='color:green'>Available</span>") {
                    $("#store_email").attr('data-valid', 'true');
                    $("#store_email").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
                } else {
                    $("#store_email").attr('data-valid', 'false');
                }
            }
        });
    } else {
        $("#email_prev").html("<span style='color:red' >This is not a valid email</span>");
        $("#store_sign_up").attr("disabled", "true");
    }

}

function validateEmail2(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (email.match(re)) {
        $.ajax({
            url: '/users/checkmail_user',
            data: {
                email: email
            },
            method: 'post',
            success: function (res) {
                //alert(res);

                if (res == "<span style='color:green'>Available</span>") {
                    $("#user_email").attr('style', 'text-align:center;border-bottom-color: green;box-shadow: 0 2px 2px -2px #008000;');
                    $(".user_email_prev").html(res);
                    $("#user_email").attr('data-valid', 'true');
                } else {
                    $(".user_email_prev").html(res);
                    $("#user_email").attr('style', 'text-align:center;border-bottom-color: red;box-shadow: 0 2px 2px -2px #FF0000;');
                    $("#user_email").attr('data-valid', 'false');
                }
            }
        });
    } else {
        $(".user_email_prev").html("<span style='color:red' >This is not a valid email</span>");
        $("#user_email").attr('data-valid', 'false');
    }
}

function res_check() {
    if ($("#pass_store").attr('data-valid') == 'true' && $("#store_pass_confirmation").attr('data-valid') == 'true') {
        $("#reseter").removeAttr('disabled');
        $("#reseter").removeAttr('style');
    } else {
        $("#reseter").attr('disabled', 'true');
        $("#reseter").attr('style', 'background-color:grey');
    }
}

function showTab(n) {
    // This function will display the specified tab of the form ...
    var x = document.getElementsByClassName("tab");
    console.log(x);
    x[n].style.display = "block";
    // ... and fix the Previous/Next buttons:
    if (n == 0) {
        document.getElementById("prevBtn").style.display = "none";
    } else {
        document.getElementById("prevBtn").style.display = "inline";
    }
    if (n == (x.length - 1)) {
        document.getElementById("nxtBtn").innerHTML = "Submit";
        $("#nxtBtn").attr('id', 'submitter');
        $("#submitter").attr('disabled', 'true');
        $("#submitter").attr('type', 'submit');
        $("#submitter").attr("style", "background-color:grey;color:#000;border-color: grey;");
        $("#submitter").removeAttr("onclick");
        store_reg2();
    } else {

        if ($("#nxtBtn")) {
            $("#submitter").attr('id', 'nxtBtn');
            $("#nxtBtn").attr('onclick', 'nextPrev(1)');
            document.getElementById("nxtBtn").innerHTML = "Next";
            store_reg();

        }
    }
    // ... and run a function that displays the correct step indicator:
    fixStepIndicator(n)
}

function nextPrev(n) {
    // This function will figure out which tab to display
    var x = document.getElementsByClassName("tab");
    // Exit the function if any field in the current tab is invalid:
    if (n == 1 && !validateForm()) return false;
    // Hide the current tab:
    x[currentTab].style.display = "none";
    // Increase or decrease the current tab by 1:
    currentTab = currentTab + n;
    // if you have reached the end of the form... :
    if (currentTab >= x.length) {
        //...the form gets submitted:
        document.getElementById("regForm").submit();
        return false;
    }
    // Otherwise, display the correct tab:
    showTab(currentTab);
}

function validateForm() {
    // This function deals with validation of the form fields
    var x, y, i, valid = true;
    x = document.getElementsByClassName("tab");
    y = x[currentTab].getElementsByTagName("input");
    // A loop that checks every input field in the current tab:
    for (i = 0; i < y.length; i++) {
        // If a field is empty...
        if (y[i].value == "") {
            // add an "invalid" class to the field:
            y[i].className += " invalid";
            // and set the current valid status to false:
            valid = false;
        }
    }
    // If the valid status is true, mark the step as finished and valid:
    if (valid) {
        document.getElementsByClassName("step")[currentTab].className += " finish";
    }
    return valid; // return the valid status
}

function fixStepIndicator(n) {
    // This function removes the "active" class of all steps...
    var i, x = document.getElementsByClassName("step");
    for (i = 0; i < x.length; i++) {
        x[i].className = x[i].className.replace(" active", "");
    }
    //... and adds the "active" class to the current step:
    x[n].className += " active";
}

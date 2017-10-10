// call this from the developer console and you can control both instances

$(document).ready(function () {

    $('.colorpicker').colorpicker();

    $('.colorpicker').on('changeColor', function(ev) {

        $('#clrbx').css("background-color", ev.color.toHex());
    });


    $('#example').DataTable();
    $('#myTable').DataTable();

    if ($("#delivery_status").val() == 1) {
        $(".locate").attr('disabled', 'true');
    }

    $("#deliveryswitch").change(function () {
        if (this.checked) {
            $(".locate").removeAttr('disabled');
        } else {

            $(".locate").attr('disabled', 'true');
        }
    });

    $("#collectswitch").change(function () {
        if (this.checked) {
            $(".collect").removeAttr('disabled');
        } else {
            $(".collect").attr('disabled', 'true');
        }
    });

    $("#manualswitch").change(function () {
        if (this.checked) {
            $(".manual").removeAttr('disabled');
        } else {
            $(".manual").attr('disabled', 'true');
        }
    });

    $("#url").keyup(function () {
        url = $("#url").val()

        $.ajax({
           url:'/users/remote_santize',
            data:{
               url:url
            },
            method:'post',
            success:function (res) {
               //alert(res);
                $("#url_prev").html(res)
            }
        });
    });

    $("#s_email").keyup(function () {
        email = $("#s_email").val()
        validateEmail(email)

    });
});

function validateEmail(email) {
    var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

    if (email.match(re)) {
        $.ajax({
            url:'/users/checkmail',
            data:{
                email:email
            },
            method:'post',
            success:function (res) {
                //alert(res);
                $("#email_prev").html(res)
            }
        });
    } else {
        $("#email_prev").html("<span style='color:red' >This is not a valid email</span>")
    }
}

// call this from the developer console and you can control both instances

$(document).ready(function () {

    $('.colorpicker').colorpicker();

    $('.colorpicker').on('changeColor', function(ev) {

        $('#clrbx').css("background-color", ev.color.toHex());
    });


    $('#example').DataTable();
    $('#myTable').DataTable();
    $('#myTable2').DataTable();
    $('#data-tables').DataTable();

    /*$('#mySortTable').DataTable({
        aaSorting: [[4, 'asc']]
    });*/

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

    $("#store_email").keyup(function () {
        email = $("#store_email").val()
        validateEmail(email)

    });


});


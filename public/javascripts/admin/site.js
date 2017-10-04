// call this from the developer console and you can control both instances

$(document).ready(function () {

    $('#store_color').colorpicker();

    $('#example').DataTable();
    $('#myTable').DataTable();

    if ($("#delivery_status").val() == 1) {
        $(".locate").attr('disabled', 'true');
    }

    $("#deliveryswitch").change(function () {
        if (this.checked) {
            $(".locate").attr('disabled', 'true');
            $("#thedrop").removeAttr('disabled');
        } else {
            $(".locate").removeAttr('disabled');
            $("#thedrop").attr('disabled', 'true');
        }
    });
});
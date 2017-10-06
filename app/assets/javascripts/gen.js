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
});

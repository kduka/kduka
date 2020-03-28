/**
 * Created by root on 11/2/17.
 */



    $(function () {

      function validate_contact_inputs(thename,email,subject,message) {

      if(thename.length<1){
        return false;
      }
      if(subject.length<1){
        return false;
      }
      if(message.length<1){
        return false;
      }

      var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      if(re.test(email)){
        return re.test(email);
      }else{
        return false;
      }

    }

    $('#nxtBtn').prop('disabled', true);


    $("#sendmail").click(function (e) {
      $('#loader').fadeIn('slow');


        e.preventDefault();

        thename = $("#name").val();
        email = $("#email").val();
        subject = $("#subject").val();
        message = $("#message").val();

        if(validate_contact_inputs(thename,email,subject,message) ){
          var recaptcha = $("#g-recaptcha-response").val();
          if (recaptcha === "") {
            swal({
              toast: true,
              position: 'top-end',
              button: false,
              title: "Please Check the reCaptcha",
              text: "",
              icon: "warning",
              button: false,
              timer: 2000
            });
            $('#loader').fadeOut('slow');
          }else{
            $.ajax({
            url: '/home/web_mail',
            method: 'post',
            data: {
                name: thename,
                email: email,
                subject: subject,
                message: message
            },
            success: function (e) {

                if (e == 'true') {
                    swal({
                      toast: true,
                      position: 'top-end',
                      button: false,
                      title: "Message Sent Successfully",
                      text: "",
                      icon: "success",
                      button: false,
                      timer: 2000
                    });
                    // $("#success").html("<p style='color: green;font-size: 17px;'>Email Sent! We'll get back to you shortly!</p>");
                    $("#name").val('');
                    $("#email").val('');
                    $("#subject").val('');
                    $("#message").val('');
                    $("#sendmail").removeAttr("disabled");
                    $('#loader').fadeOut('slow');
                } else {
                    swal({
                      toast: true,
                      position: 'top-end',
                      button: false,
                      title: "Something went wrong! please try again",
                      text: "",
                      icon: "error",
                      button: false,
                      timer: 2000
                    });
                    // $("#success").html("<p style='color: red;font-size: 17px;'>Something went wrong! please try calling us</p>");
                    $("#sendmail").removeAttr("disabled");
                    $('#loader').fadeOut('slow');
                }
            }
        });
          }
        }else{
          swal({
            toast: true,
            position: 'top-end',
            button: false,
            title: "Please Fill All Fields Correctly",
            text: "",
            icon: "warning",
            button: false,
            timer: 2000
          });
          $('#loader').fadeOut('slow');
        }
    });

});

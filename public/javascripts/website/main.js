/**
 * Created by root on 11/2/17.
 */



$(function () {

    $('#nxtBtn').prop('disabled', true);

    $("#regForm").submit(function (e) {
        e.preventDefault();
    });


    $("#submitter").click(function (event) {
            event.preventDefault();
            alert("processing...");
        });


    $("#sign").click(function (e) {
        $.ajax({
            url: '/stores/signup',
            method: 'get',
            success: function (d) {
                $("#signup_modal").html(d);
            }
        });
    });

    $("#sendmail").click(function (e) {


        e.preventDefault();

        thename = $("#name").val();
        email = $("#email").val();
        subject = $("#subject").val();
        message = $("#message").val();

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
                    $("#success").html("<p style='color: green;font-size: 17px;'>Email Sent! We'll get back to you shortly!</p>");
                    $("#name").val('');
                    $("#email").val('');
                    $("#subject").val('');
                    $("#message").val('');
                    $("#sendmail").removeAttr("disabled");
                } else {
                    $("#success").html("<p style='color: red;font-size: 17px;'>Something went wrong! please try calling us</p>");
                    $("#sendmail").removeAttr("disabled");
                }
            }
        });
    });

});

var currentTab = 0; // Current tab is set to be the first tab (0)
showTab(currentTab); // Display the current tab

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
        $("#nxtBtn").attr('id','submitter');
        $("#submitter").attr('disabled','true');
        $("#submitter").attr("style", "background-color:grey;color:#000;border-color: grey;");
    } else {

        if($("#nxtBtn")){
            $("#submitter").attr('id','nxtBtn');
            document.getElementById("nxtBtn").innerHTML = "Next";

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
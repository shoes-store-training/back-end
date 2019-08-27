$(document).ready(function()  {
    // change avatar 
    var readURL = function(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('.avatar').attr('src', e.target.result);
            }
    
            reader.readAsDataURL(input.files[0]);
        }
    }
    $(".file-upload").on('change', function(){
        readURL(this);
    });
    
    $(".upload-button").on('click', function() {
        $(".file-upload").click();
    });
    
    //button option
    $(".btn-save").click(function () {
        document.getElementsByClassName("username").innerHTML = full_name.value;     
    });

    // $('.form-control').click(function() {
    //     com_text = $(this).attr('class');
    // });

    $('.btn-edit').click(function() {
        $(this).hide();
        $(this).siblings('.btn-save, .btn-cancel').show();
        $('.input-text').hide();
        $(".form-control-hidden").show();
        // $(com_text).val($('.form-control').text().trim()); 
    });

    $('.btn-cancel').click(function() {
        $(this).siblings('.btn-edit').show();
        $(this).siblings('.btn-save').hide();
        $(this).hide();
        $('.input-text').show();
        $(".form-control-hidden").hide();
        $(".error").hide();
        // $(com_text).hide();
		// $(com_text).val('');
    });

    $('.btn-save').click(function() {
        $(".pr-content").validate({
            errorPlacement: function(error, element) {
                if (element.attr("name") == "gender" )
                    error.insertAfter(".row");
                else
                    error.insertAfter(element);
            },
            rules: {
                full_name: "required",
                phone_number: {
                    required: true,
                    digits: true,
                    minlength: 10,
                },
                email: {
                    required: true,
                    email: true
                },
                gender: {
                    required: true
                }
            },
            messages: {
                full_name: "Please enter a full name.",
                phone_number: {
                    required: "Please enter a phone number.",
                    digits: 'Please enter a <em>valid</em> phone number.',
                    minlength: 'Please enter a <em>valid</em> phone number.'
                },
                email: {
                    required: "Please enter an email.",
                    email: 'Please enter a <em>valid</em> email address.'
                },
                gender: {
                    required: "Please check this field."
                }
            },
            submitHandler: function(form) {
                $('.input-text').show();
                $(".form-control-hidden").hide();
                $(this).siblings('.btn-edit').show();
                $(this).siblings('.btn-cancel').hide();
                $(this).hide();
                var sname = $('.form-control').val().trim();
                alert(sname);
                $('.input-text > span').text(sname);
                form.submit(); 
            }
        });
        
    });
});


<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>

</head>
<body>

<main class="d-flex align-items-center" style="height: 100vh;">

    <div class="container">
        <div class="row mb-2">
            <div class="col-md-4 offset-md-4">
                <div class="card" style="width: 18rem;">

                    <div class="card-header">
                        Login Form
                    </div>
                    <div class="card-body">
                        <form action="register" method="POST" id="reg-form">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" name="username" class="form-control" id="username"
                                       aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input type="email" name="email" class="form-control" id="email"
                                       aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" id="password">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">About Yourself</label>
                                <textarea name="about" class="form-control" id="exampleInputPassword1"></textarea>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="radio" name="gender" value="male" class="form-check-input"
                                       id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Male</label><br>
                                <input type="radio" name="gender" value="female" class="form-check-input"
                                       id="exampleCheck2">
                                <label class="form-check-label" for="exampleCheck2">Female</label>
                            </div>
                            <div class="mb-3 form-check">
                                <input type="checkbox" name="acceptTerms" value="true" class="form-check-input"
                                       id="exampleCheck3">
                                <label class="form-check-label" for="exampleCheck3">Accept Terms & Conditions</label>
                            </div>
                            <div class="container text-center" id="loader" style="display: none">
                                <span class="fa fa-refresh fa-spin fa-2x"></span>
                                <h4>Please wait...</h4>
                            </div>
                            <button type="submit" class="btn btn-primary" id="submit-btn">Submit</button>
                            <a href="login.jsp">Login</a>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
        integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script>
    $(document).ready(function () {
        console.log("...loaded")

        $("#reg-form").on("submit", function (event) {
            event.preventDefault();

            let formData = new FormData(this);

            $("#loader").show();
            $("#submit-btn").hide();
            $.ajax({
                url: "register",
                type: 'POST',
                data: formData,
                success: function (data, status, jqXHR) {
                    console.log(data)
                    if(data.trim() == "done"){
                    swal("Success!", "Data saved successfully!!", "success")
                        .then((value) => {
                            window.location = "login.jsp";
                        });
                    } else {
                        swal("Failed!", data, "error")
                    }
                    $("#loader").hide();
                    $("#submit-btn").show();
                },
                error: function (jqXHR, status, errorThrown) {
                    console.log(jqXHR);
                    $("#loader").hide();
                    $("#submit-btn").show();
                    swal("Failed!", "Something went wrong!", "error")
                },
                processData: false,
                contentType: false

            });
        });
    });
</script>
</body>
</html>

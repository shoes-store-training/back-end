<%-- 
    Document   : view-edit-profile-user
    Created on : Aug 28, 2019, 6:02:15 PM
    Author     : Dell Inspiron14
--%>
<%@page import="model.bean.Account"%>
<%
    Account acc = (Account) session.getAttribute("account");
    boolean isSaved = acc.isIsSaved();
    String fullName = acc.getFullName();
    String phoneNumber = acc.getPhoneNumber();
    String email = acc.getEmail();
    String gender;
    if (acc.getGender().equals("1")) {
        gender = "Male";
    } else if (acc.getGender().equals("2")) {
        gender = "Female";
    } else {
        gender = "No gender";
    }
    String address = acc.getAddress();
%>
<script language="javascript">
    var gender = '<%=gender%>';
    var isSaved = '<%=isSaved%>';
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>View profile details</title>
        <link rel="stylesheet" href="css/view-profile.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous" />
        <link href="https://fonts.googleapis.com/css?family=Exo&display=swap" rel="stylesheet">
    </head>
    <body>
        <header id="header"></header>
        <div class="profile-wrap">
            <div class="pr-container">
                <div class="pr-menu-left">
                    <div class="profiles">
                        <p class="pr-avatar">
                            <img src="img/avatar.jpg" style="height: 45px; width: 45px;" alt="avatar" class="avatar">
                        </p>
                        <h6 class="username">Name</h6>
                    </div>
                    <ul class="pr-sub-menu">
                        <li class="active">
                            <a href="#"><i class="fas fa-user"></i>Profile</a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-shopping-cart"></i>Shopping list</a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-store"></i>Track orders</a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-comment-dots"></i>All reviews</a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-tags"></i>Vouchers and Promotions</a>
                        </li>
                    </ul>
                </div>
                <div class="pr-content-right">
                    <h1 class="pr-title-profile">Profile</h1>
                    <div class="account-profile">
                        <div class="profile-content">
                            <form action="EditProfileUserServlet" method="post" id="pr-content">
                                <div class="form-group">
                                    <div class="">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <label for="first_name" class="control-label">First name<span style="color: red;">*</span></label>
                                                <div class="name-wrap">
                                                    <label class="input-text">
                                                        <span>No First name</span>
                                                    </label>
                                                    <input type="text" name="first_name" id="first_name" class="form-control  form-control-hidden half-form-control" value="" placeholder="First name">
                                                </div>
                                            </div>
                                            <div class="col-xs-6">
                                                <label for="last_name" class="control-label">Last name<span style="color: red;">*</span></label>
                                                <div class="name-wrap">
                                                    <label class="input-text">
                                                        <span>No Last name</span>
                                                    </label>
                                                    <input type="text" name="last_name" id="last_name" class="form-control  form-control-hidden half-form-control" value="" placeholder="Last name">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="help-block" id="name-error"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="phone_number" class="control-label">Phone number<span class="red-star">*</span></label>
                                    <div class="input-wrap">
                                        <label class="input-text">
                                            <span><%=phoneNumber%></span>
                                        </label>
                                        <input type="text" name="phone_number" id="phone_number" class="form-control form-control-hidden" value placeholder="<%=phoneNumber%>">
                                        <div class="help-block" id="phone-error"></div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="email" class="control-label">Email<span class="red-star">*</span></label>
                                    <div class="input-wrap">
                                        <label class="input-text">
                                            <span><%=email%></span>
                                        </label>
                                        <input type="text" name="email" id="email" class="form-control form-control-hidden" value placeholder="<%=email%>">
                                        <div class="help-block" id="email-error"></div>
                                    </div>
                                </div>
                                <div class="form-group gender-select-wrap" id="register_name">
                                    <label class="control-label" for="gender">Gender</label>
                                    <div class="input-wrap">
                                        <label class="input-text">
                                            <span><%=gender%></span>
                                        </label>
                                        <div class="form-control-hidden input-radio">
                                            <div class="col-xs-4">
                                                <label>
                                                    <input type="radio" name="gender" value="on" id="gender_male" class="gender">Male
                                                </label>
                                                <span class="selected"></span>
                                            </div>
                                            <div class="col-xs-4">
                                                <label>
                                                    <input type="radio" name="gender" value="off" id="gender_female" class="gender">Female
                                                </label>
                                                <span class="selected"></span>
                                            </div>
                                        </div>
                                        <div class="help-block"></div>
                                    </div>
                                </div>
                                <div class="form-group ">
                                    <label class="control-label no-lh" for="birthday">
                                        Date of birth
                                    </label>
                                    <div class="input-wrap">
                                        <label class="input-text">
                                            <span>No Date of birth</span>
                                        </label>
                                        <input id="birthday-picker" class="birthday-picker form-control-hidden form-control" type='date' min='1899-01-01' max='2019-01-01'></input>
                                        <span class="help-block"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="control-label">Address</label>
                                    <div class="input-wrap">
                                        <label class="input-text">
                                            <span><%=address%></span>
                                        </label>
                                        <input type="text" name="address" id="address" class="form-control form-control-hidden" value placeholder="<%=address%>">
                                        <span class="help-block"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <a class="change-pw" href="#">Change password</a>
                                </div>
                                <div class="btn-center">
                                    <button id="edit-btn" class="btn btn-edit" type="button" onclick="displayEditForm()">Edit profile</button>
                                    <button id="save-btn" name="save-btn" value="save" class="btn btn-save" type="submit" onclick="hideEditForm()">Save</button>
                                     <button id="cancel-btn" name="cancel-btn" value="cancel" class="btn btn-cancel" type="submit" onclick="hideEditForm()">Cancel</button>
                                    <button id="reset-btn" class="btn btn-reset" type="reset" onclick="resetForm()">Reset</button>
                                </div>
                            </form>
                            <div id="change-ava">
                                <div id="set-ava">
                                    <h3>Change avatar</h3>
                                    <div class="img-center">
                                        <div id="uploadAvatar">
                                            <div class="imageBox">
                                                <img id="thumbBox" src="img/avatar.jpg"></img>
                                                <div class="spinner">No Avatar</div>
                                            </div>
                                            <div id="primary">
                                                <div class="setAvatar">
                                                    Change Avatar
                                                    <input type="file" accept="image/jpeg, image/png" onchange="loadFile(event)" class="chooseFile" value="Choose"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src='js/view-profile.js'></script>
</html>

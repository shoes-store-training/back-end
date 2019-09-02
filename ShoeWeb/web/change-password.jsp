<%-- 
    Document   : change-password
    Created on : Sep 2, 2019, 8:56:37 PM
    Author     : Dell Inspiron14
--%>
<%@page import="model.bean.Account"%>
<%
    Account acc = (Account) session.getAttribute("account");
    String oldPassWord = acc.getPassword();
%>
<script language="javascript">
    var oldPassWord = '<%=oldPassWord%>';
</script>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Change password</title>
        <link rel="stylesheet" href="css/change-pw.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
              integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous" />
        <link href="https://fonts.googleapis.com/css?family=Exo&display=swap" rel="stylesheet">
    </head>
    <body>
        <header id="header"></header>
        <div class="profile-wrap">
            <div class="pr-container">
                <div id="pr-menu-left"></div>
                <div class="pr-content-right">
                    <h1 class="pr-title-profile">Change password</h1>
                    <div class="account-profile">
                        <div class="profile-content">
                            <form action="ChangePassWordServlet" method="post"id="pr-content">
                                <div class="form-group">
                                    <label for="address" class="control-label">Current password</label>
                                    <div class="input-wrap">
                                        <input type="password" name="currentpw" id="current_pw" class="form-control" value placeholder="Current password">
                                        <span class="help-block" id="currentPw-error"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="control-label">New password</label>
                                    <div class="input-wrap">
                                        <input type="password" name="newpw" id="new_pw" class="form-control" value placeholder="New password">
                                        <span class="help-block" id="newPw-error"></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="address" class="control-label">Retype password</label>
                                    <div class="input-wrap">
                                        <input type="password" name="retypepw" id="retype_pw" class="form-control" value placeholder="Retype password">
                                        <span class="help-block" id="retypePw-error"></span>
                                    </div>
                                </div>
                                <div class="btn-center">
                                    <button id="cancel-btn" class="btn btn-cancel" type="button" onclick="backToViewPage()">Cancel</button>
                                    <button id="save-btn" class="btn btn-save" type="submit">Save</button>
                                    <button id="reset-btn" class="btn btn-reset" type="reset" onclick="resetForm()">Reset</button>
                                </div>
                            </form>          
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src='js/change-pw.js'></script>
</html>

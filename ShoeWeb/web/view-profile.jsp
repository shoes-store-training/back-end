<%-- 
    Document   : view-profile
    Created on : Aug 27, 2019, 8:36:07 PM
    Author     : Dell Inspiron14
--%>
<%@page import="model.bean.Account"%>
<%
    Account acc = (Account)request.getAttribute("account");
    String fullName = acc.getFullName();
    String phoneNumber = acc.getPhoneNumber();
    String email = acc.getEmail();
    String gender;
    if(acc.isGender() == true ) gender = "Male";
    else gender = "Female";
    String address = acc.getEmail();
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>View profile details</title>
    <link rel="stylesheet" href="css/view-profile.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
        integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous" />
    <link href="https://fonts.googleapis.com/css?family=Exo&display=swap" rel="stylesheet">
</head>
<body>
    <div class="profile-wrap">
        <div class="pr-container">
            <div class="pr-menu-left">
                <div class="profiles">
                    <p class="pr-avatar">
                        <img src="img/avatar.jpg" style="height: 45px; width: 45px;" alt="avatar" class="avatar">
                        <div class="upload-button">
                            <i class="fa fa-arrow-circle-up" aria-hidden="true"></i>
                        </div>
                        <input class="file-upload" type="file" accept="image/*"/>
                    </p>
                    <h6 class="username">Name</h6>
                </div>
                <ul class="pr-sub-menu">
                    <li class="active">
                        <a href="#"><i class="fas fa-user"></i>View profile</a>
                    </li>
                    <li>
                        <a href="#"><i class="fas fa-shopping-cart"></i>View shopping cart</a>
                    </li>
                </ul>
            </div>
            <div class="pr-content-right">
                <h1 class="pr-title-profile">Profile</h1>
                <div class="account-profile">
                    <form action="#" class="pr-content">
                        <div class="form-group">
                            <label for="full_name" class="control-label">Full name<span style="color: red;">*</span></label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span> <%=fullName%> </span>
                                </label>
                                <input type="text" name="full_name" id="full_name" class="form-control form-control-hidden" value="" placeholder="Full name">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone_number" class="control-label">Phone number<span style="color: red;">*</span></label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span><%=phoneNumber%></span>
                                </label>
                                <input type="text" name="phone_number" id="phone_number" class="form-control form-control-hidden" value placeholder="Phone number">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="control-label">Email<span style="color: red;">*</span></label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span><%=email%></span>
                                </label>
                                <input type="text" name="email" id="email" class="form-control form-control-hidden" value placeholder="Email">
                            </div>
                        </div>
                        <div class="form-group gender-select-wrap" id="register_name">
                            <label class="control-label" for="pasword">Gender<span style="color: red;">*</span></label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span><%=gender%></span>
                                </label>
                                <div class="row form-control-hidden">
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
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label no-lh" for="birthdate">
                                Date of birth
                            </label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span>No Date of birth</span>
                                </label>
                                <div id="birthday-picker" class="birthday-picker form-control-hidden">
                                    <fieldset class="birthday-picker">
                                        <select class="birth-day form-control" name="birth[day]">
                                            <option value="0">Day</option>
                                            <option value="1">1</option>
                                            <option value="2">2</option>
                                            <option value="3">3</option>
                                            <option value="4">4</option>
                                            <option value="5">5</option>
                                            <option value="6">6</option>
                                            <option value="7">7</option>
                                            <option value="8">8</option>
                                            <option value="9">9</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                            <option value="13">13</option>
                                            <option value="14">14</option>
                                            <option value="15">15</option>
                                            <option value="16">16</option>
                                            <option value="17">17</option>
                                            <option value="18">18</option>
                                            <option value="19">19</option>
                                            <option value="20">20</option>
                                            <option value="21">21</option>
                                            <option value="22">22</option>
                                            <option value="23">23</option>
                                            <option value="24">24</option>
                                            <option value="25">25</option>
                                            <option value="26">26</option>
                                            <option value="27">27</option>
                                            <option value="28">28</option>
                                            <option value="29">29</option>
                                            <option value="30">30</option>
                                            <option value="31">31</option>
                                        </select>
                                        <select class="birth-month form-control" name="birth[month]">
                                            <option value="0">Month</option>
                                            <option value="1">01</option>
                                            <option value="2">02</option>
                                            <option value="3">03</option>
                                            <option value="4">04</option>
                                            <option value="5">05</option>
                                            <option value="6">06</option>
                                            <option value="7">07</option>
                                            <option value="8">08</option>
                                            <option value="9">09</option>
                                            <option value="10">10</option>
                                            <option value="11">11</option>
                                            <option value="12">12</option>
                                        </select>
                                        <select class="birth-year form-control" name="birth[year]">
                                            <option value="0">Year</option>
                                            <option value="2019">2019</option>
                                            <option value="2018">2018</option>
                                            <option value="2017">2017</option>
                                            <option value="2016">2016</option>
                                            <option value="2015">2015</option>
                                            <option value="2014">2014</option>
                                            <option value="2013">2013</option>
                                            <option value="2012">2012</option>
                                            <option value="2011">2011</option>
                                            <option value="2010">2010</option>
                                            <option value="2009">2009</option>
                                            <option value="2008">2008</option>
                                            <option value="2007">2007</option>
                                            <option value="2006">2006</option>
                                            <option value="2005">2005</option>
                                            <option value="2004">2004</option>
                                            <option value="2003">2003</option>
                                            <option value="2002">2002</option>
                                            <option value="2001">2001</option>
                                            <option value="2000">2000</option>
                                            <option value="1999">1999</option>
                                            <option value="1998">1998</option>
                                            <option value="1997">1997</option>
                                            <option value="1996">1996</option>
                                            <option value="1995">1995</option>
                                            <option value="1994">1994</option>
                                            <option value="1993">1993</option>
                                            <option value="1992">1992</option>
                                            <option value="1991">1991</option>
                                            <option value="1990">1990</option>
                                            <option value="1989">1989</option>
                                            <option value="1988">1988</option>
                                            <option value="1987">1987</option>
                                            <option value="1986">1986</option>
                                            <option value="1985">1985</option>
                                            <option value="1984">1984</option>
                                            <option value="1983">1983</option>
                                            <option value="1982">1982</option>
                                            <option value="1981">1981</option>
                                            <option value="1980">1980</option>
                                            <option value="1979">1979</option>
                                            <option value="1978">1978</option>
                                            <option value="1977">1977</option>
                                            <option value="1976">1976</option>
                                            <option value="1975">1975</option>
                                            <option value="1974">1974</option>
                                            <option value="1973">1973</option>
                                            <option value="1972">1972</option>
                                            <option value="1971">1971</option>
                                            <option value="1970">1970</option>
                                            <option value="1969">1969</option>
                                            <option value="1968">1968</option>
                                            <option value="1967">1967</option>
                                            <option value="1966">1966</option>
                                            <option value="1965">1965</option>
                                            <option value="1964">1964</option>
                                            <option value="1963">1963</option>
                                            <option value="1962">1962</option>
                                            <option value="1961">1961</option>
                                            <option value="1960">1960</option>
                                            <option value="1959">1959</option>
                                            <option value="1958">1958</option>
                                            <option value="1957">1957</option>
                                            <option value="1956">1956</option>
                                            <option value="1955">1955</option>
                                            <option value="1954">1954</option>
                                            <option value="1953">1953</option>
                                            <option value="1952">1952</option>
                                            <option value="1951">1951</option>
                                            <option value="1950">1950</option>
                                            <option value="1949">1949</option>
                                            <option value="1948">1948</option>
                                            <option value="1947">1947</option>
                                            <option value="1946">1946</option>
                                            <option value="1945">1945</option>
                                            <option value="1944">1944</option>
                                            <option value="1943">1943</option>
                                            <option value="1942">1942</option>
                                            <option value="1941">1941</option>
                                            <option value="1940">1940</option>
                                            <option value="1939">1939</option>
                                            <option value="1938">1938</option>
                                            <option value="1937">1937</option>
                                            <option value="1936">1936</option>
                                            <option value="1935">1935</option>
                                            <option value="1934">1934</option>
                                            <option value="1933">1933</option>
                                            <option value="1932">1932</option>
                                            <option value="1931">1931</option>
                                            <option value="1930">1930</option>
                                            <option value="1929">1929</option>
                                            <option value="1928">1928</option>
                                            <option value="1927">1927</option>
                                            <option value="1926">1926</option>
                                            <option value="1925">1925</option>
                                            <option value="1924">1924</option>
                                            <option value="1923">1923</option>
                                            <option value="1922">1922</option>
                                            <option value="1921">1921</option>
                                            <option value="1920">1920</option>
                                            <option value="1919">1919</option>
                                            <option value="1918">1918</option>
                                            <option value="1917">1917</option>
                                            <option value="1916">1916</option>
                                            <option value="1915">1915</option>
                                            <option value="1914">1914</option>
                                            <option value="1913">1913</option>
                                            <option value="1912">1912</option>
                                            <option value="1911">1911</option>
                                            <option value="1910">1910</option>
                                            <option value="1909">1909</option>
                                            <option value="1908">1908</option>
                                            <option value="1907">1907</option>
                                            <option value="1906">1906</option>
                                            <option value="1905">1905</option>
                                            <option value="1904">1904</option>
                                            <option value="1903">1903</option>
                                            <option value="1902">1902</option>
                                            <option value="1901">1901</option>
                                            <option value="1900">1900</option>
                                        </select>
                                    </fieldset>
                                </div>
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="address" class="control-label">Address</label>
                            <div class="input-wrap">
                                <label class="input-text">
                                    <span><%=address%></span>
                                </label>
                                <input type="text" name="address" id="address" class="form-control form-control-hidden" value placeholder="Address">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <a class="change-pw" href="#">Change password</a>
                        </div>
                        <div class="form-group btn-center">
                            <button id="edit-btn" class="btn btn-edit" type="summit">Edit profile</button>
                            <button id="save-btn" class="btn btn-save" type="summit">Save</button>
                            <a id="cancel-btn" class="btn btn-cancel" type="summit">Reset</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/jquery.validate.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.13.0/additional-methods.min.js"></script>
<script src='js/view-profile.js'></script>
</html>
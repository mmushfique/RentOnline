<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <title>Main page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
        <!--<link href="Css/index.css" rel="stylesheet">-->
        <!--<link href="bootstrap icons/bootstrap-icons.css" rel="stylesheet">-->
    </head>

    <body>

        <!----------------------Navigation-bar--------------------->
        <header id="header">
        </header>
        <!----------------------Filter-tab--------------------->
        <div class="filterTab container-fluid bg-light">
            <div>
                <span class="btn btn-primary btn-sm m-2" data-toggle="collapse" data-target="#filterPop">Filters</span>
            </div>
        </div>
        <form id="filterPop" class="container collapse p-2">
            
            <label for="locations">Location</label>
            <select id="locations" class="custom-select custom-select-sm">
            </select>
            
            <label>Category</label>
            <select id="propertySelect" class="custom-select custom-select-sm" onchange="newFilters()">
                <option selected>All</option>
                <option>House</option>
                <option>Room</option>
                <option>Shop</option>
            </select>
            
            <label for="minPrice">Min Price
                <input type="number" min="0" step="100" id="minPrice" class="form-control form-control-sm mb-2">
            </label>
            
            <label for="maxPrice">Max Price
                <input type="number" min="0" step="100" id="maxPrice" class="form-control form-control-sm mb-2">
            </label>
            
            <div id="extraFilters">
            </div>
            
            <div class="btn-group btn-group-sm p-2">
                <button id="resetBtn" class="btn btn-outline-light btn-dark" type="reset">Reset</button>
                <button id="saveBtn" class="btn btn-outline-light btn-dark" type="submit">Save</button>
                <span class="btn btn-outline-light btn-dark" data-toggle="collapse"
                      data-target="#filterPop">Close</span>
            </div>
        </form>

        <!----------------------Advertisements--------------------->

        <div class="container-fluid allAdsBox">
            <div class="sort">
                <span class="bi bi-sort-down mr-1"></span>
                <label>Sort</label>
                <select id="sortSelect" class="custom-select custom-select-sm">
                    <option>Date: Newest on top</option>
                    <option>Date: Oldest on top</option>
                    <option>Price: High to low</option>
                    <option>Price: Low to high</option>
                </select>
            </div>
            <div id="allAds" class="row">
            </div>
            <button id="btnMore" class="btn btn-outline-dark d-block mx-auto mb-2 mt-2">
                More Results<span class="bi bi-caret-down ml-2"></span>
            </button>
        </div>

        <template class="adTemplate" name="ad">
            <div class="col-12 col-md-6 col-lg-4">
                <a id="adBox" href="adMain.html" class="card m-2">
                    <img class="card-img-top adImg" src="Resources/hi.jpg">
                    <div class="card-body adDetails">
                        <h5 class="card-title">House In Kandy</h5>
                        <div class="card-text locInfo">Kandy</div>
                        <div class="card-text price">RS 20000</div>
                    </div>
                    <div class="card-footer date">2 days ago</div>
                </a>
            </div>
        </template>

        <!------------------------- Page navigation ----------------------------->

        <span id="backToTop" class="bi bi-arrow-up-square-fill"></span>

        <footer id="footer">
        </footer>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"></script>
        <script src="index.js"></script>
        <!--<script src="Js/common.js"></script>-->
    </body>
</html>

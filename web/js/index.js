/* global maxPrice, locations, propertySelect, minPrice, allAds */

let locationArr = ["All", "Akkarepattu", "Akurana", "Akuressa", "Ambalangoda", "Ambalantota",
    "Ampara", "Anuradhapura", "Baddegama", "Badulla", "Balangoda", "Bandaragama",
    "Bandarawela", "Batticaloa", "Beliatta", "Bibile", "Buttala", "Chavakachcheri",
    "Chilaw", "Colombo", "Dambulla", "Dankotuwa", "Dehiwala", "Dikwella",
    "Eheliyagoda", "Elpitiya", "Embilipitiya", "Eppawala", "Galewela", "Galle",
    "Gampaha", "Gampola", "Ginigathhena", "Hakmana", "Hambantota", "Hatton",
    "Hikkaduwa", "Hingurakgoda", "Horana", "Jaffna", "Kadawatha", "Kaduruwela",
    "Kalmunai", "Kalutara", "Kandy", "Kataragama", "Katugastota", "Kegalle",
    "Kekirawa", "Kilinochchi", "Kinniya", "Kiribathgoda", "Kottawa", "Kuliyapitiya",
    "Kurunegala", "Madulla", "Maharagama", "Mahiyanganaya", "Mannar", "Matale",
    "Matara", "Matugama", "Mawanella", "Medawachchiya", "Medirigiriya", "Monaragala",
    "Mullativu", "Nallur", "Narammala", "Nattandiya", "Negombo", "Nugegoda",
    "Nuwara Eliya", "Panadura", "Passara", "Pelmadulla", "Peradeniya", "Piliyandala",
    "Polgahawela", "Polonnaruwa", "Puttalam", "Rambukkana", "Ratnapura", "Rattota",
    "Ruwanwella", "Sainthamaruthu", "Tambuttegama", "Tangalla", "Tissamaharama",
    "Trincomalee", "Ukuwela", "Vavuniya", "Warakapola", "Wariyapola", "Wattala",
    "Weligama", "Welimada", "Wellawaya", "Wennappuwa"]

addEventListener("load", () =>
{
    for (i = 0; i < locationArr.length; i++)
    {
        locations.innerHTML += ("<option>" + locationArr[i] + "</option>");
    }
    filterAndSort();
    sendData();
});

resetBtn.addEventListener('click', () => {
    extraFilters.innerHTML = "";
    filterAndSort();
    var myData
})

function newFilters() {
    let category = propertySelect.options[propertySelect.selectedIndex].value;
    if (category === "House" || category === "Room") {
        extraFilters.innerHTML = ` 
            <label for="furnished">Furnished Status</label>
            <select id="furnished" class="custom-select custom-select-sm">
                <option>Both</option>
                <option>Furnished</option>
                <option>Not Furnished</option>
            </select>`;
            //<label for="bathrooms">BathRooms</label>
//            <select id="bathrooms" class="custom-select custom-select-sm">
                //<option>Any</option>        
                //<option>1</option>
                //<option>2</option>
                //<option>3</option>
                //<option>4</option>
                //<option>4+</option>
            //</select>
        if (category === "House") {
            extraFilters.innerHTML += ` 
                <label for="rooms">Rooms</label>
                <select id="rooms" class="custom-select custom-select-sm">
                    <option>Any</option> 
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>4+</option>
                </select>`;
        }else if(category === "Room"){
            extraFilters.innerHTML += ` 
                <label for="Beds">Beds</label>
                <select id="Beds" class="custom-select custom-select-sm">
                    <option>Any</option> 
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>4+</option>
                </select>`;
        }
    }

    // else if (category === "Shop") {
    //   extraFilters.innerHTML = `
    //   <label for="dimension">Dimension</label>
    //   <input id="dimension" class="form-control form-control-sm" type="text"/>  `;
    // } 
    else {
        extraFilters.innerHTML = "";
    }
}

backToTop.addEventListener("click", () => {
    window.scrollTo(top);
});

window.addEventListener("scroll", () => {
    if (window.scrollY > 300)
        backToTop.style.display = "block";
    else
        backToTop.style.display = "none";
});

let saveBtn = document.querySelector('#saveBtn');

//let rooms=document.querySelector('#rooms');
//let furnished=document.querySelector('#furnished');
//let bathrooms=document.querySelector('#bathrooms');

saveBtn.addEventListener('click', (e) => {
    e.preventDefault();
    filterAndSort();
    sendData();
});
var myData = {};
function filterAndSort() {

    let location = locations.options[locations.selectedIndex].value;
    let category = propertySelect.options[propertySelect.selectedIndex].value;
    let minP = parseInt(minPrice.value.trim());
    let maxP = parseInt(maxPrice.value.trim());

    if (maxP === 0) {
        alert("MaxPrice cannot be zero");
    } else if (minP > maxP) {
        alert("MinPrice cannot be greaterthan MaxPrice");
    } else {
        myData = {
            location: location,
            category: category,
            minPrice: 0,
            maxPrice: 0
        };

        if (minPrice.value.trim() !== "") {
            myData.minPrice = minP;
        }
        if (maxPrice.value.trim() !== "") {
            myData.maxPrice = maxP;
        }

        if (category === "House" || category === "Room") {
           
            let furnishedStatus = furnished.options[furnished.selectedIndex].value;
            myData.furnished = furnishedStatus;

            if (category === "House") {
                let room = rooms.options[rooms.selectedIndex].value;
                myData.rooms = room;
            }else{
                 let bed = beds.options[beds.selectedIndex].value;
                 myData.beds = bed;
            }
        } else if (category === "shop") {

        }

        let sort = sortSelect.options[sortSelect.selectedIndex].value;
        myData.sort = sort;
    }
}

function sendData() {
    $.ajax({
        type: 'POST',
        data: myData,
        url: 'LoadPostsServlet'
    }).done(function (result) {
//         console.log(result);
        let allAdsArr = result;
        allAds.innerHTML = "";
        allAdsArr.forEach(ad => {
            allAds.innerHTML += `
           
            <div class="col-12 col-md-6 col-lg-4">
            <a id="adBox" href="adView.jsp?id=`+ad.adId+`" class="card m-2">
            <div id="imgbox">
                <img class="card-img-top adImg" src="`+ad.adImg+`"> </div>
                <div class="card-body adDetails">
                    <h5 class="card-title">` + ad.adTitle + `</h5>
                    <div class="card-text locInfo">` + ad.adLoc + `</div>
                    <div class="card-text price">` + ad.adRent + `</div>
                </div>
       
                <div class="card-footer">`+ad.adGap+`</div>
                </a>
            </div>`;
        })
    }).fail(function () {
        alert("Something Went Wrong");
    })
}
let sortSelect = document.getElementById('sortSelect');
sortSelect.addEventListener('change', () => {
    filterAndSort();
    sendData();
});

let clickCount = 0;
let btnMore = document.querySelector("#btnMore");
btnMore.addEventListener('click', () => {
    clickCount++;
    filterAndSort();
    myData.adlimitStart = clickCount * 10;
    $.ajax({
        type: 'POST',
        data: myData,
        url: 'LoadPostsServlet'
    }).done(function (result) {
//        console.log(result);
        let allAdsArr = result;
        let adsCount = 0;
        allAdsArr.forEach(ad => {
            allAds.innerHTML += `
            <div class="col-12 col-md-6 col-lg-4">
            <a id="adBox" href="adView.jsp?id=`+ad.adId+` class="card m-2">
                <div id="imgbox">
                <img class="card-img-top adImg" src="`+ad.adImg+`"></div>
                <div class="card-body adDetails">
                    <h5 class="card-title">` + ad.adTitle + `</h5>
                    <div class="card-text locInfo">` + ad.adLoc + `</div>
                    <div class="card-text price">` + ad.adRent + `</div>
                </div>
                <div class="card-footer">`+ad.adGap+`</div>
                </a>
            </div>`
            adsCount++;
        });
        if (adsCount < 10) {
            btnMore.remove();
        }
    }).fail(function () {
        alert("Something Went Wrong");
    });
});

//SELECT * FROM advertisement WHERE description LIKE '%%' || title LIKE '%%'
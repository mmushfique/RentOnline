$(function () {
  $("#header").load("header.html");
  $("#footer").load("footer.html");
});
var locationArr = [
  "Akkarepattu",
  "Akurana",
  "Akuressa",
  "Ambalangoda",
  "Ambalantota",
  "Ampara",
  "Anuradhapura",
  "Baddegama",
  "Badulla",
  "Balangoda",
  "Bandaragama",
  "Bandarawela",
  "Batticaloa",
  "Beliatta",
  "Bibile",
  "Buttala",
  "Chavakachcheri",
  "Chilaw",
  "Colombo",
  "Dambulla",
  "Dankotuwa",
  "Dehiwala",
  "Dikwella",
  "Eheliyagoda",
  "Elpitiya",
  "Embilipitiya",
  "Eppawala",
  "Galewela",
  "Galle",
  "Gampaha",
  "Gampola",
  "Ginigathhena",
  "Hakmana",
  "Hambantota",
  "Hatton",
  "Hikkaduwa",
  "Hingurakgoda",
  "Horana",
  "Jaffna",
  "Kadawatha",
  "Kaduruwela",
  "Kalmunai",
  "Kalutara",
  "Kandy",
  "Kataragama",
  "Katugastota",
  "Kegalle",
  "Kekirawa",
  "Kilinochchi",
  "Kinniya",
  "Kiribathgoda",
  "Kottawa",
  "Kuliyapitiya",
  "Kurunegala",
  "Madulla",
  "Maharagama",
  "Mahiyanganaya",
  "Mannar",
  "Matale",
  "Matara",
  "Matugama",
  "Mawanella",
  "Medawachchiya",
  "Medirigiriya",
  "Monaragala",
  "Mullativu",
  "Nallur",
  "Narammala",
  "Nattandiya",
  "Negombo",
  "Nugegoda",
  "Nuwara Eliya",
  "Panadura",
  "Passara",
  "Pelmadulla",
  "Peradeniya",
  "Piliyandala",
  "Polgahawela",
  "Polonnaruwa",
  "Puttalam",
  "Rambukkana",
  "Ratnapura",
  "Rattota",
  "Ruwanwella",
  "Sainthamaruthu",
  "Tambuttegama",
  "Tangalla",
  "Tissamaharama",
  "Trincomalee",
  "Ukuwela",
  "Vavuniya",
  "Warakapola",
  "Wariyapola",
  "Wattala",
  "Weligama",
  "Welimada",
  "Wellawaya",
  "Wennappuwa",
];

addEventListener("load", () => {
  for (i = 0; i < locationArr.length; i++) {
    selectLoc.innerHTML += "<option>" + locationArr[i] + "</option>";
  }
});

// addEventListener("load", extraFilters());

// function extraFilters() {
//     let selectedCategory=selectCat.options[selectCat.selectedIndex].value;
//   if ( selectedCategory == "House" ) {
//     houseFilter.hidden=false;
//     roomAndHouseFilter.hidden=false;
//     shopFilter.hidden=true;
//   } else if(selectedCategory == "Room"){
//     roomAndHouseFilter.hidden=false;
//     shopFilter.hidden=true;
//     houseFilter.hidden = true;
//   }
//   else{
//     shopFilter.hidden=false;
//     roomAndHouseFilter.hidden=true;
//     houseFilter.hidden = true;
//   }
// }
btnNext.addEventListener("click", () => {
  let selectedCategory = selectCat.options[selectCat.selectedIndex].value;
  if (selectedCategory == "House") {
    extraFilters.innerHTML = ` <label for="rooms">Rooms</label>
    <select id="rooms" class="custom-select custom-select-sm" name="room">
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
    </select>
    <label for="furnished">Furnished Status</label>
    <select id="furnished" class="custom-select custom-select-sm" name="furnished">
        <option>Furnished</option>
        <option>Not Furnished</option>
    </select>`;
  } else if (selectedCategory == "Room") {
    extraFilters.innerHTML = ` <label for="furnished">Furnished Status</label>
    <select id="furnished" class="custom-select custom-select-sm" name="furnished">
        <option>Furnished</option>
        <option>Not Furnished</option>
    </select>
    <label for="beds">Beds</label>
    <select id="beds" class="custom-select custom-select-sm" name="bed">
        <option>1</option>
        <option>2</option>
        <option>3</option>
        <option>4</option>
        <option>5</option>
    </select>`;
  } else {
    extraFilters.innerHTML = `<label for="dimension">Dimension</label>
    <input id="dimension" class="form-control form-control-sm" type="text" name="dimension" placeholder="10 * 20"/>  `;
  }

  if (adTitle.value != "" && rentPrice.value != "" && area.value != "" && adDescription.value !="") {
    common.hidden = true;
    extra.hidden = false;
    err.innerText="";
  }
  else{
    err.innerText="*All Fields Are Required";
  }
});
btnPrev.addEventListener("click", () => {
  common.hidden = false;
  extra.hidden = true;
});
images.addEventListener('change',(e)=>{
  let files=e.currentTarget.files;
  let filesCount=e.currentTarget.files.length;
  if(filesCount==0) {
    imgPreview.innerHTML=""
    err1.innerText=("*Choose atleast 1 image");
  }
  else if(filesCount>5){
    imgPreview.innerHTML=""
    err1.innerText=("*Cannot choose morethan 5 images");
  }
  else{
    err1.innerText=("");
    imgPreview.innerHTML=""
    let imgId="";
    for(i=1;i<=filesCount;i++){
      imgPreview.innerHTML+=`<img id="img" class="thumbnail">`;
      imgId="img"+i
      img.setAttribute('id',imgId)
      document.getElementById(imgId).setAttribute('src',URL.createObjectURL(files[i-1]))
    }
  }
})
submit.addEventListener('click',(e)=>{
  let files=images.files.length;
  if(files>5 || files==0){
    err1.innerText=("*Choose atleast 1 image");
    e.preventDefault();
  }
  const dim = /[0-9]\*[0-9]/;
  if (!dim.test(dimension.value)){   
      err1.innerText=("*Not a vaild dimension,use number eg:-10 * 10 ");
  e.preventDefault();
  }
})
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
        selectLoc.innerHTML += ("<option>" + locationArr[i] + "</option>");
    }
});


adType.addEventListener('change', () => {
  const selectedCat = adType.options[adType.selectedIndex].value;
  const allAds = document.querySelectorAll('.card');
  if (selectedCat === 'All') {
    allAds.forEach((card) => {
      card.style.display = 'inline';
    });
  } else if (selectedCat === 'House') {
    allAds.forEach((card) => {
      if (card.getElementsByTagName('span')[0].id === 'house') {
        card.style.display = 'inline';
      } else {
        card.style.display = 'none';
      }
    });
  } else if (selectedCat === 'Room') {
    allAds.forEach((card) => {
      if (card.getElementsByTagName('span')[0].id === 'room') {
        card.style.display = 'inline';
      } else {
        card.style.display = 'none';
      }
    });
  } else {
    allAds.forEach((card) => {
      if (card.getElementsByTagName('span')[0].id === 'shop') {
        card.style.display = 'inline';
      } else {
        card.style.display = 'none';
      }
    });
  }
});
const allEditBtn = document.querySelectorAll('.editBtn');
const box = document.querySelector('.box');
const adEditForm = document.querySelector('.adEditForm');
allEditBtn.forEach((editBtn) => {
  editBtn.addEventListener('click', (e) => {
    const singleAd = e.currentTarget.parentElement.getElementsByTagName('span')[0].id;
    box.hidden = true;
    adEditForm.hidden = false;
    if (singleAd === 'house') {
      extraFilters.innerHTML = `
                    <label for = "rooms"> Rooms </label>
                    <select id = "rooms" class = "custom-select custom-select-sm" name = "room" >
                    <option > 1 </option>
                    <option > 2 </option>
                    <option > 3 </option>
                    <option > 4 </option>
                    <option > 4 + </option>
                    </select>
                    <label for = "furnished"> Furnished Status </label>
                    <select id = "furnished" class = "custom-select custom-select-sm" name = "furnished" >
                    <option> Furnished </option>
                    <option> Not Furnished </option>
                    </select>`;
      //            <label for="bathrooms">BathRooms</label>
      //            <select id="bathrooms" class="custom-select custom-select-sm">
      //                <option>1</option>
      //                <option>2</option>
      //                <option>3</option>
      //                <option>4</option>
      //                <option>4+</option>
      //            </select>
    } else if (singleAd === 'room') {
      extraFilters.innerHTML = `
                    <label for = "furnished"> Furnished Status </label>
                    <select id = "furnished" class = "custom-select custom-select-sm name="furnished" >
                    <option> Furnished </option>
                    <option> Not Furnished </option>
                    </select>
                    <label for = "beds"> Beds </label>
                    <select id = "beds" class = "custom-select custom-select-sm name="bed">
                    <option> 1 </option>
                    <option> 2 </option>
                    <option> 3 </option>
                    <option> 4 </option>
                    <option> 4 +</option>
                    </select>`;
    } else if (singleAd === 'shop') {
      extraFilters.innerHTML = `
                    <label for = "dimension" > Dimension </label>
                    <input id = "dimension" class = "form-control form-control-sm" type = "text" name = "dimension" /> `;
    } else {
      extraFilters.innerHTML = '';
    }

    id = e.currentTarget.parentElement.id;
    
    $.ajax({
      
      type: 'POST',
      data: {
        ad_id: id,
      },
      url: 'AdEditServlet',
    }).done((result) => {
//                              console.log(typeof(result));
      document.querySelector('.adEditForm').getElementsByTagName('input')[0].value = id;
      document.querySelector('#adTitle').value = result.title;
      document.querySelector('#selectLoc').value = result.location;
      document.querySelector('#rentPrice').value = result.rent;
      document.querySelector('#area').value = result.property_area;
      document.querySelector('#adDescription').value = result.description;
      if (singleAd === 'house') {
        document.querySelector('#rooms').value = result.rooms;
        document.querySelector('#furnished').value = result.furnished_status;
      } else if (singleAd === 'room') {
        document.querySelector('#beds').value = result.beds;
        document.querySelector('#furnished').value = result.furnished_status;
      } else {
        document.querySelector('#dimension').value = result.dimension;
      }
    });
  });
});
const btnClose = document.querySelector('#btnClose');
btnClose.addEventListener('click', () => {
  adEditForm.hidden = true;
  box.hidden = false;
});

//images.addEventListener('change',(e)=>{
//  let files=e.currentTarget.files;
//  let filesCount=e.currentTarget.files.length;
//  if(filesCount==0) {
//    imgPreview.innerHTML=""
//    err1.innerText=("*Choose atleast 1 image");
//  }
//  else if(filesCount>5){
//    imgPreview.innerHTML=""
//    err1.innerText=("*Cannot choose morethan 5 images");
//  }
//  else{
//    err1.innerText=("");
//    imgPreview.innerHTML=""
//    let imgId="";
//    for(i=1;i<=filesCount;i++){
//      imgPreview.innerHTML+=`<img id="img" class="thumbnail">`;
//      imgId="img"+i
//      img.setAttribute('id',imgId)
//      document.getElementById(imgId).setAttribute('src',URL.createObjectURL(files[i-1]))
//    }
//  }
//})
//submit.addEventListener('click',(e)=>{
//  let files=images.files.length;
//  if(files>5 || files==0){
//    err1.innerText=("*Choose atleast 1 image");
//    e.preventDefault();
//  }

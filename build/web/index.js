var locationArr = ["All", "Akkarepattu", "Akurana", "Akuressa", "Ambalangoda", "Ambalantota",
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

addEventListener("load",()=>
{
    for(i=0;i<locationArr.length;i++)
    {
        locations.innerHTML+=("<option>"+locationArr[i]+"</option>");
    }
});

let adCount=1,totalAds=100,remain;

addEventListener("load",ads=()=>
{
    for(i=1;i<=12 && adCount<=totalAds;i++,adCount++)
    {
        let adBoxTemplate=document.getElementsByName("ad")[0];
        let clon=adBoxTemplate.content.cloneNode(true);
        allAds.appendChild(clon);
        adBox.setAttribute("id","adBox"+adCount);
        remain=totalAds-adCount;
    }
    if (remain==0)  btnMore.remove();
});
// addEventListener("load",()=>
// {
//     let navTemplate=document.getElementsByName("nav")[0];
//     let clon=navTemplate.content.cloneNode(true);
//     header.appendChild(clon);
// });

$(function(){
    $("#header").load("header.html");
    $("#footer").load("footer.html");
});

function newFilters(){
    let category=propertySelect.options[propertySelect.selectedIndex].value;
    if(category=="Houses")  houseFilter.style.display = "inline";
    else  houseFilter.style.display = "none";
}

backToTop.addEventListener("click",()=>{
    window.scrollTo(top);
});

window.addEventListener("scroll",()=>{
    if(window.scrollY>300) backToTop.style.display="block";
    else backToTop.style.display="none";
});
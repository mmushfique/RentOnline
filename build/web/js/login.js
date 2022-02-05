$(function () {
  $("#header").load("header.jsp");
  $("#footer").load("footer.html");
});

switchSignup.addEventListener('click', () => {
    loginForm.hidden = true;
    signupForm.hidden = false;
})
switchLogin.addEventListener('click', () => {
    signupForm.hidden = true;
    loginForm.hidden = false;
})

signupBtn.addEventListener('click', function (e) {
     
    if (username.value == "") setError(username, "Username is required", e);
    else    setSuccess(username);
    
    if (firstName.value == "") setError(firstName, "Firstname is required", e);
    else    setSuccess(firstName);

    if (lastName.value == "")   setError(lastName, "Lastname is required", e);
    else    setSuccess(lastName);

    if (email.value == "")  setError(email, "Email is required", e);
    else    setSuccess(email);

    if (password.value.length >= 8 && password.value.length <= 12)  setSuccess(password);
    else    setError(password, "Password must be 8-12 characters", e);

    if (password.value != repassword.value || repassword.value=="") setError(repassword, "Password do no match", e);
    else    setSuccess(repassword);

    if (phoneNo.value == "")    setError(phoneNo, "Phone number is required", e);
    else    setSuccess(phoneNo);

    if (phoneNo.value.length == 10 )    setSuccess(phoneNo);
    else    setError(phoneNo, "Not a vaild phone number eg:-07xxxxxxxx", e);
});


signupForm.addEventListener('submit',function (ex){
    ex.preventDefault();
    let username=document.getElementById("username").value;
let fname=document.getElementById("firstName").value;
let lname=document.getElementById("lastName").value;
let email=document.getElementById("email").value;
let phoneNo=document.getElementById("phoneNo").value;
let password=document.getElementById("password").value;
$.ajax({
        type: 'POST',
        data:{username:username,fname:fname,lname:lname,email:email,phoneNo:phoneNo,password:password},
        url: 'SignupServlet'
    }).done(function (result) {
        let x=String(result);
        //console.log(x);console.log(typeof(x));
        if(x=="username"){
            userError.innerHTML=`Username already taken,try another one`;
            userError.style.visibility = "visible"
        }else if(x=="email"){
            emailError.innerHTML=`You already have an account in this email`;
            emailError.style.visibility = "visible"
        
        }else if(x=="phone"){
            phoneError.innerHTML=`You already used this phone number`;
            phoneError.style.visibility = "visible";
        }else{
            window.location.href = "adPost.jsp";
        }
    }).fail(function () {
        alert("Something Went Wrong");
    });
});

function setError(inputName, errmessage, e) {
    e.preventDefault();
    let parentDiv = inputName.parentElement;
    parentDiv.querySelector('small').innerText = "*"+errmessage;
    parentDiv.querySelector('small').style.visibility = "visible"
    inputName.className = "form-control failed"
}
function setSuccess(inputName) {
    let parentDiv = inputName.parentElement;
    parentDiv.querySelector('small').style.visibility = "hidden"
    inputName.className = "form-control success"
}
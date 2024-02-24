var lang = navigator.language;

document.querySelector('#loading').style.display = 'none';
document.querySelector('#delete').style.display = 'none';

function getCookie(name) {
    // cf https://stackoverflow.com/questions/10730362/get-cookie-by-name/15724300#15724300
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
}

function delay(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function createApp() {
    //start a new container, set reverse proxy & cookie
    let response = await fetch('./start');
    if (response.ok) {
        let data = await response.json();
        console.log(data);
        await delay(5000);
        showAppLinkNDelButton(data);
    }
}

async function deleteApp(del_route) {
    //follow the del_route to delete the app
    let response = await fetch(del_route);
    if (response.ok) {
        let data = await response.text();
        console.log(data);
        document.querySelector('#loading').style.display = 'none';
        document.querySelector('#create').style.display = '';
    }
}

function showAppLinkNDelButton(data) {
    var open_label="OPEN APP";
    var token_txt="Your access token is "+data["token"];
    if (lang==="fr") {
        open_label="OUVRIR L'APP";
        token_txt="Votre code est "+data["token"];
    }
    var link = "<br>"+token_txt+"<br>";
    link += "<a href="+data["app_url"]+" target=_blank>"+open_label+"</a><br><br>";
    document.querySelector('#open').innerHTML = link;
    document.querySelector('#loading').style.display = 'none';
    document.querySelector('#delete').style.display = '';
    document.querySelector('#delete_button').value = './delete/'+data["port"]+'/'+data["token"];
}

async function checkExistence(token, app_url) {
    let response = await fetch("check/"+token);
    console.log(response);
    if (response.ok) {
        let answer = await response.text();
        console.log(answer);
        if (answer.includes("error")) {
            document.querySelector('#create').style.display = '';
        } else {
            console.log("app exist");
            document.querySelector('#create').style.display = 'none';
            var data = {};
            data["token"] = token;
            data["port"] = port;
            data["app_url"] = app_url;
            console.log(data);
            showAppLinkNDelButton(data);
        }
    }
}

if (document.cookie.includes("emoncms_token")) {
    if (document.cookie.includes("port")) {
        var token = getCookie("emoncms_token");
        var port = getCookie("port");
        if (document.cookie.includes("app_url")) {
            var app_url = getCookie("app_url");
            checkExistence(token, app_url);
        }
    }
}

document.querySelector('#create').addEventListener('click', function(){
    document.querySelector('#open').innerHTML = "";
    document.querySelector('#create').style.display = 'none';
    document.querySelector('#loading').style.display = '';
    createApp();
});

document.querySelector('#delete_button').addEventListener('click', function() {
    document.querySelector('#delete').style.display = 'none';
    document.querySelector('#loading').style.display = '';
    document.querySelector('#open').innerHTML = "";
    var del_route = document.querySelector('#delete_button').value;
    console.log(del_route);
    deleteApp(del_route);
});


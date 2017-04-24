
// this is JavaScript code to make the user control resizable.
//
//to Minimize the user control
function hidediv(id) {
    document.getElementById(id).style.display = 'none';
    document.getElementById("whole_basket").style.height = '46px';
    document.getElementById("whole_basket").style.width = '130px';

    document.getElementById("imgShow").style.display = 'block';
    document.getElementById("imgHide").style.display = 'none';
}

// to Maximiza the user control
function showdiv(id) {
    document.getElementById(id).style.display = 'block';
    document.getElementById("whole_basket").style.height = '255px';
    document.getElementById("whole_basket").style.width = '270px';

    document.getElementById("imgShow").style.display = 'none';
    document.getElementById("imgHide").style.display = 'block';
}
// End Resizable Code

// To add a new product to the cookie
function addCookie(name, value, prod_name, prod_price) {

    var today = new Date();
    
    //to set the cookies expiry time
    var expires = expires * 1000 * 3600 * 3;

    //To retrieve the values of cookie named "ShoppingCart"
    var currentCookie = getCookie(name);
    
    if (currentCookie == null) {
        //it means this is the first item in the basket
        document.cookie = name + '=' + escape(value) + "," + escape(prod_name) + "," + escape(prod_price) +
                        ((expires) ? ';expires=' + new Date(today.getTime() + expires).toGMTString() : '');
    }
    else {
        //it means the basket already has another products
        document.cookie = name + '=' + currentCookie + "," + escape(value) + "," + escape(prod_name) + "," + escape(prod_price) +
                        ((expires) ? ';expires=' + new Date(today.getTime() + expires).toGMTString() : '');
    }

    //To maximize the basket size in case it was minimized by the user
    showdiv("Basket_body")

    //to force the post back to reload the basket items after adding product
    __doPostBack('Basket1_UpdatePanel1', '');
}

// To retrieve the basket cookie values
function getCookie(name) {
    var sPos = document.cookie.indexOf(name + "=");
    var len = sPos + name.length + 1;
    if ((!sPos) && (name != document.cookie.substring(0, name.length))) {
        return null;
    }
    if (sPos == -1) {
        return null;
    }

    var ePos = document.cookie.indexOf('=', len);
    if (ePos == -1) ePos = document.cookie.length;
    return unescape(document.cookie.substring(len, ePos));
}
//End Adding new product code


//To remove a product from the basket. I am calling a JavaScript function deleteCookie when the user press on remove link. 
//then I am forcing postback by calling the function  __doPostBack function. 

    function deleteCookie(name, value, prod_name, prod_price) {
        
        //to set the cookie expiry time
        var expires = expires * 1000 * 3600 * 3;

        //because the system will check the space as %20
        if (document.cookie.indexOf("%20") != -1)
        {
            prod_name = prod_name.replace(" ", "%20");
        }

        //In case of the removed item in the mid of the cookie
        if (document.cookie.indexOf("," + value + "," + prod_name + "," + prod_price) != -1) {
            document.cookie = document.cookie.replace("," + value + "," + prod_name + "," + prod_price, "") +
                   ((expires) ? ';expires=' + new Date(today.getTime() + expires).toGMTString() : '');
        }

        //In case of the removed item is the first item in cookie
        else if (document.cookie.indexOf(value + "," + prod_name + "," + prod_price + ",") != -1) {
            document.cookie = document.cookie.replace(value + "," + prod_name + "," + prod_price + ",", "") +
                   ((expires) ? ';expires=' + new Date(today.getTime() + expires).toGMTString() : '');
        }

        //In case of the removed item is the only item in cookie 
        else if (document.cookie.indexOf(value + "," + prod_name + "," + prod_price) != -1) {
            document.cookie = document.cookie.replace(value + "," + prod_name + "," + prod_price, "") +
                   ((expires) ? ';expires=' + new Date(today.getTime() + expires).toGMTString() : '');
        }

        //to force the post back to reload the basket items after removing product 
        __doPostBack('Basket1_UpdatePanel1', '');
    }


// This Javascript function to force a postback after adding or removing a product.  
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}

// Below are JavaScript code for Div drag and drop 

var drag = 0;     // a Boolean variable to determine the drag status  
var xdif = 0;     // a variable to save the new X position for the basket
var ydif = 0;     // a variable to save the new Y position for the basket


function begindrag(event) {
    if (drag == 0) {
        floatingd = document.getElementById("whole_basket");

        prex = floatingd.style.left.replace(/px/, "");
        prey = floatingd.style.top.replace(/px/, "");

        drag = 1;

        xdif = Math.abs(event.clientX - prex);
        ydif = Math.abs(event.clientY - prey);
    }
}

// to move the basket during drag (mouse down and move)  
function mousepos(event) {
    floatingd = document.getElementById("whole_basket");
    // to check that the mouse still down
    if (drag == 1) {
        floatingd.style.left = Math.abs(event.clientX - xdif) + "px";
        floatingd.style.top = Math.abs(event.clientY - ydif) + "px"; ;
    }
}

//when mouse up to release the basket
function rel_drag(event) {
    drag = 0;
}
//End drag and drop code        
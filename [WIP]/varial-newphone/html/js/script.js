let oldContainerHistory = []
let currentContainer = "home";
let contactList = [];
let gpsFilters = [];
let keyFilters = [];
let gurgleEntries = [];
let manageGroup = "";
let playerId = 0;
let house = [];
let nearHouse = [];
let housing = [];
let HousesInfo = [];
let allHouses = [];
let isNearHouse = false;
let globalNotify = 0;

let isSprint = false;
let curLap = 0;
let maxLaps = 0;
let maxCheckpoints = 0;
let curCheckpoint = 0;
let startTime = 0;
let previousLapTime = 0;
let currentStartTime = 0;
let fastestLapTime = 0;
let overallLapTime = 0;
let drawRaceStatsIntervalId = 0;
let races = {};
let maps = {};
let noty = false
let pPhoneOpen = false
let wifizone = false;
let unReadMsg = 0;
let unReadTwt = 0;
let unReadEmail = 0;
var activePing = false;
var drawer = false
var callAccept = false
/* Call info */
let currentCallState = 0;
let currentCallInfo = "";
let hasNotif = false
let isRealEstateAgent = false
let globalGroup = "";

const callStates = {
    0: "isNotInCall",
    1: "isDialing",
    2: "isReceivingCall",
    3: "isCallInProgress"
}

const timer = document.getElementById('stopwatch');

var hr = 0;
var min = 0;
var sec = 0;
var stoptime = true;
var timeAmount = "00:00:00"

function startTimer() {
  if (stoptime == true) {
        stoptime = false;
        timerCycle();
    }
}
function stopTimer() {
  if (stoptime == false) {
    stoptime = true;
    timerCycle();
  }
}

function timerCycle() {
    if (stoptime == false) {
    sec = parseInt(sec);
    min = parseInt(min);
    hr = parseInt(hr);

    sec = sec + 1;

    if (sec == 60) {
      min = min + 1;
      sec = 0;
    }
    if (min == 60) {
      hr = hr + 1;
      min = 0;
      sec = 0;
    }

    if (sec < 10 || sec == 0) {
      sec = '0' + sec;
    }
    if (min < 10 || min == 0) {
      min = '0' + min;
    }
    if (hr < 10 || hr == 0) {
      hr = '0' + hr;
    }

    timeAmount =  min + ':' + sec;
    // console.log(hr + ':' + min + ':' + sec)
    if (callAccept == true){
        //fucking start the time noob
        // $('#call-time').text(timeAmount);
        $('.timer-sc-sec').text(sec);
        $('.timer-sc-min').text(min);
    }
    setTimeout("timerCycle()", 1000);
} else {
    sec = 0;
    min = 0;
    hr = 0;
  }
}

// var timeLeft = 30;
// var elem = document.getElementById('xtime');
// var timerId = setInterval(countdown, 1000);
    
// function countdown() {
//     console.log("CONSTANT")
//       if (timeLeft == -1) {
//         clearTimeout(timerId);
//         doSomething();
//       } else {
//         // $('#xtime').append('00:'+timeLeft);
//         timeLeft--;
//       }
//       $('#xtime').append('00:'+timeLeft);
// }



var decodeEntities = (function () {
    // this prevents any overhead from creating the object each time
    var element = document.createElement('div');

    function decodeHTMLEntities(str) {
        if (str && typeof str === 'string') {
            // strip script/html tags
            str = str.replace(/<script[^>]*>([\S\s]*?)<\/script>/gmi, '');
            str = str.replace(/<\/?\w(?:[^"'>]|"[^"]*"|'[^']*')*>/gmi, '');
            element.innerHTML = str;
            str = element.textContent;
            element.textContent = '';
        }

        return str;
    }

    return decodeHTMLEntities;
})();

const calendarFormatDate = {
    sameDay: 'HH:mm TT',
    nextDay: '[Tom -] HH:mm TT',
    nextWeek: 'dddd [-] HH:mm TT',
    lastDay: '[Yes -] HH:mm TT',
    lastWeek: 'dddd [-] HH:mm TT',
    sameElse: 'YYYY-MM-DD HH:mm:ss'
}

moment.updateLocale('en', {
    relativeTime: {
        past: function (input) {
            return input === 'a few seconds ago'
                ? input
                : input + ' ago'
        },
        s: 'a few seconds ago',
        future: "in %s",
        ss: '%ds',
        m: "1m",
        mm: "%dm",
        h: "1h",
        hh: "%dh",
        d: "1d",
        dd: "%dd",
        M: "1mo",
        MM: "%dmo",
        y: "1y",
        yy: "%dy"
    }
});

// moment.updateLocales('en', {
//     relativeTime: {
//         past: function (input) {
//             return input === 'a few seconds ago'
//                 ? input
//                 : input + ' ago'
//         },
//         s: 'a few seconds ago',
//         future: "in %s",
//         ss: '%ds',
//         m: "1m",
//         mm: "%dm",
//         h: "1h",
//         hh: "%dh",
//         d: "1d",
//         dd: "%dd",
//         M: "1mo",
//         MM: "%dmo",
//         y: "1y",
//         yy: "%dy"
//     }
// });

var debounce = function (func, wait, immediate) {
    var timeout;
    return function () {
        var context = this, args = arguments;
        var later = function () {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};

function acceptcall(data) {
    // $('.timer-sc-min').text('00')
    // console.log("TIME")
    $('.timer-sc-sec').empty()
    $('.timer-sc-min').empty()
    $('.timer-sc-sec').text("00");
    $('.timer-dot').text(':')
    var milisecond = 00;
    var seconds = 00;
    var minutes = 00;
    // $('.app-bar .name .call-div-name').text(data.name)
    // $('.call-div2').remove()
    var appendMin = $('.timer-sc-min');
    var appendSecond = $('.timer-sc-sec')
    var Interval;
    clearInterval(Interval);
    Interval = setInterval(startTimer, 17);

    function startTimer() {
        milisecond++;
        if (seconds <= 9) {
            // appendSecond.text("0" + seconds);
            $('.timer-sc-sec').text("0" + seconds);
        }
        if (seconds > 9) {
            // appendSecond.text(seconds);
            $('.timer-sc-sec').text(seconds);
        }
        if (milisecond > 60) {
            seconds++;
            if (seconds >= 10) {
                $('.timer-sc-sec').text(seconds);
                // appendSecond.text(seconds);
            } else {
                $('.timer-sc-sec').text("0" + seconds);
                // appendSecond.text("0" + seconds);
            }
            milisecond = 0;
        }
        if (seconds > 59) {
            minutes++;
            if (minutes >= 10) {
                $('.timer-sc-min').text(minutes);
                appendMin.text(minutes);
            } else {
                $('.timer-sc-min').text("0" + minutes);
                appendMin.text("0" + minutes);
            }
            seconds = 0;
            $('.timer-sc-sec').text("0" + 0);
            // appendSecond.text("0" + 0);
        }
        if (minutes > 9) {
            // appendMin.text(minutes);
            $('.timer-sc-min').text(minutes);
        }
        
    }
}


$(document).ready(function () {
    $('.collapsible').collapsible();
    $('.modal').modal();

    $.post('http://varial-newphone/getWeather', JSON.stringify({}));

    setInterval(function () {
        $.post('http://varial-newphone/getWeather', JSON.stringify({}));
    }, 60 * 1000);

    /* This handles keyEvents - ESC etc */
    document.onkeyup = function (data) {
        // If Key == ESC -> Close Phone
        if (data.which == 27) {
            closePhoneShell()
            $.post('http://varial-newphone/close', JSON.stringify({}));
        }
    }

    $(".phone-screen").on('click', '#wifi', function (e) {
        if (wifizone){
            $.post('https://varial-newphone/connectWifi', JSON.stringify({}));
        }
    });
    setInterval(function () {
        var d = new Date();

        var time = $('.time-stratch');
        var hours = d.getHours();
        var minutes = d.getMinutes();
        if (minutes <= 9) {
            minutes = `0${minutes}`;
        }
        if (hours <= 9) {
            hours = `0${hours}`;
        }
        time.text(`${hours}:${minutes}`);
        if ($('.top-notifications-wrapper-mounted').children().length > 0) {
            // console.log("FLEX")
            $('.top-notifications-wrapper-mounted').css('display', 'flex')
        } else {
            // console.log("NONE")
            $('.top-notifications-wrapper-mounted').css('display', 'none');
        }
    }, 100)
    $(".phone-screen").on('click', '.phone-button', function (e) {
        var action = $(this).data('action');
        var actionButton = $(this).data('action-button');
        if (actionButton !== undefined) {
            switch (actionButton) {
                case "home":
                    // console.log("THIS IS MOTHERFUCKING HOME")
                    globalyhide()
                    $.post('https://varial-newphone/refreshMySMS', JSON.stringify({status: false}));
                    $("#messages-second-container").hide();
                    $('.jss1153').css('display',"none")
                    if(callStates[currentCallState] !== "isCallInProgress" && callStates[currentCallState] !== "isDialing" && activePing !== true){
                        // console.log("GOIGN HOME",callStates[currentCallState],activePing)
                        // closeOtherContainer()
                        $.post('http://varial-newphone/closeTwat')
                    }
                    if (currentContainer !== "home") {
                        openContainer('home');
                    }
                    break;
                case "back":
                    if (oldContainerHistory.length > 0)
                        openContainer(oldContainerHistory.pop(), null, currentContainer);
                    break;
                case "browser":
                    openBrowser($(this).data('site'));
                    openContainer("importados");
                    break;
            }
        }
        if (action !== undefined) {
            switch (action) {
                case "yellow-pages-delete":
                    $.post('http://varial-newphone/deleteYP', JSON.stringify({}));
                    break;
                case "racing-create":
                    $('racing-map-creation').fadeIn(150);
                    break;
                case "newPostSubmit":
                    e.preventDefault();
                    $.post('http://varial-newphone/newPostSubmit', JSON.stringify({
                        advert: escapeHtml($("#yellow-pages-form #yellow-pages-form-advert").val())
                    }));
                    $("#yellow-pages-form #yellow-pages-form-advert").attr("style", "").val('')
                    break;
                case "group-manage":
                    $.post('http://varial-newphone/manageGroup', JSON.stringify({ GroupID: $(this).data('action-data') }));
                    break;
                case "btnTaskGang":
                    manageGroup = $(this).data('action-data');
                    $.post('http://varial-newphone/btnTaskGang', JSON.stringify({}));
                    break;
                case "group-manage-pay-external":
                    $('#group-manage-pay-modal').modal('open');
                    $('#group-manage-pay-form').trigger('reset');
                    $('#group-manage-pay-modal #group-manage-id').prop('disabled', false);
                    M.updateTextFields();
                    break;
                case "group-manage-hire-external":
                    $('#group-manage-rank-modal').modal('open');
                    $('#group-manage-rank-form').trigger('reset');
                    $('#group-manage-rank-modal #group-manage-rank-id').prop('disabled', false);
                    M.updateTextFields();
                    break;
                case "radio":
                    openRadio();
                    break;
                case "getCallHistory":
                    if (callStates[currentCallState] === "isCallInProgress" && currentContainer !== "incoming-call")
                        openContainer("top-notifications-chamadas");
                    else
                        $.post('http://varial-newphone/' + action, JSON.stringify({}));
                    break;
                case "spotify":
                    openBrowser('http://mysound.ge/index.php');
                    break;
                default:
                    $.post('http://varial-newphone/' + action, JSON.stringify({}));
                    break;
            }
        }
    });

    window.addEventListener('message', function (event) {
        var item = event.data;

        if (item.newContact === true) {
            addContact(item.contact);
            // console.log("OPEN CONTACTS?")
            $('#contacts-container').css('display',"block")
            $("#add-contact").show()
            $('#addContactHere').show()
            $('#add-contact').show()
            $('#addContactHere').css('display',"block")
            $('.jss1153').css('display',"block")
            $(".flex-centered").css("display" , "none")
        }

        if (item.removeContact === true) {
            removeContact(item.contact);
        }

        if (item.emptyContacts === true) {
            contactList = [];
            $('#contacts-container').css('display',"none")
            $(".jss1481").empty();
            
            $('#add-contact').css('display',"block")
            $('#addContactHere').css('display',"block")
            $(".flex-centered").css("display" , "flex")
        }
        if (item.wifiZone === true){
            $('#wifi').removeClass().addClass('fas fa-wifi')
        }else{
            $('#wifi').removeClass().addClass('fas fa-signal')
        }
        if (item.openPhone === true) {
            // console.log("FUCK OPEN PHONE")
           
            $('#garage-container').css('display',"none")
            $('.message-icon').css('display', 'none');
            $('.message-name').css('display', 'none');
            $('.message-number').css('display', 'none');
            $('.message-sender').css('display', 'none');
            $('.h-found').css('display', 'none');
            $('.h-no').css('display', 'none');
            $(".jss1153").hide();
            $(".jss1153").css('display', 'none');
            $('.jss1153').css('display',"none")
            $('.debt-container').css('display', 'none');
            house = item.housing
            sanitation = false
            pPhoneOpen = true
            unReadMsg = item.unrmsg
            unReadTwt = item.unrTwat
            unReadEmail = item.unrEmail
            isNearHouse = item.nearProperty
            // $('.top-notifications-wrapper').removeClass("slideinnotify").addClass("slideoutnotify").fadeOut()
            $('.notification-container-twitter').removeClass("slideinnotify").addClass("slideoutnotify").fadeOut()
            $(".jss13").removeClass("slideout").css("bottom" , "12px")
            
            $(".phone-screen").removeClass("slideout").css("bottom" , "31px")
            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").css("bottom" , "0");
            
            $(".phone-screen").css("top" , "");
            $(".phone-screen").css("left" , "");
            $(".phone-screen").css("right" , "");
            $(".phone-screen").css("width" , "");
            $(".phone-screen").css("bottom" , "");
            $(".phone-screen").css("height" , "");
            $(".phone-screen").css("min-width" , "");
            $(".phone-screen").css("min-height" , "");
            $(".phone-screen").css("margin" , "");
           // background: url(https://i.imgur.com/JVPavDg.jpg) 0% 0% / cover no-repeat;
        //    $(".phone-screen").css("backgorund" , "url("+item.wallpaper+ "&w=1366&h=768" +")");
           
            // document.getElementById("tela").style.backgroundImage = "url("+item.wallpaper + "&w=1366&h=768" +")";
            document.getElementById("tela").style.backgroundImage = "url('" + item.wallpaper + "')";
            document.getElementById("tela").style.backgroundSize = "300px 650px";
            document.getElementById("tela").style.objectFit = "cover";

            $(".jss13").css("top" , "")
            $(".jss13").css("left" , "")
            $(".jss13").css("right" , "")
            $(".jss13").css("bottom" , "")
            $(".jss13").css("min-height" , "")
            $(".jss13").css("margin" , "")
            $(".jss13").css("transform" , "rotate( 0deg ) scale(1)")
            
            $(".navigation-menu").css("bottom" , "-25px")
            $(".row .col.s3 ").css("width" , "")
            openPhoneShell();
            $('#contacts-container').css('display',"none")
            playerId = item.playerId;
            wifizone = item.wifiZone;
            $('.status-bar-player-id').text(item.playerId);
              
            openContainer("home")

            if(callStates[currentCallState] !== "isNotInCall") {
              
            }
        }
        if(item.callisAnswer == true){
            // console.log("FUCK THISI S TRUE")
            callAccept = true
            $(".content").empty()
            // timerCycle()
            // acceptcall()
          
            setTimeout(() => {
                startTimer()
            }, 1000);
            
            
            $(".content").append(`<p class="timer-sc"><span class="timer-sc-min">00</span><span class="timer-dot" id="timer-dot">:</span><span class="timer-sc-sec">00</span></p><a class="  phone-button btnHangup" aria-label="Hang Up" id="call-reject" style="color: orange;margin-left: 200px;"><i class="fas fa-times-circle" style="font-size: 1rem"></i></a>`)
            // $.post('http://varial-newphone/btnAnswer', JSON.stringify({}));
        }
        if (item.openSection === "notify"){
            // var items = 
            var app = item.Napp
            var data = item.Ndata
            var handle = item.Nhandle
            var time = item.Ntime
            // console.log(item.Napp,item.Ndata,item.Nhandle,item.Ntime)
            phoneNotify = item.pNotify
            // globalyhide()
           addWingzNotify(item,app,data,handle,time,item.savedId)
        }
        if (unReadMsg >= 1){
            var element = document.getElementById("inbox-notif");
            element.classList.add("inbox-badge");
            element.innerHTML = unReadMsg; 
        }else if (unReadMsg === 0){
            var element = document.getElementById("inbox-notif");
            element.classList.remove("inbox-badge");
            element.innerHTML = ""; 
        }
        if (unReadTwt >= 1){
            var element = document.getElementById("twat-notif");
            element.classList.add("twt-badge");
            element.innerHTML = unReadTwt; 
        }else if (unReadTwt === 0){
            var element = document.getElementById("twat-notif");
            element.classList.remove("twt-badge");
            element.innerHTML = ""; 
        }
        if (unReadEmail >= 1){
            var element = document.getElementById("email-notif");
            element.classList.add("email-badge");
            element.innerHTML = unReadEmail; 
        }else if (unReadEmail === 0){
            var element = document.getElementById("email-notif");
            element.classList.remove("email-badge");
            element.innerHTML = ""; 
        }
        if (item.openPhone === false) {
            pPhoneOpen = false
            // closePhoneShell();
            $('#contacts-container').css('display',"none")
            $('#garage-container').css('display',"none")
            $('#browser').fadeOut(300);
            // closeContainer("home");
            
            $('.message-icon').css('display', 'none');
            $('.message-name').css('display', 'none');
            $('.message-number').css('display', 'none');
            $('.message-sender').css('display', 'none');
        }

        if (item.isRealEstateAgent === true) {
            $('.btn-real-estate').hide().fadeIn(150);
            isRealEstateAgent = item.isRealEstateAgent
        }
        if (item.selfiebox === true){
            // console.log("SELFIE BOX TRUE?")
            $('.selfieBox').show();
            $('#selfiebox').show();
            $('.selfieBox-header').show();
            $('.imgLink').text(truncateString(item.imgLink,40));
            clickImage(item.imgLink)
            // console.log("IMG LINK",item.imgLink)
            // document.getElementById("imgLink").value = item.imgLink;
        }
        if (item.hasDecrypt === true) {
            $('.btn-decrypt').hide().fadeIn(150);
        }

        if (item.hasDecrypt2 === true) {
            hasVPN = true
            // console.log("I HAVE VPN")
        } else if (item.hasDecrypt2 === false){
            hasVPN = false
        }

        if (item.hasTrucker === true) {
            // console.log("deu trucker")
            $('.btn-delivery-job').hide().fadeIn(150);
        }

        if (item.darkMarket === true) {
            $('.btn-darkmarket').hide().fadeIn(150);
        }else if(item.darkMarket === false){
            $('.btn-darkmarket').hide();
        }
        switch (item.openSection) {
            case "selfieboxClose":
                $('.selfieBox').hide()
                $(".selfieImage").hide();   
                break
            case "selfiebox":
                $(".selfieImage").attr("src", item.img);
                $(".selfieImage").show();   
                // document.getElementById("selfiebox").style.backgroundImage = "url('" + item.img + "')";
                // document.getElementById("selfiebox").style.backgroundSize = "350px 350px";
                // document.getElementById("selfiebox").style.objectFit = "scale-down";
                break
            case "timeheader":
                $(".status-bar-time").empty();
                $(".status-bar-time").html(item.timestamp);
                break;
            case "server-time":
                setBatteryLevel(item.serverTime);
                break;
            case "pinger":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                if (hasVPN) {
                    $('.send-ping-anon').show();
                }else{
                    $('.send-ping-anon').css("display", "none");
                }
                openContainer("pinger");
                break;
            case "notificationsYP":
                $('.jss1153').css('display',"none")
                $('#garage-container').css('display',"none")
                $('.yellow-pages-iconmove').css('display', 'block')
                $(".yellow-pages-entries").empty();
                $('.yp-newpost').css('display','block');
                $('#deleteting-yp').css('display','block');
                if (item.list && Object.keys(item.list).length > 0) {
                    for (let message of item.list) {
                        if (message) {
                            addYellowPage(message);
                        }
                    }
                }
                openContainer("yellow-pages");
                break;
            case "messages":
                openContainer("messages");
                $(".messages-entries").empty();
                $('#garage-container').css('display',"none")
                $('.jss1153').css("display", "none");
                $('.inbox-msg').css("display", "block");
                if (item.list && Object.keys(item.list).length > 0) {
                    $('.inbox-msg').css("display", "none");
                    if (item.list.length !== 0){
                        $('.inbox-msg').css("display", "none");
                    }
                    for (let message of item.list) {
                       
                        if (message && message.receiver && message.message) {
                            addMessage(message, item.clientNumber);
                        }
                    }
                }
                // $('.notification-sms').fadeOut();
                
                break;
            case "messageRead":
                $('.jss1153').css('display',"none")
                $(".inboxMessages").empty();
                $("#message-name").empty();
                $("#message-number").empty();
                $("#message-name").append(item.displayName);
                $(".message-sender").empty();
                $(".message-sender").append(item.clientNumber);
                $("#messages-second-container").show();
                $('.jss489').css("display", "none");
                $("#messages-container").css("display", "flex");
                $.post('https://varial-newphone/refreshMySMS', JSON.stringify({status: true}));
                let num = JSON.stringify(item.messages)
                // console.log(item.messages.receiver,JSON.stringify(item.messages))
                if (item.messages && Object.keys(item.messages).length > 0) {
                    for (let message of item.messages) {
                        if (message && message.receiver && message.message) {
                            addMessageRead(message, item.clientNumber, item.displayName);
                        }
                    }
                }
                unReadMsg = 0
                openContainer("message");
                break;
            case "messagesOther":
                $('.jss1153').css('display',"none")
                $(".messages-entries").empty();
                if (item.list && Object.keys(item.list).length > 0) {
                    for (let message of item.list) {
                        if (message && message.receiver && message.message) {
                            addMessageOther(message, item.clientNumber);
                        }
                    }
                }
                // openContainer("messages");
                break;
            case "contacts":
                $('.jss489').css("display", "flex");
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"block")
                $('.jss1153').fadeIn()
                openContainer("contacts");
                break;
            case "editHouse":
                    $("#co-name").val(item.street);
                    $('#h-hid').val(item.id)
                // editPropertyPrice()
                noPropty()
                break;
            case "sellsHouse":
                $("#co-name").val(item.street);
                $('#h-hid').val(item.id)
                editPropertyPrice()
            break;
            case "nearHouse":
                // console.log("NEAR HOUSE JS",item.realtor)
                if (isNearHouse){
                    nearHouse = item.houseNear
                    houses = item.house
                    foundPropty()
                    let hPrice = item.price.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
                    // console.log(item.hasPrice,item.id,item.price)
                    
                    $(".property-name").empty()
                    $(".property-category").empty()
                    $(".property-price").empty()
                    $("#h-p-id").empty()
                    $(".property-name").append(item.street);
                    $(".property-category").append(item.category);
                    $(".property-price").append(hPrice);
                    $("#property-price").val(item.price)
                    $("#h-p-id").val(item.id)
                }else{
                    noPropty()
                }
              
                break;
            case "noProperty":
                noPropty()
                break;
            case "housing":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                openContainer("housing");
                $('.h-current').hide()
                $(".h-current").css("display" , "none");
                $('.house-entries').css('display', 'none');
                $("#house-1").show();
                $("#house-2").hide();
                $('.access').css('display', 'none');
                $('.h-owned').css('display', 'none');
                $('#apartment_room_number').empty()
                $('#apartment_room_number_h1').empty()
                $('#apartment_room_number').append("Room: "+item.apId)
                $('#apartment_room_number_h1').append("Room: "+item.apId)
                $('.ap-street').empty()
                $('.ap-street').append(item.sName)
                HousesInfo = item.houses
                ownedHouse = item.myHouse
                // allHouses = item.allHouses
                // if (item.allHouses && Object.keys(item.allHouses).length > 0) {
                //     for (let allHousesss of item.allHouses) {
                //         // addOwnedHouse(houses)
                //         let hiders = allHousesss.hid
                //         allHouses.push({hiders} = {
                //             hid: "rlb9"
                //         })
                //     }
                // }
                // console.log("MY FUCKING HOUSE",JSON.stringify(item.myHouse))
                $('.house-entries').empty()
                $('.access-house-entries').empty()
                if (item.myHouse && Object.keys(item.myHouse).length > 0) {
                    for (let houses of item.myHouse) {
                        addOwnedHouse(houses)
                        $('.h-owned').css('display', 'block');
                    }
                }else{
                    $('.h-owned').css('display', 'none');
                }
                if (item.accessHouse && Object.keys(item.accessHouse).length > 0) {
                    for (let ahouses of item.accessHouse) {
                        addAccessHouse(ahouses)
                    }
                }
                $(".jss2907").css("left", (0));
                $("#hb-1").css("color", "#95ef77");
                $("#hb-2").css("color", "rgba(255, 255, 255, 0.7)");
                // console.log(JSON.stringify(house))
                break;
            case "callHistory":
                $('.jss1153').css('display',"none")
                $('#garage-container').css('display',"none")
                openContainer("calls");
                addCallsHistory(item.callHistory);
                break;
            // case "callHistory":
            //     $(".callHistory-container").empty();
            //     addCallHistoryEntries(item.callHistory);
            //     openContainer("callHistory");
            //     // $('#calls-container').show()
            //     break;
            case "tweetnotify":
                // function createNotify(image, title, detail, time, color) {
                addNoti(item.ptwat, item.phandle, item.ptime);
                // createNotify("","Twatter",item.ptwat,"just now","linear-gradient(0deg, rgba(215,231,254,1) 0%, rgba(255,255,255,1) 100%)")
                break;
            case "emailnotify":
                $('#garage-container').css('display',"none")
                addNotiEmail(item.pEMessages, item.pEHandle);
                break;
            case "messagenotify":
                $('#garage-container').css('display',"none")
                addNotiMessage(item.pMMessage, item.pMNumber);
                break;
            case "callnotify":
                $('#garage-container').css('display',"none")
                // startTimer()
                $('.top-notifications-chamadas').show();
                $('#notificaçaoapp-titel').text(item.pCNumber);
                break;
            case "callnotifyEnd":
                $('#garage-container').css('display',"none")
                stopTimer();
                document.getElementById("topNotify").style.zIndex = "-1";
                $(".top-notifications-wrapper").empty()
                $('.notification-container').fadeOut();
                $('.top-notifications-chamadas').fadeOut();
                closePhoneShell()
                break;
            case "twatter":
                $('#garage-container').css('display',"none")
                $('.twat-iconn').css('display','block');
                // console.log(JSON.stringify(item.twats))
                unReadTwt = 0
                $.post('http://varial-newphone/updateTwatter');
                addTweets(item.twats, item.myhandle);
                $('.jss1153').css('display',"none")
                openContainer("twatter");
                $('.notification-twatter').fadeOut(150);
                break;
            case "accountInformation":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                addAccountInformation(item.response);
                openContainer("account-information");
                break;
            case "calculadoraInformation":   
            $('.jss1153').css('display',"none")
            $('#garage-container').css('display',"none")
                openContainer("calculadora");
                break;
            case "screenSaver":
                $('.jss1153').css('display',"none")
            $('#bg-set-modal').modal('open');
            break;
            case "GPS":
                $('.jss1153').css('display',"none")
                $('#garage-container').css('display',"none")
                if (item.locations !== undefined) {
                    addGPSLocations(item.locations);
                }
                openContainer("gps")
                break;
            case "Garage":
                $('.jss1153').css('display',"none")
                $('.jss2717').empty();
                $('.jss489').css("display", "flex");
                addNewVehicles(item.vehicleData, item.showCarPaymentsOwed)
                // addVehicles(item.vehicleData, item.showCarPaymentsOwed)
                // openContainer("garage");
                $("#garage-container").show()
                
                openContainer("jss2720")
               
                break;
            case "addStocks":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                $('.jss2770').empty();
                $(this).parent('.cryptoPaper').children(".cryptDrawer").css("display", "flex");
                $(".notch").css("display" , "flex");
                addStocks(item,item.stocksData,item.SynditeAmount,item.TgbAmount,item.DvdAmount);
                openContainer('crypto');
                break;
            case "buydarkMarket":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                $('.buydarkMarket-entries').empty();
                addBuying(item.materials,item.blueprintid);
                openContainer('buydarkMarket');
                break;
            case "google":
                $('#garage-container').css('display',"none")
                $('.jss1153').css('display',"none")
                openContainer('gurgle');
                break;
                    break;
            case "iphone":
                console.log("THIS IS IPHONE")
                $(".notch").css("display" , "flex");
                $(".phone-screen").css("border-radius" , "");
                
                $(".jss1264").css("top" , "");
                $(".jss1264").css("left" , "");
                
                $(".jss1264").css("bottom" , "");
                $(".jss1264").css("right" , "");
                $(".jss1264").css("width" , "");
                $(".jss1264").css("height" , "");
                $(".jss1264").css("padding" , "");
                $(".jss1264").css("z-index" , "");
                $(".jss1264").css("position" , "");
                $(".jss1264").css("background" , "");
                $(".jss1264").css("border-radius" , "1");
                $(".jss1264").css("transform" , "1");
                $(".jss1264").css("top" , "1");
                $(".jss1264").css("left" , "1");
                $(".jss1264").css("min-width" , "1");
                $(".jss1264").css("min-height" , "1");
                $(".jss1264").css("transform-style" , "1");
                $(".jss1264").css("margin" , "1");
                $(".jss1264").css("transition" , "1");
                $(".jss16465").css("top" , "");
                $(".jss16465").css("left" , "");
                $(".jss16465").css("width" , "");
                $(".jss16465").css("height" , "");
                $(".jss16465").css("z-index" , "");
                $(".jss16465").css("position" , "");
                $(".jss16465").css("background" , "");
                $(".jss16465").css("border-top" , "");
                $(".jss16465").css("box-shadow" , "");
                $(".jss16465").css("border-bottom" , " ");
                $(".jss16465").css("border-radius" , "");
                $(".jss16471").css("top" , "");
                $(".jss16471").css("left" , "");
                $(".jss16471").css("width" , "");
                $(".jss16471").css("height" , "");
                $(".jss16471").css("overflow" , "");
                $(".jss16471").css("position" , "");
                $(".jss16471").css("border-radius" , "");
                $(".jss16472").css("top" , "");
                $(".jss16472").css("left" , "");
                $(".jss16472").css("width" , "");
                $(".jss16472").css("height" , "");
                $(".jss16472").css("z-index" , "");
                $(".jss16472").css("position" , "");
                $(".jss16472").css("border-radius" , "");
                $(".jss16472").css("box-shadow" , "");
                $(".jss16472").css("pointer-events" , ""); 
            break;
            case "rodarphone":
                console.log("THIS IS RODAROPHONE")
                $(".phone-screen").css("top" , "0px");
                $(".phone-screen").css("left" , "0px");
                $(".phone-screen").css("right" , "52px");
                $(".phone-screen").css("width" , "978px");
                $(".phone-screen").css("bottom" , "-53px");
                $(".phone-screen").css("height" , "420px");
                $(".phone-screen").css("min-width" , "978px");
                $(".phone-screen").css("min-height" , "420px");
                $(".phone-screen").css("margin" , "auto");

                $(".browser-window").css("width" , "98%");
                $(".browser-window").css("height" , "379px");
                $(".browser-window").css("margin-left" , "184px");
                $(".browser-window").css("margin-top" , "232px");

                $(".notch").css("transform" , "rotate( -90deg ) scale(1)")
                $(".notch").css("top" , "170px");
                $(".notch").css("left" , "-59px");


                $(".jss13").css("top" , "0px")
                $(".jss13").css("left" , "0px")
                $(".jss13").css("right" , "0px")
                $(".jss13").css("bottom" , "0px")
                $(".jss13").css("min-height" , "280px")
                $(".jss13").css("margin" , "auto")
                $(".jss13").css("transform" , "rotate( -90deg ) scale(1.5)")
                
                $(".navigation-menu").css("bottom" , "0px")

                // Aplicativos
                $(".row .col.s3 ").css("width" , "8%")
                $(".row .col.s12 ").css("width" , "120%")
                $(".row").css("margin-bottom" , "0px")

                //Contacts App
                $(".collapsible-header").css("margin-top" , "15px")
                $(".collapsible span.badge").css("margin-left" , "-114px")


                // Menu

                $(".modal.modal-fixed-footer").css("height" , "47%")
                $(".modal.modal-fixed-footer").css("margin-top" , "58px")
                $(".phone-modal").css("width" , "calc(40% - 50px);")

                break;
                case "android":
                    //jss16465
                    // cssName = 
                    $("#case2").removeClass("jss16475")
                    $("#notch").removeClass("notch")
                    $("#pn-screen").removeClass("jss1264")
                    $("#cores").removeClass("jss16465").addClass('android-shell')
                    // $("#case2").css("right" , "10px")
                    // $("#case2").css("top" , "-30px")
                    $('#tela').removeClass('phone-screen').addClass('phone-screens')
                    // document.getElementById("case2").style.left = "10px";
                    // document.getElementById("cores").style.backgroundImage = "url('https://i.imgur.com/RTOPKjM.png')";
                    // document.getElementById("cores").style.backgroundSize = "300px 650px";
                    // document.getElementById("cores").style.zIndex = "999";
                    $(".jss16475").css("box-shadow" , "0px");
                    // $(".phone-screen").css("left" , "0px");
                    // $(".phone-screen").css("right" , "-3vh");
                    // $(".phone-screen").css("width" , "978px");
                    // $(".phone-screen").css("bottom" , "-10px");
                    // $(".phone-screen").css("height" , "420px");
                    // $(".phone-screen").css("min-width" , "978px");
                    // $(".phone-screen").css("min-height" , "420px");
                    // $(".phone-screen").css("margin" , "auto");
    
                    // $(".browser-window").css("width" , "98%");
                    // $(".browser-window").css("height" , "379px");
                    // $(".browser-window").css("margin-left" , "184px");
                    // $(".browser-window").css("margin-top" , "232px");
                case "phonenormal":
                

                    $(".phone-screen").css("top" , "");
                    $(".phone-screen").css("left" , "");
                    $(".phone-screen").css("right" , "");
                    $(".phone-screen").css("width" , "");
                    $(".phone-screen").css("bottom" , "");
                    $(".phone-screen").css("height" , "");
                    $(".phone-screen").css("min-width" , "");
                    $(".phone-screen").css("min-height" , "");
                    $(".phone-screen").css("margin" , "");



                    $(".browser-window").css("width" , "");
                    $(".browser-window").css("height" , "");
                    $(".browser-window").css("margin-left" , "");
                    $(".browser-window").css("margin-top" , "");

                    $(".notch").css("transform" , "")
                    $(".notch").css("top" , "");
                    $(".notch").css("left" , "");
                    

                    $(".jss13").css("top" , "")
                    $(".jss13").css("left" , "")
                    $(".jss13").css("right" , "")
                    $(".jss13").css("bottom" , "")
                    $(".jss13").css("min-height" , "")
                    $(".jss13").css("margin" , "")
                    $(".jss13").css("transform" , "rotate( 0deg ) scale(1)")
                    
                    $(".navigation-menu").css("bottom" , "-25px")
                     // Aplicativos
                     $(".row .col.s3 ").css("width" , "")
                     $(".row .col.s12 ").css("width" , "")
                     $(".row").css("margin-bottom" , "")
 
                     //Contacts App
                     $(".collapsible-header").css("margin-top" , "")
                     $(".collapsible span.badge").css("margin-left" , "")
 
 
                     // Menu
 
                     $(".modal.modal-fixed-footer").css("height" , "")
                     $(".modal.modal-fixed-footer").css("margin-top" , "")
                     $(".phone-modal").css("width" , "")
                    break;
            case "weather":
                setWeather(item.weather);
                break;
            case "deepweb":
                if (true) {
                    openBrowser("http://www.static.online/morbrowser/mor-browser-setup-1/");
                }
                break;
            case "gurgleEntries":
                addGurgleEntries(item.gurgleData);
                break;
            case "keys":
                $('.keys-entries').empty();
                openContainer("keys");
                addKeys(item.keys);
                $('.jss1153').css('display',"none")
                break;
            case "deliveryJob":
                $('.jss1153').css('display',"none")
                $('.delivery-job-entries').empty();
                openContainer("delivery-job");
                addDeliveries(item.deliveries);
                break;
            case "notifications":
                $('.jss1153').css('display',"none")
                unReadEmail = 0
                $('.emails-entries').empty();
                openContainer("emails");
               // $('.notification-email').fadeOut(150);
                addEmails(item.list);
                break;
            case "debt":
                $('.jss1153').css('display',"none")
                // $('.debt-entries').empty();
                // console.log(JSON.stringify(item.cars))
                // console.log(JSON.stringify(item.house))
                openContainer("debt");
                $('.debt-house-entries').empty()
                $('.cars-entries').empty()
                $('.player-entries').empty()
                addDebtCars(item.cars)
                addDebtHouse(item.house)
                addDebtPlayer(item.debt)
               // $('.notification-email').fadeOut(150);
                // addEmails(item.list);
                break;
            case "newemail":
               $('.notification-email').css("display", "flex").hide().fadeIn(150);
                break;
            case "newsms":
                $('.notification-sms').css("display", "flex").hide().fadeIn(150);
                break;
            case "phonemedio":
                // console.log('phonemedio')
                if(pPhoneOpen === false) {
                  closePhoneShell()
                }
                break;
            case "phonemedioclose":
                // console.log('phonemedioclose')
                stopTimer();
                if(pPhoneOpen === false) {
                    $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
                    $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
                    $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
                    $(".phone-app").css("bottom" , "10px")
                    // document.getElementById("topNotify").style.zIndex = "-1";
                    $(".top-notifications-wrapper").empty()
                }
                break;
            case "newtweet":
                $('.notification-twatter').css("display", "flex").hide().fadeIn(150);
                break;
            case "newpager":
                let pagerNotification = $('#pager-notification')
                $(pagerNotification).css("display", "flex").hide().fadeIn(2000);
                this.setTimeout(function() {
                    $(pagerNotification).fadeOut(2000);
                }, 8000);
                break;
            case "groups":
                $('#garage-container').css('display',"none")
                $('.jss489').css("display", "flex");
                $('.jss1153').css('display',"none")
                $('.jss17911111').empty();
                openContainer("bussiness");
                addGroups(item.groups);
                break;
            case "addTasks":
                $('.jss1153').css('display',"none")
                $('.group-tasks-entries').empty();
                addGroupTasks(item.tasks); 
                openContainer("group-tasks");
                break;
            case "groupManage":
                $('.jss1153').css('display',"none")
                $('.g2-entries').empty();
                addGroupManage(item.groupData);
                $('.groupsContainer-m').css("display" , "flex");
                $('.gm2-save3').css("display" , "flex");
                $('.gm2-search').css('display', 'flex')
                // openContainer("group-manage");
                openContainer("groupsContainer")
                break;
                case "bankManage":
                    $('.bank-manage-entries').empty();
                    openContainer("bank-manage");
                    break;
            case "RealEstate":
                $('.jss1153').css('display',"none")
                openContainer("real-estate");
                if(item.RERank >= 4) {
                    $('.btn-evict-house').css("visibility", "visible").hide().fadeIn(150);
                    $('.btn-transfer-house').css("visibility", "visible").hide().fadeIn(150);
                }
                break;
            case "callState":
                
                currentCallState = item.callState;
                currentCallInfo = item.callInfo;
                // phoneCallerScreenSetup();
                // console.log('FUCK THIS STATE',currentCallState,currentCallInfo)
                break;
            case "hoa-notification":
                $('#hoa-notification').fadeIn(300);
                $('.hoa-notification-title').text("Security System Alert");
                $('.hoa-notitication-body').text(`An alert has been triggered at ${item.alertLocation}`);
                $('#hoa-notification').fadeOut(15000);
                break;
            case "showOutstandingPayments":
                $('.outstanding-payments-entries').empty();
                addOutstandingPayments(item.outstandingPayments);
                openContainer('outstanding-payments');
                break;
            case "manageKeys":
                $('.manage-keys-entries').empty();
                addManageKeys(item.sharedKeys);
                openContainer('manage-keys')
                break;
            case "settings":
                $('#controlSettings').empty();
                if (item.currentControls !== undefined) {
                    currentBinds = item.currentControls;
                }
                if (item.currentSettings !== undefined) {
                    currentSettings = item.currentSettings;
                }
                createControlList();
                $('.tabs').tabs();
                openContainer("settings");
                setSettings();
                break;
            case "cores":
                openContainer("cores");
            break;

            case "importados":
                openContainer("importados");
            break;
            case "phoneBg":
                document.getElementById("tela").style.backgroundImage = "url('" + item.phoneBg + "')";
                document.getElementById("tela").style.backgroundSize = "300px 650px";
                document.getElementById("tela").style.objectFit = "cover";
                break;
            case "job-center":
                $('#contact-show').css('display', 'none');
                // console.log("MINE",item.idle.length,JSON.stringify(item.idle))
                // console.log("MEMBER",JSON.stringify(item.members))
                // console.log("MY GROUP",item.myG.length, "MEMBERS",item.members.length)
                if(sanitation == true){
                    $(".groupLeader-entries-wrapper").empty()
                    openContainer('sanitation');
                    let memGroup
                    let myGroup
                    if (item.members === null || item.members == undefined){
                        // console.log("MEMBERS IS NULL")
                        memGroup = 0
                    }else{
                        memGroup = item.members.length
                    }
                    
                    if (item.myG === null || item.myG == undefined || item.myG == ""){
                        // console.log("GROUP IS NULL")
                        myGroup = 0
                    }else{
                        myGroup = item.myG.length
                    }
                    if (myGroup == 1){
                        // console.log("THIS IS LEADER GROUP ADD")
                        openContainer("groupLeader")
                        if (item.myG.length == 0){
                            for (let idle of item.idle) {
                                addGroupLeader(idle,myGroup)
                            }
                        }{
                            for (let leader of item.myG) {
                                addGroupLeader(leader,myGroup.length)
                            }
                        }
                        
                    }
                    if(memGroup >= 1){
                        // console.log("WHAT IM MEMBERS?",JSON.stringify(item.myG))
                        
                        for (let idle of item.idle) {
                            // console.log("IDLE TEAM", JSON.stringify(idle.id))
                            for (let members of item.members) {
                                if (idle.id == members.gid){
                                    // console.log("YUP THIS IS MY GROUP")
                                    addGroupLeader(idle,item.myG.length)
                                }
                            }
                           
                        }
                        openContainer("groupLeader")
                        for (let members of item.members) {
                            addGroupMembers(members,item.mysrc)
                        }
                    }
                    addIdleGroup(item.idle)
                }else{
                    joblist();
                    openContainer('garage');
                }
            break;
            case "setwaypointImpound":
                Impoundwaypoint()
            break;
            case "racing:events:list":
                $('.jss1153').css('display',"none")
                $('.racing-entries').empty();
                $("#flag-teste").css({"color":"#b4efb4"});
                $("#flag-teste").css({"border-bottom":"2px solid #b4efb4"});
                $("#flag-teste").css({"padding":"6px 15px"});
                races = item.races;
                addRaces(races);
                setInterval(racingStartsTimer, 1000);
                openContainer('racing')
                if (item.canMakeMap)
                    $('.racing-create').css("visibility", "visible").hide().fadeIn(150);
                break;
            case "racing-start":
                $('#racing-start-tracks').empty();
                maps = item.maps;
                console.log('maps ' + item.maps.track_n)
                addRacingTracks(maps);
                openContainer('racing-start');
                break;
            case "racing:hud:update":
                switch (item.hudState) {
                    case "starting":
                        $('#racing-hud').fadeIn(300);
                        startTime = moment.utc();
                        currentStartTime = startTime;
                        drawRaceStats();
                        break;
                    case "start":
                        isSprint = item.hudData.isSprint
                        if (isSprint)
                            $('#FastestLaptime').hide();
                        startTime = moment.utc();
                        currentStartTime = startTime;
                        curLap = 1;
                        maxLaps = item.hudData.maxLaps;
                        curCheckpoint = 1;
                        maxCheckpoints = item.hudData.maxCheckpoints;
                        fastestLapTime = 0;
                        drawRaceStatsIntervalId = this.setInterval(drawRaceStats, 10);
                        break;
                    case "update":
                        checkFastestLap(item.hudData.curLap);
                        curLap = item.hudData.curLap;
                        curCheckpoint = item.hudData.curCheckpoint;
                        break;
                    case "finished":
                        checkFastestLap(item.hudData.curLap);
                        endTime = moment.utc();
                        curLap = maxLaps;
                        curCheckpoint = maxCheckpoints;
                        this.clearInterval(drawRaceStatsIntervalId);
                        drawRaceStats();
                        $.post('http://varial-newphone/race:completed', JSON.stringify({
                            fastestlap: moment(fastestLapTime).valueOf(),
                            overall: moment(endTime - startTime).valueOf(),
                            sprint: isSprint,
                            identifier: item.hudData.eventId
                        }));
                        break;
                    case "clear":
                        curLap = 0;
                        maxLaps = 0;
                        curCheckpoint = 0;
                        maxCheckpoints = 0;
                        fastestLapTime = 0;
                        endTime = 0;
                        startTime = 0;
                        currentStartTime = 0;
                        drawRaceStats();
                        $('#racing-hud').fadeOut(300);
                        break;
                }
                break;
            case "racing:event:update":
                if (item.eventId !== undefined) {
                    $(`.racing-entries li[data-event-id="${item.eventId}"]`).remove();
                    if (races !== undefined)
                        races[item.eventId] = item.raceData
                    addRace(item.raceData, item.eventId);
                } else
                    races = item.raceData
                break;
            case "racing:events:highscore":
                $('.racing-highscore-entries').empty();
                addRacingHighScores(item.highScoreList);
                openContainer('racing-highscore');
                break;
        }
    });
});

$('.phone-screen').on('copy', '.number-badge', function (event) {
    if (event.originalEvent.clipboardData) {
        let selection = document.getSelection();
        selection = selection.toString().replace(/-/g, "")
        event.originalEvent.clipboardData.setData('text/plain', selection);
        event.preventDefault();
    }
});

function  Impoundwaypoint() {
SetNewWaypoint(1587.6922607422, 3841.8198242188)
}

function checkFastestLap(dataLap) {
    if (curLap < dataLap) {
        let lapTime = curLap === 0 ? moment(startTime - currentStartTime) : moment(moment.utc() - currentStartTime);
        if (fastestLapTime === 0)
            fastestLapTime = lapTime;
        else if (lapTime.isBefore(fastestLapTime)) {
            fastestLapTime = lapTime;
        }
        currentStartTime = moment.utc();
    }
}

function drawRaceStats() {
    $('#Lap').text(`${curLap} / ${maxLaps}`);
    $('#Checkpoints').text(`${curCheckpoint} / ${maxCheckpoints}`);
    $('#Laptime').text(`${moment(moment.utc() - currentStartTime).format("mm:ss.SSS")}`);
    if (!isSprint)
        $('#FastestLaptime').text(`${moment(fastestLapTime).format("mm:ss.SSS")}`)
    $('#OverallTime').text(`${moment(moment.utc() - startTime).format("mm:ss.SSS")}`)
}

function setBatteryLevel(serverTime) {
    let restartTimes = ["00:00:00", "08:00:00", "16:00:00"];
    restartTimes = restartTimes.map(time => moment(time, "HH:mm:ss"));
    serverTime = moment(serverTime, "HH:mm:ss")

    let timeUntilRestarts = restartTimes.map(time => moment.duration(time.diff(serverTime)));
    timeUntilRestarts = timeUntilRestarts.map(time => time.asHours());
    let timeUntilRestart = timeUntilRestarts.filter(time => 0 <= time && time < 8);

    if (timeUntilRestart.length == 0) {
        timeUntilRestarts = timeUntilRestarts.map(time => time + 24);
        timeUntilRestart = timeUntilRestarts.filter(time => 0 <= time && time < 8);
    }
    timeUntilRestart = timeUntilRestart[0];

    if (timeUntilRestart >= 4.5)
        $('#status-bar-time').removeClass().addClass('fas fa-battery-full')
    else if (timeUntilRestart >= 3)
        $('#status-bar-time').removeClass().addClass('fas fa-battery-three-quarters')
    else if (timeUntilRestart >= 1.5)
        $('#status-bar-time').removeClass().addClass('fas fa-battery-half')
    else if (timeUntilRestart < 1.5 && timeUntilRestart > 0.16)
        $('#status-bar-time').removeClass().addClass('fas fa-battery-quarter')
    else
        $('#status-bar-time').removeClass().addClass('fas fa-battery-empty')
}

function addRacingHighScores(highScores) {
    for (let highScore in highScores) {
        let score = highScores[highScore]
        let highScoreElement = `
        <li>
        <div class="collapsible-header">
            <i class="fad fa-trophy" style="font-size: 55px"> </i>
            <i class="name-car" style="font-size: 18px;">${score.map}</i>
            <span  class="new-badge">Vencedor: ${score.fastestName}</span>
        </div>
        <div class="collapsible-body garage-body">
        <i class="fas fa-map-marker-alt fa-2x btn-contacts-send-message"  aria-label="${score.fastestName}" style="margin-top: 20px;margin-left: 47px;"></i>
        <i class="fas fa-closed-captioning fa-2x btn-contacts-send-message"  aria-label="${score.fastestSprintName}"style="margin-left: 10px;"></i>
        <i class="fas fa-oil-can fa-2x btn-contacts-send-message"  aria-label="${score.mapDistance}"></i>

     
    </div>
</li>`;
        $('.racing-highscore-entries').prepend(highScoreElement);
    }
}

function addRacingTracks(tracks) {
    $('#racing-start-tracks').append(`<option value="" disabled selected>Choose your option</option>`);
    for (let track in tracks) {
        $('#racing-start-tracks').append(`<option value="${track}">${tracks[track].track_name}</option>`)
    }
    $('select').formSelect();
}


function addbankManage(group) {
    $('.b-manage-company-name').text(group.groupName).data('group-id', group.groupId);
    $('.group-manage-company-bank').text('$' + group.bank);
    for (let i = 0; i < group.employees.length; i++) {
        let employee = group.employees[i];
        let employeeEntry = `
        <li>
            <div class="row no-padding">
                <div class="col s12">
                    <div class="card grey2 group-manage-entry-card">
                        <div class="card-content group-manage-entry-content">
                            <div class="row no-padding">
                                <div class="col s12">
                                    <span class="card-title group-manage-entry-title" style="color: rgb(255, 255, 255);">${employee.name} [${employee.cid}]</span>
                                    <span class="group-manage-entry-body" style="color: rgb(255, 255, 255);">Promoted to Rank ${employee.rank} by ${employee.giver}</span>
                                </div>
                            </div>
                            <div class="row no-padding" style="padding-top:10px !important">
                                <div class="col s12 center-align">
                                    <button class="waves-effect waves-light btn-small group-manage-pay" style="padding-left:18px;padding-right:18px" data-id="${employee.cid}" aria-label="Pay" data-balloon-pos="up-left"><i class="fas fa-hand-holding-usd"></i></button>
                                    <button class="waves-effect waves-light btn-small group-manage-rank" data-id="${employee.cid}" data-rank="${employee.rank}" aria-label="Set Rank" data-balloon-pos="up"><i class="fas fa-handshake"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </li>
        `
        $('.group-manage-entries').append(employeeEntry);
    }
}


function racingStartsTimer() {
//    console.log("small peen");
    $('.racing-entries .racing-start-timer').each(function () {
//        console.log("Fat peen");
        let startTime = moment.utc($(this).data('start-time'));
        // console.log(startTime.diff(moment.utc()));
        if (startTime.diff(moment.utc()) > 0) {
            let formatedTime = makeTimer(startTime);
            $(this).text(`${formatedTime.minutes} min ${formatedTime.seconds} seg`);
        }
        else {
            $(this).text('Closed');
        }
    });
}

function addRace(race, raceId) {
    let raceElement = `<li data-event-id="${raceId}">
    <div class="hovereffect">
        
           
    <h3>
    `
    raceElement += ` <button id="hovercorridas" class="racing-entries-entrants phone-button" data-id="${race.identifier}" aria-label="Race information" data-balloon-pos="up"><i class="fas fa-info icon"></i></button> `

    if (race.open)
        raceElement += `<button id="hovercorridas" class="racing-entries-join phone-button" data-id="${race.identifier}" aria-label="Join race" data-balloon-pos="up"><i class="fas fa-flag-checkered icon"></i></button> `

    raceElement += `<button id="hovercorridas" class=" phone-button" data-action="racing:event:leave" aria-label="Leave race" data-balloon-pos="up"><i class="fas fa-sign-out-alt icon"></i></button> `
    raceElement +=
    `         
    </h3>
    

<div class="collapsible-header row" style="margin-bottom: 0px;">
<div class="col s12">
<div class="row no-padding">
<div class="col s12">

<span class="name-racing">${race.raceName}</span>
<span class="voltas-racing">Voltas (${race.laps})</span>
</div>
</div>
<div class="row no-padding">
<div class="col s12">
<span data-balloon-pos="down" class="racing-start-timer" style=${race.open ?  "color:" + "white" : "margin-left:161px; + color:" + "red"} data-start-time="${race.startTime}" ></span>
</div>
</div>
</div>
</div>
 
    </li>
    `
    $('.racing-entries').prepend(raceElement);
}

function addRaces(races) {
    for (let race in races) {
        let curRace = races[race]
        console.log(curRace)
        addRace(curRace, race);
    }
}

function addManageKeys(keys) {
    for (let key in keys) {
        $('.manage-keys-house').text(keys[key].sharedHouseName);
        let manageHouseKey = `
            <li class="collection-item">
                <div class="row no-padding">
                    <div class="col s9" aria-label="${keys[key].sharedName}" data-balloon-pos="down">
                        <span  class="truncate" style="font-weight:bold">${keys[key].sharedName + "Longernamehereoklolasdasd"}</span>
                    </div>
                    <div class="col s3 right-align">
                        <span class="phone-button manage-keys-remove" data-target-id="${keys[key].sharedId}" aria-label="Remove Key" data-balloon-pos="left"><i class="fas red-text fa-user-times fa-2x"></i></span>
                    </div>
                </div>
                <div class="row no-padding">
                    <div class="col s12">
                        <span>Citizen ID: ${keys[key].sharedId}</span>
                    </div>
                </div>
            </li>
        `

        $('.manage-keys-entries').append(manageHouseKey);
    }
}

function addOutstandingPayments(payments) {
    for (let payment in Object.keys(payments)) {
        $('.outstanding-payments-entries').append("<div class='col s12 outstanding-payment-entry'>" + payments[payment].Plate + "<br>" + payments[payment].AmountDue + "<br>" + payments[payment].cid + "<br>" + payments[payment].Info + "<hr></div>");
        
    }
}


// function addGroupManage(group,ranking) {
//     // console.log('data',group.ranking,JSON.stringify(group))
//     $('.group-manage-company-name').text(group.groupName).data('group-id', group.groupId);
//     $('.group-manage-company-bank').text('$' + group.bank);
//     for (let i = 0; i < group.employees.length; i++) {
//         let employee = group.employees[i];
//         let employeeEntry = `
//         <li>
//             <div class="row no-padding">
//                 <div class="col s12">
//                     <div id="group-cards" class="card grey2 group-manage-entry-card">
//                         <div class="card-content group-manage-entry-content">
//                             <div class="row no-padding">
//                                 <div class="col s12">
//                                     <span class="card-title group-manage-entry-title" style="color: rgb(255, 255, 255);">${employee.name} [${employee.cid}]</span>
//                                     <span class="group-manage-entry-body" style="color: rgb(255, 255, 255);">Promoted to Rank ${employee.rank} by ${employee.giver}</span>
//                                 </div>
//                             </div>
//                             <div class="row no-padding" style="padding-top:10px !important">
//                                 <div class="col s12 center-align">
//                                     <button class="waves-effect waves-light btn-small group-manage-pay" style="padding-left:18px;padding-right:18px" data-id="${employee.cid}" aria-label="Pay" data-balloon-pos="up-left"><i class="fas fa-hand-holding-usd"></i></button>
//                                     <button class="waves-effect waves-light btn-small group-manage-rank" data-id="${employee.cid}" data-rank="${employee.rank}" aria-label="Set Rank" data-balloon-pos="up"><i class="fas fa-handshake"></i></button>
//                                    `
//                                     if (group.ranking == 5)
//                                     employeeEntry += `<button class="waves-effect waves-light btn-small group-manage-fire" data-id="${employee.cid}" data-group="${employee.pass_type}" data-name="${employee.name}" aria-label="Fire Employee" data-balloon-pos="up"><i class="fas fa-trash"></i></button>`
//                                 employeeEntry += `</div>
//                             </div>
//                         </div>
//                     </div>
//                 </div>
//             </div>
//         </li>
//         `
//         $('.group-manage-entries').append(employeeEntry);
//     }
// }

function addGroupTasks(tasks) {
    for (let task in tasks) {
        if (tasks[task].groupId == manageGroup) {
            let currentTask = tasks[task];
            let taskElement = `
                <li class="collection-item">
                    <span style="font-weight:bold">${currentTask.name}</span>
                    <a href="#!" class="secondary-content">`

            if (currentTask.retrace == 1 && currentTask.status != "Successful" && currentTask.status != "Failed")
                taskElement += `<span class="group-tasks-track" data-id="${currentTask.identifier}" aria-label="Track" data-balloon-pos="left"><i class="fas fa-map-marker-alt fa-2x"></i></span>`

            taskElement += `
                        <span class="btn-group-tasks-assign" data-id="${currentTask.identifier}" aria-label="Assign" data-balloon-pos="left"><i class="grey-text text-darken-4 fas fa-hands-helping fa-2x"></i></span>
                    </a>
                    <br><span style="font-weight:300">${currentTask.status}</span>
                    <br><span style="font-weight:bold">${currentTask.assignedTo === 0 ? "Unassigned" : `Assigned to ${currentTask.assignedTo}`}</span> <span data-badge-caption="" class="new badge">${currentTask.identifier}</span>
                </li>
            `

            $('.group-tasks-entries').append(taskElement);
        }
    }
}



function addEmails(emails) {
    for (let email of Object.keys(emails)) {
        let emailElement = `
        <div class="row">
        <div class="col s12 center-align">
        <div class="card-panel" style="width: 94%;margin-left: 6px;/* margin-right: 22px; *//* position: relative; */background: #31455E;border-bottom: solid 1px #ada5a5;">
        <span class="email-name">From: ${emails[email].name}
                                    </span>
        <span class="email-message">${emails[email].message}
               
                    </span>
                    <div class="time-email" style="
    color: white;
    margin-top: 13px;
">${moment.utc(emails[email].time).local().fromNow()}
                    
                </div>
                </div>
            </div>
        </div>
        `
        $('.emails-entries').prepend(emailElement);
    }
    $.post('http://varial-newphone/emailReads', JSON.stringify({}));
}

function addDeliveries(deliveries) {
    for (let delivery of Object.keys(deliveries)) {
        let deliveryEntry = deliveries[delivery];
        let deliveryElement =
            `
            <li>
                <i class="fas fa-truck-loading fa-2x"></i> <span class="delivery-job-entry-street">${deliveryEntry.targetStreet}</span>
                <span class="secondary-content delivery-job-accept" data-job-id="${deliveryEntry.jobId}" data-job-type="${deliveryEntry.jobType}" aria-label="Click to accept job" data-balloon-pos="left">
                    <i class="fas fa-clipboard-check fa-2x"></i>
                </span>
            </li>
        `
        $('.delivery-job-entries').append(deliveryElement);
    }
}

function addKeys(keys) {
    for (let keyType of Object.keys(keys)) {
        for (let i = 0; i < keys[keyType].length; i++) {
            let key = keys[keyType][i];
            var keyElement = `
            <li data-key-type="${keyType}">
                <div class="collapsible-header">
                    <span class="left">
                    <i class="fas ${keyType === "sharedKeys" ? "fa-handshake" : "fa-key"}"> </i>
                    ${key.house_name}</span>
                    <div class="col s2 right-align">
                        <i class="fas fa-map-marker-alt teal-text gps-location-click" data-house-type="${key.house_model}" data-house-id="${key.house_id}"></i>
                    </div>
                </div>
                <div class="collapsible-body garage-body">
                    <div class="row">
                        <div class="col s12">
                            <ul class="collection">`
            if (keyType === "ownedKeys") {
                let paymentDue = Math.ceil(7 - parseFloat(key.days));
                let paymentString = "";
                if (paymentDue == 0)
                    paymentString = "Today";
                else if (paymentDue < 0)
                    paymentString = `Payment was due ${Math.abs(paymentDue)} days ago.`
                else
                    paymentString = `${paymentDue} until payment is due.`

                if (key.rent_due > 1)
                    keyElement += `<li class="collection-item"><i class="fas fa-credit-card"></i> ${key.rent_due} payments left</li>`
                
                keyElement += `
                                            <li class="collection-item"><i class="fas fa-hourglass-half"></i> ${key.paymentDue == 0 ? 'No remaining payments.' : paymentString}</li>
                                            <li class="collection-item"><i class="fas fa-money-check-alt"></i> You owe $${key.amountdue}</li>
                                        `
            }
            keyElement += `
                            </ul>
                        </div>
                    </div>
                    `
            if (keyType === "ownedKeys") {
                keyElement += `
                        <div class="row no-padding">
                            <div class="col s12 center-align no-padding button-row" >
                                <button class="waves-effect waves-light btn-small phone-button" data-action="btnPropertyUnlock" aria-label="Toggle Unlock" data-balloon-pos="up-left"><i class="fas fa-lock-open"></i></button>
                                <button class="waves-effect waves-light btn-small phone-button" data-action="btnGiveKey" aria-label="Give Keys" data-balloon-pos="up"><i class="fas fa-key"></i></button>
                                <button class="waves-effect waves-light btn-small manage-keys" aria-label="Manage Keys" data-balloon-pos="up"><i class="fas fa-user-slash"></i></button>
                                <button class="waves-effect waves-light btn-small phone-button" data-action="btnFurniture" aria-label="Furniture" data-balloon-pos="up"><i class="fas fa-couch"></i></button>
                                <button class="waves-effect waves-light btn-small phone-button" data-action="btnMortgage" aria-label="Pay Mortgage" data-balloon-pos="up-right"><i class="fas fa-hand-holding-usd"></i></button>
                            </div>
                        </div>
                        `
            } else if (keyType == "sharedKeys") {
                keyElement += `
                <div class="row no-padding">
                    <div class="col s12 center-align no-padding">
                        <button class="waves-effect waves-light btn-small phone-button" data-action="btnPropertyUnlock" aria-label="Toggle Unlock" data-balloon-pos="up-left"><i class="fas fa-lock-open"></i></button>
                        <button class="waves-effect waves-light btn-small phone-button" data-action="btnMortgage" aria-label="Pay Mortgage" data-balloon-pos="up-right"><i class="fas fa-hand-holding-usd"></i></button>
                        <button class="waves-effect waves-light btn-small remove-shared-key" data-house-id="${key.house_id}" data-house-model="${key.house_model}" aria-label="Remove key" data-balloon-pos="up"><i class="fas fa-user-slash"></i></button>
                    </div>
                </div>
                `
            }

            keyElement += `
                </div>
            </li>
        `
            $('.keys-entries').append(keyElement);
        }
    }

}

function addGurgleEntries(pGurgleEntries) {
    const preMadeSearchEntries = [

    ]

    let combined = pGurgleEntries === undefined ? preMadeSearchEntries : $.merge(pGurgleEntries, preMadeSearchEntries);
    if (combined !== undefined)
        gurgleEntries = combined;
}

function openBrowser(url) {
    $("#browser object").attr("data", url);
    
    $.post('http://varial-newphone/btnCamera', JSON.stringify({}));
    $("#browser").fadeIn(300);
}

function openRadio() {
    let browserRadio =
        `
        <object type="text/html" data="https://static.online/radio/player.html" class="browser-radio-window">
        </object>
    `;

    if ($("#browser-radio").data('loaded') === false) {
        $("#browser-radio").fadeIn(300).data('loaded', true).html(browserRadio)
    }
    else {
        $("#browser-radio").data('loaded', false);
        $("#browser-radio").fadeOut(300).empty();
    }
}

function setWeather(weather) {
    let weatherIcon = "fas fa-sun"
    switch (weather) {
        case "EXTRASUNNY":
        case "CLEAR":
            weatherIcon = "fas fa-sun"
            break;
        case "THUNDER":
            weatherIcon = "fas fa-poo-storm"
            break;
        case "CLEARING":
        case "OVERCAST":
            weatherIcon = "fas fa-cloud-sun-rain"
            break;
        case "CLOUD":
            weatherIcon = "fas fa-cloud"
            break;
        case "RAIN":
            weatherIcon = "fas fa-cloud-rain"
            break;
        case "SMOG":
        case "FOGGY":
            weatherIcon = "fas fa-smog"
            break;
    }
    $('.status-bar-weather').empty();
    $('.status-bar-weather').append(`<i class="${weatherIcon}"></i>`);
    
}
// <button class="waves-effect waves-light btn-small garage-spawn stocks-exchange" style="margin-top:4px" data-stock-id="${stockEntry.identifier}"> Transfer</button> 
// function addStocks(stocksData,SynditeAmount,TgbAmount,DvdAmount) {
//     for (let stock of Object.keys(stocksData)) {
//         let stockEntry = stocksData[stock];
//         if (stockEntry.identifier == "Syndite") {
//             let stockElement = `
//             <li>
//             <li style="background-color: #31455e;">
//             <div class="collapsible-header" style="background-color: #31455e; color: white">
//             <i class="fas fa-caret-square-up"></i> <h2 style="font-size:15px;margin-top:0px;margin-left:10px;">${stockEntry.identifier}</h2>
//                 </div>
//                 <div class="collapsible-body garage-body" style="height:269px; margin-top: 10px; font-size: 14px">
//                     <ul class="collection" style="background-color: #31455E;">
//                         <li class="collection-item"><i class="far fa-address-card"></i> ${stockEntry.name} (${SynditeAmount})</li>
//                             <li class="collection-item"><i class="fas fa-tag"></i> ${stockEntry.identifier} </li>
//                             <li class="collection-item"><i class="far fa-credit-card"></i> ${stockEntry.amountavailable}</li>
//                             <li class="collection-item"><i class="fas fa-chart-bar"></i> ${stockEntry.value}.00</li>
//                             <li class="center-align"> 
//                                 <button style="color:black;background-color: #8AE16E" class="waves-effect waves-light btn-small garage-spawn stocks-buy" data-stock-id="${stockEntry.identifier}"> PURCHASE</button> 
//                                 <button style="color:black;background-color: #DD945E" class="waves-effect waves-light btn-small garage-spawn stocks-exchange" data-stock-id="${stockEntry.identifier}"> Exchange</button> 
//                             </li>
//                         </ul>
//                     </div>
//                 </li>
//             `
//             $('.stocks-entries').append(stockElement);
//         } else if (stockEntry.identifier == "TGB Coin"){
//             let stockElement = `
//             <li>
//             <li style="background-color: #31455E;">
//             <div class="collapsible-header" style="background-color: #31455E; color: white">
//             <i class="fas fa-horse-head"></i> <h2 style="font-size:15px;margin-top:0px;margin-left:10px;">${stockEntry.identifier}</h2>
//             </div>
//                 <div class="collapsible-body garage-body" style="height:269px; margin-top: 10px; font-size: 14px">
//                     <ul class="collection" style="background-color: #31455E;">
//                         <li class="collection-item"><i class="far fa-address-card"></i> ${stockEntry.name} (${TgbAmount})</li>
//                             <li class="collection-item"><i class="fas fa-tag"></i> ${stockEntry.identifier} </li>
//                             <li class="collection-item"><i class="far fa-credit-card"></i> ${stockEntry.amountavailable}</li>
//                             <li class="collection-item"><i class="fas fa-chart-bar"></i> ${stockEntry.value}.00</li>
//                             <li class="center-align"> 
//                                 <button style="color:black;background-color: #8AE16E" class="waves-effect waves-light btn-small garage-spawn stocks-buy" data-stock-id="${stockEntry.identifier}"> PURCHASE</button> 
//                                 <button style="color:black;background-color: #DD945E" class="waves-effect waves-light btn-small garage-spawn stocks-exchange" data-stock-id="${stockEntry.identifier}"> Exchange</button> 
//                             </li>
//                         </ul>
//                     </div>
//                 </li>
//             `
//             $('.stocks-entries').append(stockElement);
//         } else if (stockEntry.identifier == "DVD Prime"){
//             let stockElement = `
//             <li>
//             <li style="background-color: #31455E;">
//             <div class="collapsible-header" style="background-color: #31455E; color: white">
//             <i class="fas fa-tag"></i> <h2 style="font-size:15px;margin-top:0px;margin-left:10px;">${stockEntry.identifier}</h2>
//             </div>
//                 <div class="collapsible-body garage-body" style="height:269px; margin-top: 10px; font-size: 14px">
//                     <ul class="collection" style="background-color: #31455E;">
//                         <li class="collection-item"><i class="far fa-address-card"></i> ${stockEntry.name} (${DvdAmount})</li>
//                             <li class="collection-item"><i class="fas fa-tag"></i> ${stockEntry.identifier} </li>
//                             <li class="collection-item"><i class="far fa-credit-card"></i> ${stockEntry.amountavailable}</li>
//                             <li class="collection-item"><i class="fas fa-chart-bar"></i> ${stockEntry.value}.00</li>
//                             <li class="center-align"> 
//                                 <button style="color:black;background-color: #8AE16E" class="waves-effect waves-light btn-small garage-spawn stocks-buy" data-stock-id="${stockEntry.identifier}"> PURCHASE</button> 
//                                 <button style="color:black;background-color: #DD945E" class="waves-effect waves-light btn-small garage-spawn stocks-exchange" data-stock-id="${stockEntry.identifier}"> Exchange</button> 
//                             </li>
//                         </ul>
//                     </div>
//                 </li>
//             `
//             $('.stocks-entries').append(stockElement);
//         }
//     }
// }

function addStocks(item,stocksData,SynditeAmount,TgbAmount,DvdAmount) {
    // console.log(JSON.stringify(item))
    for (let stock of Object.keys(stocksData)) {
        let stockEntry = stocksData[stock];
        let stockElement = ""
        // console.log("STOCK ID",stockEntry.name,SynditeAmount,stockEntry.identifier)
        stockElement += `<div class="cryptoPaper">
                               <div class="mainContainer crypt-container">`
        if (stockEntry.identifier == "Syndite") {
            stockElement += `<div class="image">
            <svg aria-hidden="true" focusable="false" data-prefix="fas"
               data-icon="caret-square-up" class="svg-inline--fa fa-caret-square-up fa-w-14 fa-fw fa-3x "
               role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
               <path fill="currentColor"
                  d="M0 432V80c0-26.51 21.49-48 48-48h352c26.51 0 48 21.49 48 48v352c0 26.51-21.49 48-48 48H48c-26.51 0-48-21.49-48-48zm355.515-140.485l-123.03-123.03c-4.686-4.686-12.284-4.686-16.971 0L92.485 291.515c-7.56 7.56-2.206 20.485 8.485 20.485h246.059c10.691 0 16.045-12.926 8.486-20.485z">
               </path>
            </svg>
         </div>`
        }else if (stockEntry.identifier == "TGB Coin"){
            stockElement += `<div class="image">
            <svg aria-hidden="true" focusable="false" data-prefix="fas"
                data-icon="horse-head" class="svg-inline--fa fa-horse-head fa-w-16 fa-fw fa-3x " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M509.8 332.5l-69.9-164.3c-14.9-41.2-50.4-71-93-79.2 18-10.6 46.3-35.9 34.2-82.3-1.3-5-7.1-7.9-12-6.1L166.9 76.3C35.9 123.4 0 238.9 0 398.8V480c0 17.7 14.3 32 32 32h236.2c23.8 0 39.3-25 28.6-46.3L256 384v-.7c-45.6-3.5-84.6-30.7-104.3-69.6-1.6-3.1-.9-6.9 1.6-9.3l12.1-12.1c3.9-3.9 10.6-2.7 12.9 2.4 14.8 33.7 48.2 57.4 87.4 57.4 17.2 0 33-5.1 46.8-13.2l46 63.9c6 8.4 15.7 13.3 26 13.3h50.3c8.5 0 16.6-3.4 22.6-9.4l45.3-39.8c8.9-9.1 11.7-22.6 7.1-34.4zM328 224c-13.3 0-24-10.7-24-24s10.7-24 24-24 24 10.7 24 24-10.7 24-24 24z">
                </path>
            </svg>
        </div>`
        }else if (stockEntry.identifier == "DVD Prime"){
            stockElement += `<div class="image">
                                <svg aria-hidden="true" focusable="false" data-prefix="fas"
                                    data-icon="fa-tag" class="svg-inline--fa fa-fa-tag fa-w-16 fa-fw fa-3x " role="img"
                                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path fill="currentColor"
                                        d="M48 32H197.5C214.5 32 230.7 38.74 242.7 50.75L418.7 226.7C443.7 251.7 443.7 292.3 418.7 317.3L285.3 450.7C260.3 475.7 219.7 475.7 194.7 450.7L18.75 274.7C6.743 262.7 0 246.5 0 229.5V80C0 53.49 21.49 32 48 32L48 32zM112 176C129.7 176 144 161.7 144 144C144 126.3 129.7 112 112 112C94.33 112 80 126.3 80 144C80 161.7 94.33 176 112 176z"">
                                    </path>
                                </svg>
                            </div>`
        }
                                  
        stockElement += `<div class="details ">
                                     <div class="title ">
                                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                           style="word-break: break-word;">${stockEntry.identifier}</p>
                                     </div>`
        if (stockEntry.identifier == "Syndite") {                       
                        stockElement +=`<div class="description ">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${SynditeAmount}</p>
                        </div>`
        }else if (stockEntry.identifier == "TGB Coin") {                       
            stockElement +=`<div class="description ">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${TgbAmount}</p>
            </div>`
        }else if (stockEntry.identifier == "DVD Prime") {                       
            stockElement +=`<div class="description ">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${DvdAmount}</p>
            </div>`
        }
        stockElement +=`</div>
                               </div>
                               <div class="cryptDrawer">
                                  <div class="cryptItem">
                                     <div class="icon">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="id-card"
                                           class="svg-inline--fa fa-id-card fa-w-18 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg"
                                           viewBox="0 0 576 512">
                                           <path fill="currentColor"
                                              d="M528 32H48C21.5 32 0 53.5 0 80v16h576V80c0-26.5-21.5-48-48-48zM0 432c0 26.5 21.5 48 48 48h480c26.5 0 48-21.5 48-48V128H0v304zm352-232c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16c0 4.4-3.6 8-8 8H360c-4.4 0-8-3.6-8-8v-16zm0 64c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16c0 4.4-3.6 8-8 8H360c-4.4 0-8-3.6-8-8v-16zm0 64c0-4.4 3.6-8 8-8h144c4.4 0 8 3.6 8 8v16c0 4.4-3.6 8-8 8H360c-4.4 0-8-3.6-8-8v-16zM176 192c35.3 0 64 28.7 64 64s-28.7 64-64 64-64-28.7-64-64 28.7-64 64-64zM67.1 396.2C75.5 370.5 99.6 352 128 352h8.2c12.3 5.1 25.7 8 39.8 8s27.6-2.9 39.8-8h8.2c28.4 0 52.5 18.5 60.9 44.2 3.2 9.9-5.2 19.8-15.6 19.8H82.7c-10.4 0-18.8-10-15.6-19.8z">
                                           </path>
                                        </svg>
                                     </div>
                                     <div class="text">`
                                     if (stockEntry.identifier == "Syndite") {                       
                                        stockElement +=` <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                            style="word-break: break-word;">${stockEntry.name} (${SynditeAmount})</p>`
                                    }else if (stockEntry.identifier == "TGB Coin") {                       
                                        stockElement +=`<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                            style="word-break: break-word;">${stockEntry.name} (${TgbAmount})</p>`
                                    }else if (stockEntry.identifier == "DVD Prime") {                       
                                        stockElement +=` <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                            style="word-break: break-word;">${stockEntry.name} (${DvdAmount})</p>`
                                    }
        stockElement +=`</div>
                                  </div>
                                  <div class="cryptItem">
                                     <div class="icon">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="tag"
                                           class="svg-inline--fa fa-tag fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg"
                                           viewBox="0 0 512 512">
                                           <path fill="currentColor"
                                              d="M0 252.118V48C0 21.49 21.49 0 48 0h204.118a48 48 0 0 1 33.941 14.059l211.882 211.882c18.745 18.745 18.745 49.137 0 67.882L293.823 497.941c-18.745 18.745-49.137 18.745-67.882 0L14.059 286.059A48 48 0 0 1 0 252.118zM112 64c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48z">
                                           </path>
                                        </svg>
                                     </div>
                                     <div class="text">
                                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                           style="">${stockEntry.identifier}</p>
                                     </div>
                                  </div>
                                  <div class="cryptItem">
                                     <div class="icon">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas"
                                           data-icon="money-check-alt" class="svg-inline--fa fa-money-check-alt fa-w-20 fa-fw "
                                           role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                           <path fill="currentColor"
                                              d="M608 32H32C14.33 32 0 46.33 0 64v384c0 17.67 14.33 32 32 32h576c17.67 0 32-14.33 32-32V64c0-17.67-14.33-32-32-32zM176 327.88V344c0 4.42-3.58 8-8 8h-16c-4.42 0-8-3.58-8-8v-16.29c-11.29-.58-22.27-4.52-31.37-11.35-3.9-2.93-4.1-8.77-.57-12.14l11.75-11.21c2.77-2.64 6.89-2.76 10.13-.73 3.87 2.42 8.26 3.72 12.82 3.72h28.11c6.5 0 11.8-5.92 11.8-13.19 0-5.95-3.61-11.19-8.77-12.73l-45-13.5c-18.59-5.58-31.58-23.42-31.58-43.39 0-24.52 19.05-44.44 42.67-45.07V152c0-4.42 3.58-8 8-8h16c4.42 0 8 3.58 8 8v16.29c11.29.58 22.27 4.51 31.37 11.35 3.9 2.93 4.1 8.77.57 12.14l-11.75 11.21c-2.77 2.64-6.89 2.76-10.13.73-3.87-2.43-8.26-3.72-12.82-3.72h-28.11c-6.5 0-11.8 5.92-11.8 13.19 0 5.95 3.61 11.19 8.77 12.73l45 13.5c18.59 5.58 31.58 23.42 31.58 43.39 0 24.53-19.05 44.44-42.67 45.07zM416 312c0 4.42-3.58 8-8 8H296c-4.42 0-8-3.58-8-8v-16c0-4.42 3.58-8 8-8h112c4.42 0 8 3.58 8 8v16zm160 0c0 4.42-3.58 8-8 8h-80c-4.42 0-8-3.58-8-8v-16c0-4.42 3.58-8 8-8h80c4.42 0 8 3.58 8 8v16zm0-96c0 4.42-3.58 8-8 8H296c-4.42 0-8-3.58-8-8v-16c0-4.42 3.58-8 8-8h272c4.42 0 8 3.58 8 8v16z">
                                           </path>
                                        </svg>
                                     </div>
                                     <div class="text">
                                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                           style="word-break: break-word;">${stockEntry.amountavailable}</p>
                                     </div>
                                  </div>
                                  <div class="cryptItem">
                                     <div class="icon">
                                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="poll"
                                           class="svg-inline--fa fa-poll fa-w-14 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg"
                                           viewBox="0 0 448 512">
                                           <path fill="currentColor"
                                              d="M400 32H48C21.5 32 0 53.5 0 80v352c0 26.5 21.5 48 48 48h352c26.5 0 48-21.5 48-48V80c0-26.5-21.5-48-48-48zM160 368c0 8.84-7.16 16-16 16h-32c-8.84 0-16-7.16-16-16V240c0-8.84 7.16-16 16-16h32c8.84 0 16 7.16 16 16v128zm96 0c0 8.84-7.16 16-16 16h-32c-8.84 0-16-7.16-16-16V144c0-8.84 7.16-16 16-16h32c8.84 0 16 7.16 16 16v224zm96 0c0 8.84-7.16 16-16 16h-32c-8.84 0-16-7.16-16-16v-64c0-8.84 7.16-16 16-16h32c8.84 0 16 7.16 16 16v64z">
                                           </path>
                                        </svg>
                                     </div>
                                     <div class="text">
                                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                                           style="word-break: break-word;">${stockEntry.value}.00</p>
                                     </div>
                                  </div>
                                  <div class="flexCentered flexSpaceBetween">
                                    <button
                                        class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall stocks-buy"
                                        tabindex="0" type="button" data-stock-id="${stockEntry.identifier}"><span class="MuiButton-label">Purchase</span><span
                                        class="MuiTouchRipple-root"></span></button>
                                    <button
                                        class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedSecondary MuiButton-containedSizeSmall MuiButton-sizeSmall stocks-exchange"
                                        tabindex="0" type="button" data-stock-id="${stockEntry.identifier}"><span class="MuiButton-label">Exchange</span><span
                                        class="MuiTouchRipple-root"></span></button>
                                  </div>
                               </div>
                            </div>`
        $('.jss2770').append(stockElement);
    }
    $(document).ready(function () {
		// $(".crypt-container .jss2770").click(function () {
        // $('.jss2770').on('click', '.cryptoPaper', function () {
        $(".cryptoPaper").click(function () {
            // console.log("CLICK DRAWER")
			var check = $('.cryptDrawer').css('display')
			if (drawer) {
                // console.log("FLEX 0",check,this)
				$(this).children(".cryptDrawer").css("display", "none");
				drawer = 0
			} else {
                // console.log("NON FLEX 1",check,this)
				$(this).children(".cryptDrawer").css("display", "block");
				drawer = 1
			}
		});
	});
}

// var drawer = false
	// $(document).ready(function () {
	// 	$(".crypto-container").click(function () {
	// 		if (drawer) {
    //             console.log("DRAWER 0",this)
	// 			$(this).parent('.cryptoPaper').children(".drawer").css("display", "flex");
	// 			drawer = 0
	// 		} else {
    //             console.log("DRAWER 1",this)
	// 			$(this).parent('.cryptoPaper').children(".drawer").css("display", "flex");
	// 			drawer = 1
	// 		}
	// 	});
	// })

    //Global Hide
function globalyhide(){
    $(document).ready(function () {
        // console.log("HIDE ALL")
        $(".garages").hide();
        // $('#addContactHere').css("display" , "none");
        $(".send-twat-form").hide();
        $('.yellow-pages-iconmove').css('display', 'none')
        $("#messages-second-container").hide();
        // $("#contacts-container").hide();
        
        $('.jss1153').css('display',"none")
        $(".jss1153").hide();
        $("#add-contact").hide();
        // $('#addContactHere').css("display" , "none");
        // $('#btn-2-house').hide();
        $('.h-current').hide();
        $('.phone-acces-house').hide();
        $('.groupsContainer-m').css("display" , "none");
        $('.gm2-save3').css("display" , "none");
        $('.gm2-search').css('display', 'none');
        $('.asset-fee').css('display', 'none');
        $('.h-loan').css('display', 'none');
        $('.debt-container').css('display', 'none');
    });
}
    $(document).ready(function () {
        // console.log("HIDE ALL")
        $(".garages").hide();
        // $('#addContactHere').css("display" , "none");
        $(".send-twat-form").hide();
        $("#messages-second-container").hide();
        // $("#contacts-container").hide();
        
        $('.jss1153').css('display',"none")
        $(".jss1153").hide();
        $("#add-contact").hide();
        // $('#addContactHere').css("display" , "none");
        // $('#btn-2-house').hide();
        $('.h-current').hide();
        $('.phone-acces-house').hide();
        $('.groupsContainer-m').css("display" , "none");
        $('.gm2-save3').css("display" , "none");
        $('.gm2-search').css('display', 'none');
    });

function joblist() {
    $('.jobcenter-container').empty();
    $('.garage-entries').empty();
    var JCsanitation = `
        <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('sanitation')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-trash-alt" style="font-size: 50px; color:white;margin-left: 10px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 20px;margin-top:-5px">Sanitation Worker</i>
                <span class="new-badge">
                    <i class="" style="font-size: 13px;margin-left: 0px">Clean the streets!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JCfishing = `
        <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('fishing')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-fish" style="font-size: 50px; color:white;margin-left: 6px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 26px;">Fishing</i>
                <span class="new-badge">
                    <i class="" style="font-size: 13px;margin-left: -1px">Rolling in the deep!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JCpoultry = `
        <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('poultry')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-drumstick" style="font-size: 50px; color:white;margin-left: 6px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 25px;">Poultry</i>
                <span class="new-badge">
                <i class="" style="font-size: 13px;margin-left: -1px">Bok Bok Beach!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JChunting = `
    <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('hunting')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-bullseye-arrow" style="font-size: 50px; color:white;margin-left: 6px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 25px;">Hunting</i>
                <span class="new-badge">
                <i class="" style="font-size: 13px;margin-left: -1px">Boom! Headshot!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JCmining = `
    <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('mining')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-hard-hat" style="font-size: 50px; color:white;margin-left: 6px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 25px;">Mining</i>
                <span class="new-badge">
                <i class="" style="font-size: 13px;margin-left: -1px">I like to dig dig dig!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JCoxy = `
    <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('oxy')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-clipboard-list" style="font-size: 50px; color:white;margin-left: 13px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 18px;">Oxy Run</i>
                <span class="new-badge">
                <i class="" style="font-size: 13px;margin-left: -1px">Off to the streets!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    var JCchopshop = `
    <li>
        <div class="hovereffect"> 
    <h3>
    <button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    <button style="margin-left: 70px" id="hovercorridas" class="" aria-label="Set GPS Location" data-balloon-pos="up"><i class="fas fa-map-marked-alt" onclick="gpsJobCenter('chopshop')"></i> </button>
    </h3>
        <div class="collapsible-header">
            <i class="fas fa-clipboard-list" style="font-size: 50px; color:white;margin-left: 13px;"> </i>
            <i class="name-car" style="font-size: 18px;margin-left: 18px;">Chop Shop</i>
                <span class="new-badge">
                <i class="" style="font-size: 13px;margin-left: -1px">Evaaaaaaaa!</i>
                </span>
                    <div class="collapsible-body garage-body">
                    <div class="collapsible-body garage-body">
                    <div class="row">
                </div>
            </div>
        </li>
    `
    $('.garage-entries').append(JCsanitation);
    $('.garage-entries').append(JCfishing);
    $('.garage-entries').append(JCpoultry);
    $('.garage-entries').append(JChunting);
    $('.garage-entries').append(JCmining);
    
    if (hasVPN){
        $('.garage-entries').append(JCoxy);
        $('.garage-entries').append(JCchopshop);
    }
}

function addBuying(materials,blueprintid) {

    $('.buydarkMarket-container').empty();
    var DMVpn = `
        <li>
        <div class="hovereffect"> 
    <h3>
    `
    if (materials == "wifi1" || materials == "wifi2"){
        DMVpn += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
    
    <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('vpn')"></i> </button>

    </h3>
            <div class="collapsible-header">
                <i class="fas fa-user-secret" style="font-size: 60px; color:white;margin-left: 6px;"> </i>
                <i class="name-car" style="font-size: 18px;margin-left: 35px;">VPN</i>
                <span  class="new-badge">20 Syndite</span>
            </div>
            <div class="collapsible-body garage-body">
            <div class="collapsible-body garage-body">
            <div class="row">
            </div>
        </div>
    </li>
    `
    $('.buydarkMarket-container').append(DMVpn);

    }   

        var DMDeliveryList = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi1" || materials == "wifi3" || materials == "wifi4"){
            DMDeliveryList += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
        
        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('deliverylist')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-clipboard-list" style="font-size: 60px; color:white;margin-left: 8px; "> </i>
                    <i class="name-car" style="font-size: 18px;margin-left=0">Delivery List</i>
                    <span  class="new-badge">20 Syndite</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMDeliveryList);
    } 
        
            var DMDongleG = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi1" && hasVPN){
            DMDongleG += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('gdongle')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-mask" style="font-size: 50px; color:white"> </i>
                    <i style="margin-left:40px;font-size: 15px" class="name-car"> Phone Dongle (G)</i>
                    <span class="new-badge"> 100 TGB</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMDongleG);
    }  

    var DMChopList = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi2" || materials == "wifi3" || materials == "wifi4"){
            DMChopList += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('choplist')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-clipboard-list" style="font-size: 60px; color:white;margin-left: 8px; "> </i>
                    <i class="name-car" style="font-size: 18px;margin-left=0">Chop List</i>
                    <span class="new-badge"> 20 TGB</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMChopList);
    }

    var DMLaptopG = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi2" && hasVPN){
            DMLaptopG += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('laptopgreen')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-laptop" style="font-size: 50px; color:white"> </i>
                    <i style="margin-left:40px;font-size: 15px" class="name-car"> Laptop (G)</i>
                    <span class="new-badge"> 50 Syndite</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMLaptopG);
    }

    var DMLaptopB = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi3" && hasVPN){
            DMLaptopB += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('laptopblue')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-laptop" style="font-size: 50px; color:white"> </i>
                    <i style="margin-left:40px;font-size: 15px" class="name-car"> Laptop (B)</i>
                    <span class="new-badge"> 65 Syndite</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMLaptopB);
    }

    var DMLaptopR = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi5" && hasVPN){
            DMLaptopR += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('laptopred')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-laptop" style="font-size: 50px; color:white"> </i>
                    <i style="margin-left:40px;font-size: 15px" class="name-car"> Laptop (R)</i>
                    <span class="new-badge"> 65 Syndite</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMLaptopR);
    }

    var DMThermite = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi4" && hasVPN){
            DMThermite += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('thermite')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-burn" style="margin-left:10px; font-size: 55px; color:white"> </i>
                    <i style="margin-left:30px;font-size: 15px" class="name-car"> Thermite</i>
                    <span class="new-badge"> 100 TGB</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMThermite);
    }

    var DMBoostLaptop = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if (materials == "wifi5" && hasVPN){
            DMBoostLaptop += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('boostlaptop')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-laptop" style="font-size: 50px; color:white"> </i>
                    <i style="margin-left:40px;font-size: 15px" class="name-car"> RP Laptop</i>
                    <span class="new-badge"> 100 Syndite</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMBoostLaptop);
    }

    itemamount = 0

    if (blueprintid == 1){
        itemid = 'Skorpion';
        itemamount = 5;
    } if (blueprintid == 2){
        itemid = 'Uzi';
        itemamount = 5;
    } if (blueprintid == 3){
        itemid = 'Mac-10';
        itemamount = 5;
    } if (blueprintid == 4){
        itemid = 'FN FNX-45';
        itemamount = 5;
    } if (blueprintid == 5){
        itemid = 'Glock 18C';
        itemamount = 5;
    } if (blueprintid == 6){
        itemid = 'Desert Eagle';
        itemamount = 5;
    }

    var DMBlueprint = `
            <li>
            <div class="hovereffect"> 
        <h3>
        `
        if ((materials == "wifi6" || materials == "wifi7") && hasVPN){
            DMBlueprint += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>

        <button style="margin-left: 67px" id="hovercorridas" class="" aria-label="Purchase" data-balloon-pos="up"><i class="fas fa-hand-holding-usd" onclick="purchaseDarkMarket('${itemid}')"></i> </button>

        </h3>
                <div class="collapsible-header">
                    <i class="fas fa-map" style="font-size: 60px; color:white;margin-left: 3px;"> </i>
                    <i class="name-car" style="font-size: 18px;margin-left: 35px;">Blueprint</i>
                    <span class="new-badge"> ${itemamount} Davadam</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                </div>
            </div>
        </li>
        `
        $('.buydarkMarket-container').append(DMBlueprint);
    }
}

function purchaseDarkMarket(data) {
    $.post("https://varial-newphone/purchase-darkMarket", JSON.stringify({item:data,itemamount}))
}

function trackvehicle(vehplate) {
    // console.log("VEH PLATE",vehplate)
    $.post("https://varial-newphone/vehtrack", JSON.stringify({vehplate}))
}

function spawnVehicle(vehplate) {
    // console.log("VEH PLATE",vehplate)
    $.post("https://varial-newphone/vehspawn", JSON.stringify({vehplate}))
}

function sellVehicle(vehplate) {
    $.post("https://varial-newphone/sellVeh", JSON.stringify({vehplate}))
}

function gpsJobCenter(data) {    
    $.post("https://varial-newphone/jobcenter-setgps", JSON.stringify({item:data}))
}

function addNewVehicles(vehicleData, showCarPayments){
    // console.log(JSON.stringify(vehicleData))
   
    for (let vehicle of Object.keys(vehicleData)) {
        var element =` <div class="componentGarage car-count">
                    <div class="main-container clicked-function-container">
                    <div class="image">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="car"
                        class="svg-inline--fa fa-car fa-w-16 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg"
                        viewBox="0 0 512 512">
                        <path fill="currentColor"
                            d="M499.99 176h-59.87l-16.64-41.6C406.38 91.63 365.57 64 319.5 64h-127c-46.06 0-86.88 27.63-103.99 70.4L71.87 176H12.01C4.2 176-1.53 183.34.37 190.91l6 24C7.7 220.25 12.5 224 18.01 224h20.07C24.65 235.73 16 252.78 16 272v48c0 16.12 6.16 30.67 16 41.93V416c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32v-32h256v32c0 17.67 14.33 32 32 32h32c17.67 0 32-14.33 32-32v-54.07c9.84-11.25 16-25.8 16-41.93v-48c0-19.22-8.65-36.27-22.07-48H494c5.51 0 10.31-3.75 11.64-9.09l6-24c1.89-7.57-3.84-14.91-11.65-14.91zm-352.06-17.83c7.29-18.22 24.94-30.17 44.57-30.17h127c19.63 0 37.28 11.95 44.57 30.17L384 208H128l19.93-49.83zM96 319.8c-19.2 0-32-12.76-32-31.9S76.8 256 96 256s48 28.71 48 47.85-28.8 15.95-48 15.95zm320 0c-19.2 0-48 3.19-48-15.95S396.8 256 416 256s32 12.76 32 31.9-12.8 31.9-32 31.9z">
                        </path>
                        </svg>
                    </div>
                    <div class="details ">
                        <div class="title ">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].plate}</p>
                        </div>
                        <div class="description ">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].name}</p>
                        </div>
                    </div>
                    <div class="details-aux ">
                        <div class="text">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].state}</p>
                        </div>
                    </div>
                    </div>
                    <div class="drawerG">
                    <div class="itemG">
                        <div class="icon">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt"
                            class="svg-inline--fa fa-map-marker-alt fa-w-12 fa-fw " role="img"
                            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                            <path fill="currentColor"
                                d="M172.268 501.67C26.97 291.031 0 269.413 0 192 0 85.961 85.961 0 192 0s192 85.961 192 192c0 77.413-26.97 99.031-172.268 309.67-9.535 13.774-29.93 13.773-39.464 0zM192 272c44.183 0 80-35.817 80-80s-35.817-80-80-80-80 35.817-80 80 35.817 80 80 80z">
                            </path>
                        </svg>
                        </div>
                        <div class="text" style="padding-left: 10px">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].garage}</p>
                        </div>
                    </div>
                    <div class="itemG">
                        <div class="iconG">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="closed-captioning"
                            class="svg-inline--fa fa-closed-captioning fa-w-16 fa-fw " role="img"
                            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path fill="currentColor"
                                d="M464 64H48C21.5 64 0 85.5 0 112v288c0 26.5 21.5 48 48 48h416c26.5 0 48-21.5 48-48V112c0-26.5-21.5-48-48-48zM218.1 287.7c2.8-2.5 7.1-2.1 9.2.9l19.5 27.7c1.7 2.4 1.5 5.6-.5 7.7-53.6 56.8-172.8 32.1-172.8-67.9 0-97.3 121.7-119.5 172.5-70.1 2.1 2 2.5 3.2 1 5.7l-17.5 30.5c-1.9 3.1-6.2 4-9.1 1.7-40.8-32-94.6-14.9-94.6 31.2.1 48 51.1 70.5 92.3 32.6zm190.4 0c2.8-2.5 7.1-2.1 9.2.9l19.5 27.7c1.7 2.4 1.5 5.6-.5 7.7-53.5 56.9-172.7 32.1-172.7-67.9 0-97.3 121.7-119.5 172.5-70.1 2.1 2 2.5 3.2 1 5.7L420 222.2c-1.9 3.1-6.2 4-9.1 1.7-40.8-32-94.6-14.9-94.6 31.2 0 48 51 70.5 92.2 32.6z">
                            </path>
                        </svg>
                        </div>
                        <div class="text">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].plate}</p>
                        </div>
                    </div>
                    <div class="itemG" title="Engine">
                        <div class="iconG">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="oil-can"
                            class="svg-inline--fa fa-oil-can fa-w-20 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 640 512">
                            <path fill="currentColor"
                                d="M629.8 160.31L416 224l-50.49-25.24a64.07 64.07 0 0 0-28.62-6.76H280v-48h56c8.84 0 16-7.16 16-16v-16c0-8.84-7.16-16-16-16H176c-8.84 0-16 7.16-16 16v16c0 8.84 7.16 16 16 16h56v48h-56L37.72 166.86a31.9 31.9 0 0 0-5.79-.53C14.67 166.33 0 180.36 0 198.34v94.95c0 15.46 11.06 28.72 26.28 31.48L96 337.46V384c0 17.67 14.33 32 32 32h274.63c8.55 0 16.75-3.42 22.76-9.51l212.26-214.75c1.5-1.5 2.34-3.54 2.34-5.66V168c.01-5.31-5.08-9.15-10.19-7.69zM96 288.67l-48-8.73v-62.43l48 8.73v62.43zm453.33 84.66c0 23.56 19.1 42.67 42.67 42.67s42.67-19.1 42.67-42.67S592 288 592 288s-42.67 61.77-42.67 85.33z">
                            </path>
                        </svg>
                        </div>
                        <div class="text">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].fuel}%</p>
                        </div>
                    </div>
                    <div class="itemG" title="Body">
                        <div class="iconG">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="car-crash"
                            class="svg-inline--fa fa-car-crash fa-w-20 fa-fw " role="img"
                            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                            <path fill="currentColor"
                                d="M143.25 220.81l-12.42 46.37c-3.01 11.25-3.63 22.89-2.41 34.39l-35.2 28.98c-6.57 5.41-16.31-.43-14.62-8.77l15.44-76.68c1.06-5.26-2.66-10.28-8-10.79l-77.86-7.55c-8.47-.82-11.23-11.83-4.14-16.54l65.15-43.3c4.46-2.97 5.38-9.15 1.98-13.29L21.46 93.22c-5.41-6.57.43-16.3 8.78-14.62l76.68 15.44c5.26 1.06 10.28-2.66 10.8-8l7.55-77.86c.82-8.48 11.83-11.23 16.55-4.14l43.3 65.14c2.97 4.46 9.15 5.38 13.29 1.98l60.4-49.71c6.57-5.41 16.3.43 14.62 8.77L262.1 86.38c-2.71 3.05-5.43 6.09-7.91 9.4l-32.15 42.97-10.71 14.32c-32.73 8.76-59.18 34.53-68.08 67.74zm494.57 132.51l-12.42 46.36c-3.13 11.68-9.38 21.61-17.55 29.36a66.876 66.876 0 0 1-8.76 7l-13.99 52.23c-1.14 4.27-3.1 8.1-5.65 11.38-7.67 9.84-20.74 14.68-33.54 11.25L515 502.62c-17.07-4.57-27.2-22.12-22.63-39.19l8.28-30.91-247.28-66.26-8.28 30.91c-4.57 17.07-22.12 27.2-39.19 22.63l-30.91-8.28c-12.8-3.43-21.7-14.16-23.42-26.51-.57-4.12-.35-8.42.79-12.68l13.99-52.23a66.62 66.62 0 0 1-4.09-10.45c-3.2-10.79-3.65-22.52-.52-34.2l12.42-46.37c5.31-19.8 19.36-34.83 36.89-42.21a64.336 64.336 0 0 1 18.49-4.72l18.13-24.23 32.15-42.97c3.45-4.61 7.19-8.9 11.2-12.84 8-7.89 17.03-14.44 26.74-19.51 4.86-2.54 9.89-4.71 15.05-6.49 10.33-3.58 21.19-5.63 32.24-6.04 11.05-.41 22.31.82 33.43 3.8l122.68 32.87c11.12 2.98 21.48 7.54 30.85 13.43a111.11 111.11 0 0 1 34.69 34.5c8.82 13.88 14.64 29.84 16.68 46.99l6.36 53.29 3.59 30.05a64.49 64.49 0 0 1 22.74 29.93c4.39 11.88 5.29 25.19 1.75 38.39zM255.58 234.34c-18.55-4.97-34.21 4.04-39.17 22.53-4.96 18.49 4.11 34.12 22.65 39.09 18.55 4.97 45.54 15.51 50.49-2.98 4.96-18.49-15.43-53.67-33.97-58.64zm290.61 28.17l-6.36-53.29c-.58-4.87-1.89-9.53-3.82-13.86-5.8-12.99-17.2-23.01-31.42-26.82l-122.68-32.87a48.008 48.008 0 0 0-50.86 17.61l-32.15 42.97 172 46.08 75.29 20.18zm18.49 54.65c-18.55-4.97-53.8 15.31-58.75 33.79-4.95 18.49 23.69 22.86 42.24 27.83 18.55 4.97 34.21-4.04 39.17-22.53 4.95-18.48-4.11-34.12-22.66-39.09z">
                            </path>
                        </svg>
                        </div>
                        <div class="text">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                            style="word-break: break-word;">${vehicleData[vehicle].enginePercent}%</p>
                        </div>
                    </div>
                    <div class="flex-centered flex-space-around">
                        <div>`
                        if (vehicleData[vehicle].canSpawn){
                            element +=`
                            <button
                                    class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall spawn-button"
                                    tabindex="0" style="background-color: white;" type="button" data-plate="${vehicleData[vehicle].plate}" data-model="${vehicleData[vehicle].model}" onclick="spawnVehicle('${vehicleData[vehicle].plate}')">
                            <span class="MuiButton-label">Spawn</span>
                            <span class="MuiTouchRipple-root"></span>
                            </button>`
                        }
                element +=`
                        <button
                                class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall track-button"
                                tabindex="0" type="button" data-plate="${vehicleData[vehicle].plate}" data-model="${vehicleData[vehicle].model}" onclick="trackvehicle('${vehicleData[vehicle].plate}')">
                        <span class="MuiButton-label">Track</span>
                        <span class="MuiTouchRipple-root"></span>
                        </button>  <button
                                class="MuiButtonBase-root MuiButton-root MuiButton-contained MuiButton-containedPrimary MuiButton-containedSizeSmall MuiButton-sizeSmall track-button"
                                tabindex="0" type="button" style="background-color: #eb9626;" data-plate="${vehicleData[vehicle].plate}" data-model="${vehicleData[vehicle].model}" onclick="sellVehicle('${vehicleData[vehicle].plate}')">
                        <span class="MuiButton-label">Sell</span>
                        <span class="MuiTouchRipple-root"></span>
                        </button>`
            
                        element +=`
                        </div>
                    </div>
                    </div>
                    </div>
                `
        $('.jss2717').append(element);
        $('.main-container').parent('.componentGarage').children(".drawerG").css("display", "none");
        $(".clicked-function-container").click(function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            // console.log("CHEKER",JSON.stringify($(this)))
            var check = $(this).parent('.componentGarage').children(".drawerG").css('display')
            
            if (check == "flex") {
                $(this).parent('.componentGarage').children(".drawerG").css("display", "none");
                // drawer = 0
            } else {
                $(this).parent('.componentGarage').children(".drawerG").css("display", "flex");
                // drawer = 1
            }
        });
    }
}

function addVehicles(vehicleData, showCarPayments) {
    if (showCarPayments)
        $('.btn-car-payments').css("visibility", "visible").hide().fadeIn(150);
    for (let vehicle of Object.keys(vehicleData)) {
        let carIconColor = "green";
        if (vehicleData[vehicle].amountDue > 0)
            carIconColor = "#cc5353";
        else if (vehicleData[vehicle].amountDue == 0 && vehicleData[vehicle].payments > 0)
            carIconColor = "orange";
        else
            carIconColor = "white";
        var vehicleElement = `
            <li>
            <div class="hovereffect">
    
       
    <h3>
    `
        if (vehicleData[vehicle].canSpawn)
            // vehicleElement += `<button id="hovercorridas" class=" garage-spawn" aria-label="Spawn" data-plate="${vehicleData[vehicle].plate}"><i class="fas fa-magic"></i> </button> `
            vehicleElement += `<button id="hovercorridas" class="" aria-label=""><i class=""></i> </button>
        
        <button style="margin-left: 15px" id="hovercorridas" class="" aria-label="Garage - ${vehicleData[vehicle].garage}" data-balloon-pos="up"><i  class="fas fa-oil-can"></i> </button>
        <button id="hovercorridas" class="" aria-label=" Car Plate - ${vehicleData[vehicle].plate}" data-balloon-pos="up"><i  class="fas fa-closed-captioning"></i> </button>
        <button id="hovercorridas" class="" aria-label="Engine Health - ${vehicleData[vehicle].enginePercent}" data-balloon-pos="up"><i  class="fas fa-oil-can"></i> </button>
        <button id="hovercorridas" class="" aria-label="Body Health - ${vehicleData[vehicle].bodyPercent}" data-balloon-pos="up"><i  class="fas fa-car-crash"></i> </button>
        <button id="hovercorridas" class="" aria-label="Track - ${vehicleData[vehicle].plate}" data-balloon-pos="up"><i  class="fas fa-map-marker-alt" onclick="trackvehicle('${vehicleData[vehicle].plate}')"></i> </button>

    </h3>
                <div class="collapsible-header">
                    <i class="fas fa-car " style="font-size: 60px; color:${carIconColor}"> </i>
                    <i class="name-car" style="font-size: 18px;">${vehicleData[vehicle].name}</i>
                    <span  class="new-badge">(${vehicleData[vehicle].state}) ${vehicleData[vehicle].garage}</span>
                </div>
                <div class="collapsible-body garage-body">
                <div class="collapsible-body garage-body">
                <div class="row">
                    <div class="col s12"> 
                        <ul class="collection">
                            <li class="collection-item"><i class="fas fa-map-marker-alt"></i>  ${vehicleData[vehicle].garage}</li>
                            <li class="collection-item"><i class="fas fa-closed-captioning"></i> ${vehicleData[vehicle].plate}</li>
                            <li class="collection-item"><i class="fas fa-oil-can"></i> ${vehicleData[vehicle].enginePercent}% Engine</li>
                            <li class="collection-item"><i class="fas fa-car-crash"></i> ${vehicleData[vehicle].bodyPercent}% Body</li>
                            <li class="collection-item"><i class="fas fa-hourglass-half"></i> ${vehicleData[vehicle].payments == 0 ? 'No remaining payments.' : Math.ceil(parseFloat(vehicleData[vehicle].lastPayment)) + ' days until payment is due.'}</li>
                            `
                        if (vehicleData[vehicle].payments != 0) {
                            vehicleElement += `
                            <li class="collection-item"><i class="fas fa-credit-card"></i> ${vehicleData[vehicle].payments} payments left.</li>
                            <li class="collection-item"><i class="fas fa-dollar-sign"></i> <span class="car-payment-due">${Math.ceil(parseFloat(vehicleData[vehicle].amountDue /12))}</span> amount due.</li>
                            `
                            }
                            vehicleElement += `
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col s12 center-align">`
                    if (vehicleData[vehicle].canSpawn)
                        vehicleElement += `<button class="waves-effect waves-light btn-small garage-spawn" data-plate="${vehicleData[vehicle].plate}"><i class="fas fa-magic"></i> Spawn</button> `

                    if (vehicleData[vehicle].payments > 0 && vehicleData[vehicle].amountDue > 0)
                        vehicleElement += `<button class="waves-effect waves-light btn-small red garage-pay" data-plate="${vehicleData[vehicle].plate}"><i class="fas fa-hand-holding-usd"></i> Pay</button> `

                        vehicleElement += `<button class="waves-effect waves-light btn-small garage-track" data-plate="${vehicleData[vehicle].plate}"><i class="fas fa-map-marker-alt"></i> Track</button>
                    </div>
                </div>
            </div>
        </li>
    `
    $('.garage-entries').append(vehicleElement);
}
}

function addImportados(vehicleData, showCarPayments) {
    
        var ImportadosElement = `
            <li>
                <div class="collapsible-header">
                    <i class="fas fa-car " style="font-size: 60px"> </i>
                    <i class="name-car" style="font-size: 18px;"></i>
                    <span  class="new-badge">(</span>
                </div>
                <div class="collapsible-body importados-body">
                <i class="fas fa-map-marker-alt fa-2x btn-contacts-send-message"  aria-label="" style="margin-top: 20px;margin-left: 47px;"></i>
                <i class="fas fa-closed-captioning fa-2x btn-contacts-send-message"  aria-label=""style="margin-left: 10px;"></i>
                <i class="fas fa-oil-can fa-2x btn-contacts-send-message"  aria-label="% Engine"style="margin-left: 10px;"></i>
                <i class="fas fa-car-crash fa-2x btn-contacts-send-message"  aria-label="% Body"style="margin-left: 10px;"></i>
                

             
            </div>
        </li>`;
    
        $('.importados-entries').append(ImportadosElement);
    }



function addGPSLocations(locations) {
    let unorderedAdressess = []
    for (let location of Object.keys(locations)) {
        let houseType = parseInt(locations[location].houseType);
        let houseInfo = locations[location].info;
        if (houseInfo !== undefined) {
            for (let i = 0; i < houseInfo.length; i++) {

                const houseMapping = {
                    1: { type: 'House', icon: 'fas fa-home' },
                    2: { type: 'Mansion', icon: 'fas fa-hotel' },
                    3: { type: 'Rented', icon: 'fas fa-key' },
                    69: { type: 'Misc', icon: 'fas fa-info' }
                }
                let address = escapeHtml(houseType == 3 ? houseInfo[i].name : houseInfo[i].info)
                unorderedAdressess.push({
                    address: address.trimStart(),
                    houseId: i + 1,
                    houseIcon: houseMapping[houseType].icon,
                    houseType: houseMapping[houseType].type,
                    houseTypeId: houseType
                })
            }
        }
    }
    unorderedAdressess.sort((a, b) => a.address.localeCompare(b.address))
    for (let j = 0; j < unorderedAdressess.length; j++) {
        let htmlData = `<li class="collection-item" data-house-type="${unorderedAdressess[j].houseType}">
                            <div>
                                <span aria-label="${unorderedAdressess[j].houseType}" data-balloon-pos="right"><i class="${unorderedAdressess[j].houseIcon}"></i></span> ${unorderedAdressess[j].address}
                                <span class="secondary-content gps-location-click" data-house-type=${unorderedAdressess[j].houseTypeId} data-house-id="${unorderedAdressess[j].houseId}"><i class="fas fa-map-marker-alt"></i></span>
                            </div>
                        </li>`
        $('.gps-entries').append(htmlData);
    }
}

function addAccountInformation(accountInfo) {
    if (accountInfo) {
        
        var Banco = accountInfo.bank.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
        var Carteira = accountInfo.cash.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
        var Paycheck = accountInfo.paycheck.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
/*         var Chips = accountInfo.chips.toLocaleString('en-US', { style: 'currency', currency: 'USD' }); */
        var number = accountInfo.myNumber.toString();
        var phoneNumber =  '(' + number.slice(0, 3) + ') ' + number.slice(3, 6) + '-' + number.slice(6, 10);
        
/*         $('.account-information-chips').text(Chips); */
        $('.account-information-paycheck').text(Paycheck);
        $('.account-information-cid').text((accountInfo.cid ? accountInfo.cid : 0));
        $('.account-information-cash ').text(Carteira);
        $('.account-information-bank').text(Banco);
        $('.account-phone-number').text(phoneNumber);
        
        licenses = accountInfo.licenses

        let licenseTable =
        `<table class="responsive-table license-table" >
        <thead>
            <tr>
            
                <th><span aria-label="Your Licenses" data-balloon-pos="up-left" style="margin-left: 90px;font-size: 1rem;font-family: &quot;Roboto&quot;, &quot;Helvetica&quot;, &quot;Arial&quot;, sans-serif;font-weight: 500;line-height: 1.5;letter-spacing: 0.00938em;">Licenses<div class=""></div></span></th>
                
            </tr>
        </thead>
    <tbody>
            `
        for (const key of Object(licenses)) {
            var string = `${key["type"]}`
            string = string.charAt(0).toUpperCase() + string.slice(1)
            licenseTable += `<tr>
                                <td>${string}</td>
                                <td><i class="${key["status"] == 1 ? "fas fa-check-circle licensesucess" : "fas fa-times-circle licenseerror"}"></i></td>
                            </tr>`
        }
        licenseTable +=
            `
            </tbody>
        </table>
        `
        $('.account-information-licenses').html(licenseTable);
        if (accountInfo.pagerStatus)
            $('.account-information-toggle-pager').removeClass('red-text').addClass('green-text')
        else
        $('.account-information-primary-job').text(accountInfo.job ? accountInfo.job : "Desempregado.");
        $('.account-information-secondary-job').text(accountInfo.secondaryJob ? accountInfo.secondaryJob : "No secondary job.");
    }
}

function addTweets(tweets, myHandle) {
    $(".twatter-handle").empty();
    $(".twatter-handle").append(myHandle);
    $(".twatter-entries").empty();
  
    if (tweets && Object.keys(tweets).length > 0) {
        for (let message of tweets) {
            var date = (tweets.time === undefined ? Date.now() : tweets.time);
    // if (tweets && Object.keys(tweets).length > 0) {
        
    //     for (let message of tweets) {

            if (message && message.handle && message.message) {

                // console.log(message.message,JSON.stringify(message))
                setTimeout(() => {
                var twat = message.message;
                var photoOf = message.attachment;
                var imageCheck;
                var number;
                var hide;

                if (photoOf == '') {
                    imageCheck = 'none'
                    number = 0;
                    hide = '';
                } else {
                    imageCheck = 'flex';
                    number = 1;
                    hide = 'Hide (click image to copy URL)';
                }
               

                if (twat !== "" || twat !== "undefined") {
                    var twatEntry = "";
                    if (imageCheck == "flex") {
                        twatEntry += `<div id="twat-box">
                        <div class="twat-user">
                           <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary twats-user" id="twats-user" style="word-break: break-word;">${message.handle}</p>
                        </div>
                        <div id="twat-comment">
                           <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                ${twat}
                           </p>
                        </div>
                        <div class="component-image-container" style="min-height: 0;">
                           <div>
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">Images attached: ${number}</p>
                              <div>
                                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${photoOf}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>
                              </div>
                           </div>
                           <div class="container container-max-height" style="display: ${imageCheck}">
                              <div class="blocker">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                    <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                                    </path>
                                 </svg>
                                 <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                                    total pricks
                                 </p>
                              </div>
                              <div class="image twat-image-con" style="background-image: url(${photoOf}); display: none;">
                              </div>
                              <!-- <div class=""></div>
                              <div class="spacer"></div> -->
                           </div>
                        </div>
                        <div class="twat-low" style="margin-top: 8px;">
                           <div class="twat-low-icons">
                              <div title="Reply" aria-label="Reply" data-poster="${message.handle}" class="t-reply-button twat-reply">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="reply" class="svg-inline--fa fa-reply fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path fill="currentColor" d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z">
                                    </path>
                                 </svg>
                              </div>
                              <div title="RT" aria-label="Retweet" data-rt="${twat}" data-poster="${message.handle}" class="rt-btn twat-retweet">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="retweet" class="svg-inline--fa fa-retweet fa-w-20 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                    <path fill="currentColor" d="M629.657 343.598L528.971 444.284c-9.373 9.372-24.568 9.372-33.941 0L394.343 343.598c-9.373-9.373-9.373-24.569 0-33.941l10.823-10.823c9.562-9.562 25.133-9.34 34.419.492L480 342.118V160H292.451a24.005 24.005 0 0 1-16.971-7.029l-16-16C244.361 121.851 255.069 96 276.451 96H520c13.255 0 24 10.745 24 24v222.118l40.416-42.792c9.285-9.831 24.856-10.054 34.419-.492l10.823 10.823c9.372 9.372 9.372 24.569-.001 33.941zm-265.138 15.431A23.999 23.999 0 0 0 347.548 352H160V169.881l40.416 42.792c9.286 9.831 24.856 10.054 34.419.491l10.822-10.822c9.373-9.373 9.373-24.569 0-33.941L144.971 67.716c-9.373-9.373-24.569-9.373-33.941 0L10.343 168.402c-9.373 9.373-9.373 24.569 0 33.941l10.822 10.822c9.562 9.562 25.133 9.34 34.419-.491L96 169.881V392c0 13.255 10.745 24 24 24h243.549c21.382 0 32.09-25.851 16.971-40.971l-16.001-16z">
                                    </path>
                                 </svg>
                              </div>
                              <div title="Report" class="twat-report">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="flag" class="svg-inline--fa fa-flag fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path fill="currentColor" d="M349.565 98.783C295.978 98.783 251.721 64 184.348 64c-24.955 0-47.309 4.384-68.045 12.013a55.947 55.947 0 0 0 3.586-23.562C118.117 24.015 94.806 1.206 66.338.048 34.345-1.254 8 24.296 8 56c0 19.026 9.497 35.825 24 45.945V488c0 13.255 10.745 24 24 24h16c13.255 0 24-10.745 24-24v-94.4c28.311-12.064 63.582-22.122 114.435-22.122 53.588 0 97.844 34.783 165.217 34.783 48.169 0 86.667-16.294 122.505-40.858C506.84 359.452 512 349.571 512 339.045v-243.1c0-23.393-24.269-38.87-45.485-29.016-34.338 15.948-76.454 31.854-116.95 31.854z">
                                    </path>
                                 </svg>
                              </div>
                           </div>
                           <div class="twat-low-time">
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment.utc(message.time).local().fromNow()}</p>
                           </div>
                        </div>
                     </div>`
                    } else { //for no image
                        twatEntry += `<div id="twat-box">
                        <div class="twat-user">
                           <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary twats-user" id="twats-user" style="word-break: break-word;">${message.handle}</p>
                        </div>
                        <div id="twat-comment">
                           <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                ${twat}
                           </p>
                        </div>
                        <div class="component-image-container" style="min-height: 0;">
                           <div>
                             <div>
                                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${photoOf}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>
                              </div>
                           </div>
                           <div class="container container-max-height" style="display: ${imageCheck}">
                              <div class="blocker">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                    <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                                    </path>
                                 </svg>
                                 <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                                 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                                    total pricks
                                 </p>
                              </div>
                              <div class="image twat-image-con" style="background-image: url(${photoOf}); display: none;">
                              </div>
                              <!-- <div class=""></div>
                              <div class="spacer"></div> -->
                           </div>
                        </div>
                        <div class="twat-low" style="margin-top: 8px;">
                           <div class="twat-low-icons">
                              <div title="Reply" aria-label="Reply" data-poster="${message.handle}" class="t-reply-button twat-reply">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="reply" class="svg-inline--fa fa-reply fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path fill="currentColor" d="M8.309 189.836L184.313 37.851C199.719 24.546 224 35.347 224 56.015v80.053c160.629 1.839 288 34.032 288 186.258 0 61.441-39.581 122.309-83.333 154.132-13.653 9.931-33.111-2.533-28.077-18.631 45.344-145.012-21.507-183.51-176.59-185.742V360c0 20.7-24.3 31.453-39.687 18.164l-176.004-152c-11.071-9.562-11.086-26.753 0-36.328z">
                                    </path>
                                 </svg>
                              </div>
                              <div title="RT" aria-label="Retweet" data-rt="${twat}" data-poster="${message.handle}" class="rt-btn twat-retweet">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="retweet" class="svg-inline--fa fa-retweet fa-w-20 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                                    <path fill="currentColor" d="M629.657 343.598L528.971 444.284c-9.373 9.372-24.568 9.372-33.941 0L394.343 343.598c-9.373-9.373-9.373-24.569 0-33.941l10.823-10.823c9.562-9.562 25.133-9.34 34.419.492L480 342.118V160H292.451a24.005 24.005 0 0 1-16.971-7.029l-16-16C244.361 121.851 255.069 96 276.451 96H520c13.255 0 24 10.745 24 24v222.118l40.416-42.792c9.285-9.831 24.856-10.054 34.419-.492l10.823 10.823c9.372 9.372 9.372 24.569-.001 33.941zm-265.138 15.431A23.999 23.999 0 0 0 347.548 352H160V169.881l40.416 42.792c9.286 9.831 24.856 10.054 34.419.491l10.822-10.822c9.373-9.373 9.373-24.569 0-33.941L144.971 67.716c-9.373-9.373-24.569-9.373-33.941 0L10.343 168.402c-9.373 9.373-9.373 24.569 0 33.941l10.822 10.822c9.562 9.562 25.133 9.34 34.419-.491L96 169.881V392c0 13.255 10.745 24 24 24h243.549c21.382 0 32.09-25.851 16.971-40.971l-16.001-16z">
                                    </path>
                                 </svg>
                              </div>
                              <div title="Report" class="twat-report">
                                 <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="flag" class="svg-inline--fa fa-flag fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                                    <path fill="currentColor" d="M349.565 98.783C295.978 98.783 251.721 64 184.348 64c-24.955 0-47.309 4.384-68.045 12.013a55.947 55.947 0 0 0 3.586-23.562C118.117 24.015 94.806 1.206 66.338.048 34.345-1.254 8 24.296 8 56c0 19.026 9.497 35.825 24 45.945V488c0 13.255 10.745 24 24 24h16c13.255 0 24-10.745 24-24v-94.4c28.311-12.064 63.582-22.122 114.435-22.122 53.588 0 97.844 34.783 165.217 34.783 48.169 0 86.667-16.294 122.505-40.858C506.84 359.452 512 349.571 512 339.045v-243.1c0-23.393-24.269-38.87-45.485-29.016-34.338 15.948-76.454 31.854-116.95 31.854z">
                                    </path>
                                 </svg>
                              </div>
                           </div>
                           <div class="twat-low-time">
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment.utc(message.time).local().fromNow()}</p>
                           </div>
                        </div>
                     </div>`
                    }
                    
                    $('.twatter-entries').on('click', '.blocker', function () {
                        $(this).css('display', 'none');
                        $(this).parent('.container-max-height').children('.twat-image-con').css('display', 'block')
                    });
                    $('.twatter-entries').on('click', '.twat-report', function () {
                        complateInputJustGreen();
                        $('#twat-modal').modal('close');
                    });
                    $('.twatter-entries').on('click', '.twat-image-con', function () {
                        var bg = $(this).css('background-image');
                        bg = /^url\((['"]?)(.*)\1\)$/.exec(bg);
                        bg = bg ? bg[2] : ""; // If matched, retrieve url, otherwise ""     
                        // document.getElementById("viewImage").style.backgroundImage = "url('" + bg + "')";
                        $(".viewImage").attr("src", bg);
                        // document.getElementById("viewImage").style.backgroundSize = "700px 450px";
                        $(".viewImage").show();         
                        copyToClipboard(bg);
                    });
                    // $(".twatter-entries").mouseover('.twat-image-con',function () {
                    //     console.log("PICS HERE",photoOf)
                    //     // if (imageCheck == "none") {
                    //         // console.log("HOVER THIS IMAGE",photoOf)
                    //         document.getElementById('viewImage').src = photoOf;
                    //         $(".viewImage").show();
                    //     // }
                        
                    // })
                    $(".twatter-entries").mouseout('.twat-image-con',function () {
                        $(".viewImage").hide();
                        $("#viewImage").hide();
                    })
                    $(".twat-image-con").mouseout(function () {
                        $(".viewImage").hide();
                         $("#viewImage").hide();
                    })
                    
                    function copyToClipboard(text) {
                        var sampleTextarea = document.createElement("textarea");
                        document.body.appendChild(sampleTextarea);
                        sampleTextarea.value = text; //save main text in it
                        sampleTextarea.select(); //select textarea contenrs
                        document.execCommand("copy");
                        document.body.removeChild(sampleTextarea);
                    }
                   
                        $('.twatter-entries').prepend(twatEntry);
                }
            }, 1000);
            }
        }
    }
}

$("#selfieclose").click(function () {
    $('.selfieBox').hide();
    $.post('http://varial-newphone/closeSelfi', JSON.stringify({}));
})

$("#screensaver").click(function () {
  $('#bg-set-modal').modal('open');
})

$('.twat-message').keyup(debounce(function () {
    var i = $('.twat-message').val().length;
    $('#twat-lenght').text(`${i}` + '/255');
}, 1));
function cleareTwat() {
    $('.twat-message').val('');
    $('.twat-attach').val('');
    $('#twat-lenght').text('0/255');
}

function addNoti(tweets, myHandle, pTime) {
      
    var notiElement = $(`</div><div class="top-notifications-twitter not-the-call" style="max-height: 80px; display: flex;  ;"><div class="notification-container-twitter slideoutnotify slideinnotify" style="display: block; right: 55px;"><div class="app-bar-twitter"><div class="icon-twitter"><div class="twittericon" title="Messages" id="icon-noti" style="background: url('https://gta-assets.nopixel.net/images/phone-icons/twatter.png') 0% 0% / cover no-repeat;height: 18px; width: 18px; bottom: 0px; left: 2px;">
                
    </div>
    </div><div class="name"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;" id="notificaçaotweet-titel">${myHandle}</p></div><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;" id="notificaçao-time">${moment.utc(pTime).local().fromNow()}</p></div><div class="content"><div class="text"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; margin-top: -16px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;" id="notificaçaotweet-mensagem">${tweets.twat.text}</p>
    </div></div></div></div>`);
    $('.notificaçaoch').prepend(notiElement);
    setTimeout(() => {
        $(".notificaçaoch").empty();
    }, 5000);
    setTimeout(() => {
        if(pPhoneOpen === false) {
            $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").css("bottom" , "10px")
        }
    }, 5200)
    $(document).ready(function () {
        $(".not-the-call").click(function () {
            var removed = document.getElementsByClassName("not-the-call");
            for (i = 0; i < removed.length; i++) {
                removed[i].style.animation = "gotomommy 0.5s";
                setTimeout(function () {
                    for (i = 0; i < removed.length; i++) {
                        removed[i].innerHTML = "";
                        removed[i].remove();
                    }
                }, 499)
            }
        });
    })
    setTimeout(function () {
        var topNotifyReversVar = document.getElementsByClassName("notification-container")
        for (i = 0; i < topNotifyReversVar.length; i++) {
            topNotifyReversVar[i].style.animation = "gotomommy 0.5s";
            setTimeout(function () {
                for (i = 0; i < topNotifyReversVar.length; i++) {
                    topNotifyReversVar[i].innerHTML = "";
                    topNotifyReversVar[i].remove();
                }
            }, 499)
        }
    }, 3300)
}

function addNotiEmail(email, myHandle) {
    var notiElement = $(`</div><div class="top-notifications-email" style="max-height: 80px; display: flex;  ;"><div class="notification-container-email slideoutnotify slideinnotify" style="display: block; right: 55px;"><div class="app-bar-email"><div class="icon-twitter"><div class="emailicon" title="Email" id="icon-noti" style="background: url('https://gta-assets.nopixel.net/images/phone-icons/email.png') 0% 0% / cover no-repeat;height: 18px; width: 18px; bottom: 10px; left: 2px;">
                
    </div>
    </div><div class="name"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="margin-left: 0.5vw; color: white; word-break: break-word;">${myHandle}</p></div><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; color: white;" id="notificaçao-time">${("now")}</p></div><div class="content"><div class="text"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; margin-top: -16px; color: white; overflow: hidden; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;" id="notificaçaotweet-mensagem">${email}</p>
    </div></div></div></div>`);
    $('.notificaçaoch').prepend(notiElement);
    setTimeout(() => {
        $(".notificaçaoch").empty();
    }, 5000);
    setTimeout(() => {
        if(pPhoneOpen === false) {
            $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").css("bottom" , "10px")
        }
    }, 5200)
}

function addNotiMessage(message, myHandle) {
    var notiElement = $(`</div><div class="top-notifications-email" style="max-height: 80px; display: flex;  ;"><div class="notification-container-email slideoutnotify slideinnotify" style="display: block; right: 55px;"><div class="app-bar-email"><div class="icon-twitter"><div class="emailicon" title="Email" id="icon-noti" style="background: url('https://gta-assets.nopixel.net/images/phone-icons/conversations.png') 0% 0% / cover no-repeat;height: 18px; width: 18px; bottom: 10px; left: 2px;">
                
    </div>
    </div><div class="name"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="margin-left: 0.5vw; color: white; word-break: break-word;">${message}</p></div><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; color: white;" id="notificaçao-time">${("now")}</p></div><div class="content"><div class="text"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; margin-top: -16px; color: white; overflow: hidden; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;" id="notificaçaotweet-mensagem">${myHandle}</p>
    </div></div></div></div>`);
    $('.notificaçaoch').prepend(notiElement);
    setTimeout(() => {
        $(".notificaçaoch").empty();
    }, 5000);
    setTimeout(() => {
        if(pPhoneOpen === false) {
            $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
            $(".phone-app").css("bottom" , "10px")
        }
    }, 5200)
}

// function addNotiCalling(message, myHandle) {
//     var notiElement = $(`</div><div class="top-notifications-email" style="max-height: 80px; display: flex;  ;"><div class="notification-container-email slideoutnotify slideinnotify" style="display: block; right: 55px;"><div class="app-bar-email"><div class="icon-twitter"><div class="emailicon" title="Email" id="icon-noti" style="background: url('https://gta-assets.nopixel.net/images/phone-icons/calls.png') 0% 0% / cover no-repeat;height: 18px; width: 18px; bottom: 10px; left: 2px;">
                
//     </div>
//     </div><div class="name"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="margin-left: 0.5vw; color: black; word-break: break-word;">${myHandle}</p></div><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; color: black;" id="notificaçao-time">${("now")}</p></div><div class="content"><div class="text"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word; margin-top: -16px; color: black; overflow: hidden; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;" id="notificaçaotweet-mensagem">${message}</p>
//     </div></div></div></div>`);
//     $('.notificaçaoch').prepend(notiElement);
//     setTimeout(() => {
//         $(".notificaçaoch").empty();
//     }, 5000);
//     setTimeout(() => {
//         if(pPhoneOpen === false) {
//             $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
//             $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
//             $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
//             $(".phone-app").css("bottom" , "10px")
//         }
//     }, 5200)
// }

function addCallHistoryEntries(callHistory) {
    $('.callHistory-entries').empty();
    if (callHistory && Object.keys(callHistory).length > 0) {
        for (let callEntry of callHistory) {
            if (callEntry && callEntry.type && callEntry.number && callEntry.name) {
                let callIcon = (callEntry.type == 1 ? "call" : "phone_callback")
                let callIconColor = (callEntry.type == 1 ? "green" : "red")

                var number = callEntry.number.toString();
                var phoneNumber = number.slice(0, 3) + '-' + number.slice(3, 6) + '-' + number.slice(6, 10);

                var element = $(`
                <div class="hovereffect-callHistory">

                <h3>
                    <i class="fas fa-phone-alt fa-2x btn-contacts-call" aria-label="Call" data-name="${callEntry.name}" data-number="${callEntry.number}" style="font-size: 22px; margin-top: 10px;margin-left: 25px; font-size: 15px"></i>
                    <i class="fas fa-comment-medical fa-2x btn-contacts-send-message" aria-label="Send Message" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
                    <i class="fas fa-user-plus fa-2x btn-call-history-add-contact" aria-label="Add Contact" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
                </h3>
                  
                <div class="collapsible-header" style="font-size:12px">
                    <span class="${callIconColor}-text">
                        <i class="material-icons" style="color:${callIconColor}">${callIcon}</i>
                    </span>
                    <span style="color:white;margin-left:10px;">${callEntry.name}</span>
                    <span class="new badge number-badge" style="color: white;margin-left:-113;margin-top: 27px;width: 167px;font-size: 15px;" data-badge-caption="">${phoneNumber}</span>
                </div>
                
            </li>`);
                element.data("receiver", number);
                $('.callHistory-entries').append(element);
            }
        }
    }
}

function addYellowPage(item) {
    var yellowPage = $(`
        <div class="row no-padding">
            <div class="col s12">
            <div class="card yellow darken-1 yellow-page-entry" style="border-radius: 0;color: black; margin: 0.4rem 0px 0.02rem;">
                <div class="card-content black-text yellow-page-body center-align" style="border-bottom: solid 1px black"
                        <strong>${item.message}</strong>
                    </div>
                    <div class="card-action" style="padding-top: 8px;padding-right: 16px;padding-bottom: 8px;padding-left: 16px;font-size:14px">
                        <div class="row no-padding">
                            <div class="col s6">
                                <span aria-label="Call" data-balloon-pos="up-left" data-number="${item.phoneNumber}" class="yellow-pages-call"><i class="fas fa-phone-alt fa-1x"></i> ${item.phoneNumber}</span>
                            </div>
                            <div class="col s6" data-balloon-length="medium" aria-label="${item.name}" data-balloon-pos="down-right">
                                <span class="truncate"><i class="fas fa-user-circle fa-1x"></i> ${item.name}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>`);
    $('.yellow-pages-entries').prepend(yellowPage);
}

function addSanitation(item,cid,members){
    console.log(item.crew_name,item.leader)
    if((item.crew_name === item.crew_name && (item.leader === 0 || item.leader === 1))){
        console.log("THIS IS MY GROUP",JSON.stringify(item))

    }
    console.log(item.cid,cid)
    if(item.leader === 1){
        var element = $(`
        <li id="1">
        <div class="sanitation-group" style="font-size:10px; margin-top: 15px;">
            <i class="fas fa-users-slash" style="margin-bottom: -15px; left: 15px;"></i>
            <span style="color: white; margin-left: 10px; margin-top: -5px; width: 169px; font-size: 15px;">${item.name}</span>
            <span style="color: #f0eeec; margin-left: -167px; margin-top: 25px; width: 169px; font-size: 15px;"><i class="fas fa-sign-in-alt" style="font-size: 1rem;"></i></span>
            <span style="color: #f0eeec; right: -75px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-people-arrow-left" style="font-size: 1rem;"> 0</i></span>
            <span style="color: #f0eeec; right: -115px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-user" style="font-size: 1rem;"> 0</i></span>
        </div>
        </li>`);
    }

    $(".sanitation-entries").prepend(element);
}

function addMessage(item) {
    
    var date = (item.date === undefined ? Date.now() : item.date);
    if(item.unread === 0)
        var element = $(`
        <li id="${item.name}-${item.number}">
        <div class="collapsible-message-header" style="font-size:10px; margin-top: 10px;">
            <i class="fas fa-user-circle" style="margin-bottom: 5px; position: relative;"></i>
            <span style="color: #efebeb;margin-left: 23px;margin-top: 0px;width: 129px;font-size: 15px;">${item.msgDisplayName}</span>
            <span style="font-size: 0.5rem; right: 35px; color: #f0eeec; position: absolute;">${moment(date).local().fromNow()}</span>
            <i class="fas fa-circle" style="left: 35px; top: 2px;font-size: 0.3rem; position: relative;; text-shadow: 1px 1px 5px #32fa20;"></i>
            <i class="fas fa-share" style="font-size: 12px;position:relative;right: 165px;top: 26px;font-style: normal;"></i>
            <span style="color: #f0eeec;margin-left: -165px;margin-top: 23px;width: 169px;font-size: 0.8rem;"><b>${truncateString(item.message,17)}<b></span>
        </div>
    </li>`);
    else{
        var element = $(`
        <li id="${item.name}-${item.number}">
        <div class="collapsible-message-header" style="font-size:10px; margin-top: 15px;">
            <i class="fas fa-user-circle" style="margin-bottom: 5px; position: relative;"></i>
            <span style="color: #efebeb;margin-left: 23px;margin-top: 0px;width: 129px;font-size: 15px;">${item.msgDisplayName}</span>
            <span style="font-size: 0.5rem; right: 35px; color: #f0eeec; position: absolute;">${moment(date).local().fromNow()}</span>
            <i class="fas fa-circle" style="left: 35px; top: 2px;font-size: 0.3rem; position: relative;"></i>
            <i class="fas fa-share" style="font-size: 12px;position:relative;right: 165px;top: 26px;font-style: normal;"></i>
            <span style="color: #f0eeec;margin-left: -165px;margin-top: 23px;width: 169px;font-size: 0.8rem;">${truncateString(item.message,17)}</span>
        </div>
    </li>`);
    }
//<span class="new-badge" style="margin-left: 10px;margin-top: 40px;" data-badge-caption="">${moment(date).local().fromNow()}</span>
    element.id = item.id;
    element.click(function () {
        if(item.unread === 0){
            $.post('http://varial-newphone/readMessage', JSON.stringify({ id: item.id }));
        }
        $.post('http://varial-newphone/messageRead', JSON.stringify({ sender: item.sender, receiver: item.receiver, displayName: item.msgDisplayName }));
    });
    $(".messages-entries").prepend(element);
}


function addMessageOther(item) {
    // Check if message is already added
    var receiver = item.name || item.receiver;
    var date = (item.date === undefined ? Date.now() : item.date);
    var element = $('<div class="row messages-entry"> <div class="col s2 black-text"> <i class="far fa-user-circle fa-2x"></i> </div> <div class="col s10 messages-entry-details"> <div class="row no-padding"> <div class="col s8 messages-entry-details-sender">' + item.msgDisplayName + '</div> <div class="col s4 messages-entry-details-date right-align">' + moment(date).local().fromNow() + '</div> </div> <div class="row "> <div class="col s12 messages-entry-body">' + item.message + '</div> </div> </div> </div>');
    element.id = item.id;
    element.click(function () {
        $.post('http://varial-newphone/messageRead', JSON.stringify({ sender: item.sender, receiver: item.receiver, displayName: receiver, clientPhone: item.clientNumber }));
    });
    $(".messages-entries").prepend(element);
}

function validURL(string) {
	let pattern = /(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g;
	let data = string.match(pattern);
	return (data)
};

function addMessageRead(item, clientNumber, displayName) {
    var date = (item.date === undefined ? Date.now() : item.date);
    // If its "us" sending it, place it on the right
    const msgImage = validURL(item.message); //picture message insert
    $('.message-icon').css('display', 'block');
    $('#message-name').css('display', 'block');
    $('#message-number').css('display', 'block');
    $('.message-sender').css('display', 'none');
    if (isNumber(Number(displayName)) !== true){
        $('.messages-add-new-contact').css('display', 'none');
        $('#message-name').css('display', 'block');        
    }else{
        $('#addIcon').empty()
        $('#message-name').css('display', 'none');
        $('.messages-add-new-contact').css('display', 'block');
        $("#addIcon").append(`
        <i class="fas fa-user-plus white-text messages-add-new-contact" aria-label="Add Contact" style="right: 228px;top: 54px;display: block;display: absolute;"></i>`)
    }
    var imageCheck;
    var number;
    var hide;
    if (msgImage == null) {
        imageCheck = 'none'
        number = 0;
        hide = '';
    } else {
        imageCheck = 'flex';
        number = 1;
        hide = 'Hide (click image to copy URL)';
    }
    if (msgImage) {
        if (item.sender === clientNumber) {
            var msg = item.message.replace(msgImage, "")
            var element = `<li class="textMessage inner-in"><div class="inner inner-in">`
            element += `<div id="twat-comment">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                 ${msg}
            </p>
         </div><div class="component-image-container" style="min-height: 0;">
            
               <div>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${msgImage}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>

            </div>
            <div class="container container-max-height" style="display: ${imageCheck}">
               <div class="blocker">
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                     </path>
                  </svg>
                  <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                     total pricks
                  </p>
               </div>
               <div class="image msg-image" img-url="${msgImage}" style="background-image: url(${msgImage}); display: none;">
               </div>
               <!-- <div class=""></div>
               <div class="spacer"></div> -->
            </div>
         </div>`
            // element +=`<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${msg}<img src="${msgImage}" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://cdn-icons-png.flaticon.com/512/624/624815.png""></p></div>`
            element +=`</div><div class="timestamp timestamp-in"><span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p></div></li>`
            // var element = $('<div class="row message-entry"><div class="Messageright">' + msg + '<img src="'+msgImage+'" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://media.istockphoto.com/vectors/window-operating-system-error-warning-illustration-on-white-isolated-vector-id943008240?k=6&m=943008240&s=612x612&w=0&h=4LxxYIytSex0wQjHDJ8uBlzXWMsJ2Tw1Y9fhb_aqBmE""></div></div></div><div class="message-details">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".inboxMessages").append(element);
            $('.inboxMessages').data("sender", item.receiver);
            $('.inboxMessages').attr("sender", item.receiver);
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.receiver)
            $('#message-number').empty()
            var phoneNumber =  '(' + item.receiver.slice(0, 3) + ') ' + item.receiver.slice(3, 6) + '-' + item.receiver.slice(6, 10);
            $("#message-number").append(phoneNumber);
            $('.inboxMessages').on('click', '.blocker', function () {
                $(this).css('display', 'none');
                $(this).parent('.container-max-height').children('.msg-image').css('display', 'block')
            });
        } else {
            var msg = item.message.replace(msgImage, "")
            var element = `<li class="textMessage message-out"><div class="inner inner-out">`
            element += `<div id="twat-comment">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                 ${msg}
            </p>
         </div><div class="component-image-container" style="min-height: 0;">
            
               <div>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" photourl="${msgImage}" style="text-decoration: underline;" id="hide-tweet">${hide}</p>

            </div>
            <div class="container container-max-height" style="display: ${imageCheck}">
               <div class="blocker">
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" class="svg-inline--fa fa-eye fa-w-18 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z">
                     </path>
                  </svg>
                  <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">Click to View</p>
                  <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="text-align: center; margin-top: 8px;">Only reveal images from those you know are not
                     total pricks
                  </p>
               </div>
               <div class="image msg-image" style="background-image: url(${msgImage}); display: none;">
               </div>
               <!-- <div class=""></div>
               <div class="spacer"></div> -->
            </div>
         </div>`
            // element +=`<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${msg}<img src="${msgImage}" id="txt-img" class="msg-image" onerror="this.onerror=null; this.src="https://cdn-icons-png.flaticon.com/512/624/624815.png""></p></div>`
            element +=`</div><div class="timestamp timestamp-in"><span aria-label="${moment(date).local().calendar(null, calendarFormatDate)}" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${moment(date).local().fromNow()}</p></div></li>`
            // var element = $('<div class="row message-entry"><div class="Messageleft">' + msg + '</div></div></div><div class="message-details-in">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".inboxMessages").append(element);
            $('.inboxMessages').data("sender", item.sender);
            $('.inboxMessages').data("receiver", item.sender);
            $('.inboxMessages').attr("sender", item.receiver);
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneSNumber =  '(' + item.sender.slice(0, 3) + ') ' + item.sender.slice(3, 6) + '-' + item.sender.slice(6, 10);
            $("#message-number").append(phoneSNumber);
            $('.inboxMessages').on('click', '.blocker', function () {
                $(this).css('display', 'none');
                $(this).parent('.container-max-height').children('.msg-image').css('display', 'block')
            });
        }
    }else{
        if (item.sender === clientNumber) {
            var element = $('<li class="textMessage inner-in"><div class="inner inner-in"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + item.message + '</p></div><div class="timestamp timestamp-in"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" style="word-break: break-word;">' + moment(date).local().fromNow() + '</p></div></li>');
            // var element = $('<div class="row message-entry"><div class="Messageright">' + item.message + '</div></div><div class="message-details">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".inboxMessages").append(element);
            $('.inboxMessages').data("sender", item.receiver);
            $('.inboxMessages').data("receiver", item.receiver);
            $('#msg-sender').val(item.receiver)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneNumber =  '(' + item.receiver.slice(0, 3) + ') ' + item.receiver.slice(3, 6) + '-' + item.receiver.slice(6, 10);
            $("#message-number").append(phoneNumber);
        } else {
            var element = $('<li class="textMessage message-out"><div class="inner inner-out"><p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + item.message + '</p></div><div class="timestamp timestamp-out"><span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left"><p class="MuiTypography-root timestamp MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">' + moment(date).local().fromNow() + '</p></div></li>');
            // var element = $('<div class="row message-entry"><div class="Messageleft">' + item.message + '</div></div><div class="message-details-in">' + '<span aria-label="' + moment(date).local().calendar(null, calendarFormatDate) + '" data-balloon-pos="left">' + moment(date).local().fromNow() + '</span></div>');
            element.id = item.id;
            $(".inboxMessages").append(element);
            $('.inboxMessages').data("sender", item.sender);
            $('.inboxMessages').data("receiver", item.sender);
            
            $('#msg-sender').val(item.sender)
            $('#msg-receiver').val(item.sender)
            $('#message-number').empty()
            var phoneSNumber =  '(' + item.sender.slice(0, 3) + ') ' + item.sender.slice(3, 6) + '-' + item.sender.slice(6, 10);
            $("#message-number").append(phoneSNumber);
        }
    }
    $('.inboxMessages').data("displayName", displayName);
    $('.inboxMessages').data("clientNumber", clientNumber);
}

$(document).ready(function () {
    
    $('.debtjss271711').on('click', '.clicked-function-container', function () {
        var check = $(this).parent('.DebtPaper').children(".debtDrawer").css('display')
        if (check == "flex") {
            
            $(this).parent('.DebtPaper').children(".debtDrawer").css("display", "none");
            // drawer = 0
        } else {
            $(this).parent('.DebtPaper').children(".debtDrawer").css("display", "flex");
            // drawer = 1
        }
    });

    $(".jss47").click(function () {
        $("#messages-second-container").css("display", "none");
        openContainer("messages")
        // $.post('http://varial-newphone/messages', JSON.stringify({}));
        // $(".messages-container").css("display", "flex").addClass('slide');

        messagesacik = 0
    });

    $('#searchmessage').keyup(debounce(function () {
        messageFilter();
    }, 500));
})

const isNumber = value => {
    // First: Check typeof and make sure it returns number
    // This code coerces neither booleans nor strings to numbers,
    // although it would be possible to do so if desired.
    if (typeof value !== 'number') {
      return false
    }
    // Reference for typeof:
    // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof
    // Second: Check for NaN, as NaN is a number to typeof.
    // NaN is the only JavaScript value that never equals itself.
    if (value !== Number(value)) {
      return false
    }
    // Reference for NaN: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/isNaN
    // Note isNaN() is a broken function, but checking for self-equality works as NaN !== NaN
    // Alternatively check for NaN using Number.isNaN(), an ES2015 feature that works how one would expect
  
    // Third: Check for Infinity and -Infinity.
    // Realistically we want finite numbers, or there was probably a division by 0 somewhere.
    if (value === Infinity || value === !Infinity) {
      return false
    }
    return true
  }

  function addContact(item) {
    if (contactList.some(function (e) { return e.name == item.name && e.number == item.number; })) {
        return;
    }
    var random = Math.floor(Math.random() * 10000) + 1;
    contactList.push(item);
    contactList.sort();
    var number = item.number.toString();
    var phoneNumber = number.slice(0, 3) + '-' + number.slice(3, 6) + '-' + number.slice(6, 10);
    var name = item.name;
    var nameID = name.replace(/\s/g, '');
    var phone = item.number;
    var element = $(`<div hoverid=${random} class="component-paper contract-count">
        <div class="main-container">
            <div class="image">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-circle"
                class="svg-inline--fa fa-user-circle fa-w-16 fa-fw fa-3x " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
                <path fill="currentColor"
                d="M248 8C111 8 0 119 0 256s111 248 248 248 248-111 248-248S385 8 248 8zm0 96c48.6 0 88 39.4 88 88s-39.4 88-88 88-88-39.4-88-88 39.4-88 88-88zm0 344c-58.7 0-111.3-26.6-146.5-68.2 18.8-35.4 55.6-59.8 98.5-59.8 2.4 0 4.8.4 7.1 1.1 13 4.2 26.6 6.9 40.9 6.9 14.3 0 28-2.7 40.9-6.9 2.3-.7 4.7-1.1 7.1-1.1 42.9 0 79.7 24.4 98.5 59.8C359.3 421.4 306.7 448 248 448z">
                </path>
                </svg>
                </div>
                <div class="details ">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${name}</p>
                </div>
                <div class="description ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${phone}</p>
                </div>
                </div>
                <div hoverid="${random}" class="actions actions-show" style="display: none;">
                    <div aria-label="Delete" class="btn-contacts-remove" data-name="${item.name}" data-number="${item.number}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-slash" class="svg-inline--fa fa-user-slash fa-w-20 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                        <path fill="currentColor" d="M633.8 458.1L362.3 248.3C412.1 230.7 448 183.8 448 128 448 57.3 390.7 0 320 0c-67.1 0-121.5 51.8-126.9 117.4L45.5 3.4C38.5-2 28.5-.8 23 6.2L3.4 31.4c-5.4 7-4.2 17 2.8 22.4l588.4 454.7c7 5.4 17 4.2 22.5-2.8l19.6-25.3c5.4-6.8 4.1-16.9-2.9-22.3zM96 422.4V464c0 26.5 21.5 48 48 48h350.2L207.4 290.3C144.2 301.3 96 356 96 422.4z">
                        </path>
                    </svg>
                </div>
                <div aria-label="Call" class="btn-contacts-call" data-number="${item.number}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor" d="M493.4 24.6l-104-24c-11.3-2.6-22.9 3.3-27.5 13.9l-48 112c-4.2 9.8-1.4 21.3 6.9 28l60.6 49.6c-36 76.7-98.9 140.5-177.2 177.2l-49.6-60.6c-6.8-8.3-18.2-11.1-28-6.9l-112 48C3.9 366.5-2 378.1.6 389.4l24 104C27.1 504.2 36.7 512 48 512c256.1 0 464-207.5 464-464 0-11.2-7.7-20.9-18.6-23.4z">
                        </path>
                    </svg>
                </div>
                <div aria-label="Send Message" class="send-message-button-kisi btn-contacts-send-message" data-name="${item.name}" data-number="${item.number}" title="Message">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="comment" class="svg-inline--fa fa-comment fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor" d="M256 32C114.6 32 0 125.1 0 240c0 49.6 21.4 95 57 130.7C44.5 421.1 2.7 466 2.2 466.5c-2.2 2.3-2.8 5.7-1.5 8.7S4.8 480 8 480c66.3 0 116-31.8 140.6-51.4 32.7 12.3 69 19.4 107.4 19.4 141.4 0 256-93.1 256-208S397.4 32 256 32z">
                        </path>
                    </svg>
                </div>
                <div aria-label="Edit" class="btn-contacts-edit" data-name="${item.name}" data-number="${item.number}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clipboard" class="svg-inline--fa fa-clipboard fa-w-12 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                        <path fill="currentColor" d="M490.3 40.4C512.2 62.27 512.2 97.73 490.3 119.6L460.3 149.7L362.3 51.72L392.4 21.66C414.3-.2135 449.7-.2135 471.6 21.66L490.3 40.4zM172.4 241.7L339.7 74.34L437.7 172.3L270.3 339.6C264.2 345.8 256.7 350.4 248.4 353.2L159.6 382.8C150.1 385.6 141.5 383.4 135 376.1C128.6 370.5 126.4 361 129.2 352.4L158.8 263.6C161.6 255.3 166.2 247.8 172.4 241.7V241.7zM192 63.1C209.7 63.1 224 78.33 224 95.1C224 113.7 209.7 127.1 192 127.1H96C78.33 127.1 64 142.3 64 159.1V416C64 433.7 78.33 448 96 448H352C369.7 448 384 433.7 384 416V319.1C384 302.3 398.3 287.1 416 287.1C433.7 287.1 448 302.3 448 319.1V416C448 469 405 512 352 512H96C42.98 512 0 469 0 416V159.1C0 106.1 42.98 63.1 96 63.1H192z">
                        </path>
                    </svg>
                </div>
                <div aria-label="Copy Number" class="copy-number-c" number="${phone}" data-number="${item.number}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clipboard" class="svg-inline--fa fa-clipboard fa-w-12 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                        <path fill="currentColor" d="M384 112v352c0 26.51-21.49 48-48 48H48c-26.51 0-48-21.49-48-48V112c0-26.51 21.49-48 48-48h80c0-35.29 28.71-64 64-64s64 28.71 64 64h80c26.51 0 48 21.49 48 48zM192 40c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24m96 114v-20a6 6 0 0 0-6-6H102a6 6 0 0 0-6 6v20a6 6 0 0 0 6 6h180a6 6 0 0 0 6-6z">
                        </path>
                    </svg>
                </div>
            </div>
        </div>
    </div>`);
    $(".jss1481").append(element);
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("hoverid")
        $(".actions[hoverid=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none");
    });
    $('.call-call-div').click(function () {
        callNumber = $(this).attr("numbers");
        createNotifyCallAction("Dialing...", `${callNumber}`,);
    });

}

$('.jss1481').on('click', '.copy-number-c', function(events){
    // $('#messages-send-modal').modal('open');
    // $('#messages-send-modal #new-message-number').val($(this).data('number'));
    copyToClipboard($(this).data('number'))
    M.updateTextFields();
});

$('#add-contact').click(function(){
    $('.phone-add-contact').show()
});

$('#contact-close-input').click(function(){
    $('.phone-add-contact').hide()
});

$('#contact-close-input').click(function(){
    $('.phone-add-contact').hide()
});

$('#twat-close-input').click(function(){
    $('.send-twat-form').hide()
});

$('#rank-close-input').click(function(){
    $('.group-manage-rank-here').hide()
});
$('#rankSet-close-input').click(function(){
    $('.group-manage-rank-set-here').hide()
});

$('#paycheck-close-input').click(function(){
    $('.group-manage-paycheck').hide()
});



// $('#contact-submit-input').click(function(){
//     $('.phone-add-contact').hide()
// })

$("#contact-submit-input").click(function (e) {
    e.preventDefault();
    // console.log("SUBMIT FORM")
    var escapedName = escapeHtml($("#usernamesss").val());
    var clean = escapedName;
    complateInputJustGreen();
    setTimeout(() => {
        $.post('http://varial-newphone/newContactSubmit', JSON.stringify({
            name: clean,
            number: escapeHtml($("#usernumberss").val())
        }));
        $("#usernumberss").val("")
        $("#usernamesss").val("")
    }, 1000);
   

    if (currentContainer === "message") {
        $('.jss1153').hide()
        $('.jss1153').css("display", "none");
        $(".message-recipient").empty();
        $(".message-recipient").append(clean);
    }
   
    $('.phone-add-contact').hide()
});
//   function addContact(item) {
//     if (contactList.some(function (e) { return e.name == item.name && e.number == item.number; })) {
//         return;
//     }
//     contactList.push(item);
//     contactList.sort();
//     var number = item.number.toString();
//     var phoneNumber = number.slice(0, 3) + '-' + number.slice(3, 6) + '-' + number.slice(6, 10);
//     var name = item.name;
//     var nameID = name.replace(/\s/g, '');
//     var element = $(`
//     <div class="hovereffect">

//     <h3>
//     <i class="fas fa-user-slash  btn-contacts-remove" aria-label="Delete Contact" data-name="${item.name}" data-number="${item.number}"style="font-size: 22px; margin-top: 10px;margin-left: 15px; font-size: 15px"></i>
//     <i class="fas fa-phone  btn-contacts-call" aria-label="Call" data-number="${item.number}"  style="margin-left: 25px;font-size: 15px;"></i>
//     <i class="fas fa-comment  btn-contacts-send-message" aria-label="Send Message" data-name="${item.name}" data-number="${item.number}" style="margin-left: 25px;font-size: 15px;"></i>
//     <i class="fas fa-pencil-alt  btn-contacts-edit" aria-label="Edit" data-name="${item.name}" data-number="${item.number}" style="margin-left: 25px;font-size: 15px;"></i>
//     </h3>
      
//     <li id="${item.name}-${item.number}">
//     <div class="collapsible-header" style="font-size:12px">
//         <i class="fa fa-user-circle"></i>
//         <span style="word-break: break-word;color: white;margin-left: 10px;margin-top: 0px;  width: 169px; font-size: 15px;">${item.name}</span>
//         <span class="new badge number-badge" style="word-break: break-word;color: white;margin-left: -222px;margin-top: 27px;width: 167px;font-size: 15px;" data-badge-caption="">${phoneNumber}</span>
//     </div>
//     <div class="collapsible-body center-align icon-spacing">
//         <i class="fas fa-user-slash fa-2x btn-contacts-remove" aria-label="Delete Contact" data-name="${item.name}" data-number="${item.number}"style="margin-top: 10px;margin-left: 20px;"></i>
//         <i class="fas fa-phone fa-2x btn-contacts-call" aria-label="Call" data-number="${item.number}"></i>
//         <i class="fas fa-comment fa-2x btn-contacts-send-message" aria-label="Send Message" data-name="${item.name}" data-number="${item.number}"></i>
//         <i class="fas fa-pencil-alt fa-2x btn-contacts-edit" aria-label="Edit" data-name="${item.name}" data-number="${item.number}"></i>
//     </div>
// </li>`);
// $(".contacts-entries").append(element);
// }

function addCallsHistory(callHistory) {
    $('.calls-entries').empty();
    if (callHistory && Object.keys(callHistory).length > 0) {
        $('#nocallHistory').hide();
        for (let callEntry of callHistory) {
            if (callEntry && callEntry.type && callEntry.number && callEntry.name) {
                let callIcon = (callEntry.type == 1 ? "call" : "phone_callback")
                let callIconColor = (callEntry.type == 1 ? "M18.92 351.2l108.5-46.52c12.78-5.531 27.77-1.801 36.45 8.98l44.09 53.82c69.25-34 125.5-90.31 159.5-159.5l-53.81-44.04c-10.75-8.781-14.41-23.69-8.974-36.47l46.51-108.5c6.094-13.91 21.1-21.52 35.79-18.11l100.8 23.25c14.25 3.25 24.22 15.8 24.22 30.46c0 252.3-205.2 457.5-457.5 457.5c-14.67 0-27.18-9.968-30.45-24.22l-23.25-100.8C-2.571 372.4 5.018 357.2 18.92 351.2z" : "M497.39 361.8l-112-48a24 24 0 0 0-28 6.9l-49.6 60.6A370.66 370.66 0 0 1 130.6 204.11l60.6-49.6a23.94 23.94 0 0 0 6.9-28l-48-112A24.16 24.16 0 0 0 122.6.61l-104 24A24 24 0 0 0 0 48c0 256.5 207.9 464 464 464a24 24 0 0 0 23.4-18.6l24-104a24.29 24.29 0 0 0-14.01-27.6z")
                var random = Math.floor(Math.random() * 10000) + 1;
                var number = callEntry.number.toString();
                var phoneNumber = number.slice(0, 3) + '-' + number.slice(3, 6) + '-' + number.slice(6, 10);
              
                // console.log("CALLER TYPE",callEntry.type)
                var element =`<div hoverid=${random} class="component-paper contract-count" style="width: 92%; left: 13px;">
                <div class="main-container">
                <div class="image">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone-alt" class="svg-inline--fa fa-phone-alt fa-w-16 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor" d="${callIconColor}">
                </path>
             </svg>
                </div>
                <div class="details ">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${callEntry.name}</p>
                </div>
                <div class="description ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${callEntry.number}</p>
                </div>
                </div>
                <div hoverid="${random}" class="actions actions-show" style="display: none;">`

               
                  if (isNaN(callEntry.name) == false){
                    // console.log("ITS SAVED",callEntry.name)
                    element += ` <div aria-label="Add Contact" class="yeet-button" number="${callEntry.number}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-slash" class="svg-inline--fa fa-user-slash fa-w-20 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                    <path fill="currentColor" d="M224 256c70.7 0 128-57.31 128-128S294.7 0 224 0C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3C77.61 304 0 381.6 0 477.3C0 496.5 15.52 512 34.66 512h378.7C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304zM616 200h-48v-48C568 138.8 557.3 128 544 128s-24 10.75-24 24v48h-48C458.8 200 448 210.8 448 224s10.75 24 24 24h48v48C520 309.3 530.8 320 544 320s24-10.75 24-24v-48h48C629.3 248 640 237.3 640 224S629.3 200 616 200z">
                    </path>
                    </svg>
                    </div>`
                }
                element +=`
                <div aria-label="Call" class="btn-contacts-call" data-number="${callEntry.number}">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor" d="M493.4 24.6l-104-24c-11.3-2.6-22.9 3.3-27.5 13.9l-48 112c-4.2 9.8-1.4 21.3 6.9 28l60.6 49.6c-36 76.7-98.9 140.5-177.2 177.2l-49.6-60.6c-6.8-8.3-18.2-11.1-28-6.9l-112 48C3.9 366.5-2 378.1.6 389.4l24 104C27.1 504.2 36.7 512 48 512c256.1 0 464-207.5 464-464 0-11.2-7.7-20.9-18.6-23.4z">
                </path>
                </svg>
                </div>
                <div class="send-message-button-kisi btn-contacts-send-message" aria-label="Message" data-number="${callEntry.number}">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="comment" class="svg-inline--fa fa-comment fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor" d="M256 32C114.6 32 0 125.1 0 240c0 49.6 21.4 95 57 130.7C44.5 421.1 2.7 466 2.2 466.5c-2.2 2.3-2.8 5.7-1.5 8.7S4.8 480 8 480c66.3 0 116-31.8 140.6-51.4 32.7 12.3 69 19.4 107.4 19.4 141.4 0 256-93.1 256-208S397.4 32 256 32z">
                </path>
                </svg>
                </div>
                <div aria-label="Copy Number" class="copy-number-c" number="${callEntry.number}" data-number="${callEntry.number}">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clipboard" class="svg-inline--fa fa-clipboard fa-w-12 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                <path fill="currentColor" d="M384 112v352c0 26.51-21.49 48-48 48H48c-26.51 0-48-21.49-48-48V112c0-26.51 21.49-48 48-48h80c0-35.29 28.71-64 64-64s64 28.71 64 64h80c26.51 0 48 21.49 48 48zM192 40c-13.255 0-24 10.745-24 24s10.745 24 24 24 24-10.745 24-24-10.745-24-24-24m96 114v-20a6 6 0 0 0-6-6H102a6 6 0 0 0-6 6v20a6 6 0 0 0 6 6h180a6 6 0 0 0 6-6z">
                </path>
                </svg>
                </div>
                </div>
                </div>
                </div>`
        //         var element =`
        //         <div class="component-paper arama-div arama-count">
		// 	<div class="main-container">
		// 	   <div class="image">
				//   <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone-alt" class="svg-inline--fa fa-phone-alt fa-w-16 fa-fw fa-3x " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
				// 	 <path fill="currentColor" d="M497.39 361.8l-112-48a24 24 0 0 0-28 6.9l-49.6 60.6A370.66 370.66 0 0 1 130.6 204.11l60.6-49.6a23.94 23.94 0 0 0 6.9-28l-48-112A24.16 24.16 0 0 0 122.6.61l-104 24A24 24 0 0 0 0 48c0 256.5 207.9 464 464 464a24 24 0 0 0 23.4-18.6l24-104a24.29 24.29 0 0 0-14.01-27.6z">
				// 	 </path>
				//   </svg>
		// 	   </div>
		// 	   <div class="details ">
		// 		  <div class="title ">
		// 			 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${callEntry.number}</p>
		// 		  </div>
		// 		  <div class="description ">
		// 			 <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">just now</p>
		// 		  </div>
		// 	   </div>
		// 	</div>
		//  </div>`
            //     var element = $(`
            //     <div class="hovereffect-callHistory">

            //     <h3>
            //         <i class="fas fa-phone-alt fa-2x btn-contacts-call" aria-label="Call" data-name="${callEntry.name}" data-number="${callEntry.number}" style="font-size: 22px; margin-top: 10px;margin-left: 25px; font-size: 15px"></i>
            //         <i class="fas fa-comment-medical fa-2x btn-contacts-send-message" aria-label="Send Message" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
            //         <i class="fas fa-user-plus fa-2x btn-call-history-add-contact" aria-label="Add Contact" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
            //     </h3>
                  
            //     <div class="collapsible-header" style="font-size:12px">
            //         <span class="${callIconColor}-text">
            //             <i class="material-icons" style="color:${callIconColor}">${callIcon}</i>
            //         </span>
            //         <span style="color:white;margin-left:10px;">${callEntry.name}</span>
            //         <span class="new badge number-badge" style="color: white;margin-left:-90;margin-top: 27px;width: 107px;font-size: 15px;" data-badge-caption="">${phoneNumber}</span>
            //     </div>
                
            // </li>`);
                // element.data("receiver", number);
                $('.calls-entries').append(element);
            }
            $(".component-paper").mouseover(function () {
				overid = $(this).attr("hoverid")
				$(".actions[hoverid=" + overid + "]").css("display", "flex");
			}).mouseout(function () {
				$(".actions").css("display", "none");
			});
            $('.copy-number-c').click(function(){
                copyToClipboard($(this).data('number'))
            })
            $('.yeet-button').click(function(){
                $('.phone-add-contact').show()
                num = $('.yeet-button').attr('number')
                $('#usernumberss').val(num)
            })
        }
    }else{
        $('#nocallHistory').show();
    }
}

// function addCallsHistory(callHistory) {
//     $('.calls-entries').empty();
//     if (callHistory && Object.keys(callHistory).length > 0) {
//         $('#nocallHistory').hide();
//         for (let callEntry of callHistory) {
//             if (callEntry && callEntry.type && callEntry.number && callEntry.name) {
//                 let callIcon = (callEntry.type == 1 ? "call" : "phone_callback")
//                 let callIconColor = (callEntry.type == 1 ? "green" : "red")

//                 var number = callEntry.number.toString();
//                 var phoneNumber = number.slice(0, 3) + '-' + number.slice(3, 6) + '-' + number.slice(6, 10);

//                 var element = $(`
//                 <div class="hovereffect-callHistory">

//                 <h3>
//                     <i class="fas fa-phone-alt fa-2x btn-contacts-call" aria-label="Call" data-name="${callEntry.name}" data-number="${callEntry.number}" style="font-size: 22px; margin-top: 10px;margin-left: 25px; font-size: 15px"></i>
//                     <i class="fas fa-comment-medical fa-2x btn-contacts-send-message" aria-label="Send Message" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
//                     <i class="fas fa-user-plus fa-2x btn-call-history-add-contact" aria-label="Add Contact" data-number="${callEntry.number}" style="margin-left: 42px;font-size: 15px;"></i>
//                 </h3>
                  
//                 <div class="collapsible-header" style="font-size:12px">
//                     <span class="${callIconColor}-text">
//                         <i class="material-icons" style="color:${callIconColor}">${callIcon}</i>
//                     </span>
//                     <span style="color:white;margin-left:10px;">${callEntry.name}</span>
//                     <span class="new badge number-badge" style="color: white;margin-left:-90;margin-top: 27px;width: 107px;font-size: 15px;" data-badge-caption="">${phoneNumber}</span>
//                 </div>
                
//             </li>`);
//                 element.data("receiver", number);
//                 $('.calls-entries').append(element);
//             }
//         }
//     }else{
//         $('#nocallHistory').show();
//     }
// }

//Send Ping
$(document).ready(function () {
    
    $('.send-ping').click(function () {
        var targetId = $('.send-value').val()
        // console.log("SEND PING HERE",targetId)
        // $.post('http://varial-newphone/btnCamera', JSON.stringify({}));
        $.post('http://varial-newphone/varial-ui:pingSend', JSON.stringify({
            number: targetId
        }));
        $('.send-value').val('');
    });

    $('.send-ping-anon').click(function () {
        var targetId = $('.send-value').val()
        // console.log("SEND PING HERE",targetId)
        // $.post('http://varial-newphone/btnCamera', JSON.stringify({}));
        $.post('http://varial-newphone/varial-ui:pingSend', JSON.stringify({
            number: targetId,
            anonymous: true
        }));
        $('.send-value').val('');
    });
})

function addSanitationGroup(group){
    // console.log("Add sanitation group",JSON.stringify(group))
    // let element
    if (group && Object.keys(group).length > 0) {
        for (let member of group) {
            if (member.leader !== 1){
                console.log("member name",member.name)
                let element = `
            <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
                <i class="fas fa-user" style="margin-bottom: -15px; margin-left: 10px;"></i>
                <span style="color: white; margin-left: 5px; margin-top: -5px; width: 169px; font-size: 15px;">${member.name}</span>
            </div>
    `
    $('.groupLeader-entries').append(element);
            }
        }
        
    };
    
    // let members = `
    //         <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
    //             <i class="fas fa-user-graduate" style="margin-bottom: -15px; margin-left: 10px;"></i>
    //             <span class="group-leader" style="color: white; margin-left: 5px; margin-top: -5px; width: 169px; font-size: 15px;"></span>
    //         </div>
    // `
    
}

function removeContact(item) {
    $('#' + item.name + '-' + item.number).remove();
    contactList = contactList.filter(function (e) {
        return e.name != item.name && e.number != item.number;
    });
}

function KeysFilter() {
    var filter = $('#keys-search').val();
    $("ul.keys-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (keyFilters.includes($(this).data('key-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function GPSFilter() {
    var filter = $('#gps-search').val();
    $("ul.gps-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (gpsFilters.includes($(this).data('house-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function GurgleFilter() {
    $('.gurgle-entries').empty();
    var filter = $('#gurgle-search').val();
    let matchedEntries = gurgleEntries.filter(item => {
        let keys = Object.keys(item);
        for (let itemIndex in keys) {
            if (keys[itemIndex] == 'action')
                continue;
            let key = keys[itemIndex];
            if (key !== 'action') {
                if (item[key].search(new RegExp(filter, "i")) >= 0)
                    return true;
            }
        }
    });
    for (let i = 0; i < matchedEntries.length; i++) {
        let searchElement = `
                            <div class="row no-padding phone-button" >
                                <div class="col s12">
                                    <div class="card white gurgle-card ${matchedEntries[i].action !== undefined ? `phone-button" data-action="${matchedEntries[i].action}">` : '">'}
                                        <div class="card-content gurgle-card-content">
                                            <span class="card-title gurgle-card-title">${matchedEntries[i].webTitle}</span>
                                            <p class="gurgle-card-body black-text">${matchedEntries[i].webDescription}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            `
        $('.gurgle-entries').append(searchElement);
    }
}

function MessagesFilter() {
    var filter = $('#new-message-search').val();
    $("ul.messages-entries li").each(function () {
        
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function ContactsFilter() {
    var filter = $('#new-contact-search').val();
    $("ul.contacts-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function businessFilter(){
    // jss17911111
    var filter = $('#business-search').val();
    $(".jss17911111 .component-paper").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (keyFilters.includes($(this).data('key-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function EmployeeFilter() {
    var filter = $('#employee-Search').val();
    $(".g2-entries .contract-count").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (keyFilters.includes($(this).data('key-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function YPFilter() {
    var filter = $('#yp_search').val();
    $(".yellow-pages-entries").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            if (keyFilters.includes($(this).data('key-type')))
                $(this).hide();
            else
                $(this).show()
        }
    });
}

function NewContactsFilter() {
    var filter = $('#u-contact-search').val();
    $(".jss1481 .contract-count").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function CarsFilter() {
    var filter = $('#new-car-search').val();
    $("ul.garage-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function ManageFilter() {
    var filter = $('#group-manage-search').val();
    $("ul.group-manage-entries li").each(function () {
        if ($(this).find('.group-manage-entry-title').text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function OutstandingFilter() {
    var filter = $('#outstanding-search').val();
    $(".outstanding-payments-entries .outstanding-payment-entry").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

function ManageKeysFilter() {
    var filter = $('#manage-keys-search').val();
    $("ul.manage-keys-entries li").each(function () {
        if ($(this).text().search(new RegExp(filter, "i")) < 0) {
            $(this).hide();
        } else {
            $(this).show()
        }
    });
}

 
// var of Controls
var controlNames = [];
var currentBinds = [];
var currentSettings = [];
var currentSettingWindow = "tokovoip";

var checkedFunctions = ["stereoAudio","localClickOn","localClickOff","remoteClickOn","remoteClickOff"];
var sliderFunctions = ["clickVolume","radioVolume", "phoneVolume"];


controlNames[0] = ["label","Toko Voip Controls"];
controlNames[1] = ["tokoptt","Toko: Radio Push To Talk",true];
controlNames[2] = ["loudSpeaker","Toko: Loud Speaker",false];
controlNames[3] = ["distanceChange","Toko: Distance Change",false];
controlNames[4] = ["handheld","Toko: Handheld Radio",true];
controlNames[5] = ["carStereo","Toko: Car Stereo",true];
controlNames[6] = ["switchRadioEmergency","Toko: Emergency change radio",false];
controlNames[7] = ["radiovolumedown","Toko: Volume down",true];
controlNames[8] = ["radiovolumeup","Toko: Volume up",true];
controlNames[9] = ["radiotoggle","Toko: Toggle Radio",true];



controlNames[10] = ["label","General Controls"];

controlNames[11] = ["generalPhone","General: Phone",true];
controlNames[12] = ["generalInventory","General: Inventory",true]; 
controlNames[13] = ["generalEscapeMenu","General: Leave Menu",true]; 
controlNames[14] = ["generalChat","General: Chat",true];

controlNames[15] = ["actionBar","General: Action Bar",true];
controlNames[16] = ["generalUse","General: Use Action",false]; // this is set to false , might end up setting true might need testing
controlNames[17] = ["generalUseSecondary","General: Menu Secondary",true];
controlNames[18] = ["generalUseSecondaryWorld","General: World Secondary",true];
controlNames[19] = ["generalUseThird","General: World Third",false];
controlNames[20] = ["generalTackle","General: Tackle",true];
controlNames[21] = ["generalMenu","General: Action Menu",true];
controlNames[22] = ["generalProp","General: Prop Drop",false];
controlNames[23] = ["generalScoreboard","General: Scoreboard",false];

controlNames[24] = ["label","Movement Controls"];
controlNames[25] = ["movementCrouch","Move: Crouch",false];
controlNames[26] = ["movementCrawl","Move: Crawl",false];


controlNames[27] = ["label","Vehicle Controls"];
controlNames[28] = ["vehicleCruise","Vehicle: Cruise Control",false];
controlNames[29] = ["vehicleSearch","Vehicle: Search",false];
controlNames[30] = ["vehicleHotwire","Vehicle: Hotwire",false];
controlNames[31] = ["vehicleDoors","Vehicle: Door Lock",false];
controlNames[32] = ["vehicleBelt","Vehicle: Toggle Belt",false];

controlNames[33] = ["vehicleSlights","Siren: Toggle Lights",false];
controlNames[34] = ["vehicleSsound","Siren: Toggle Sound",false];
controlNames[35] = ["vehicleSnavigate","Siren: Switch Lights",false];



controlNames[36] = ["heliCam","Heli: Cam",false];
controlNames[37] = ["helivision","Heli: Vision",false];
controlNames[38] = ["helirappel","Heli: Rappel",false];
controlNames[39] = ["helispotlight","Heli: Spotlight",false];
controlNames[40] = ["helilockon","Heli: Lockon",false];


controlNames[41] = ["label","News Controls"];
controlNames[42] = ["newsTools","Bring out News Tools",false];
controlNames[43] = ["newsNormal","Camera Normal",false];
controlNames[44] = ["newsMovie","Camera Movie",false];

controlNames[45] = ["label","Motel Controls"];
controlNames[46] = ["housingMain","Motel: Main Useage",false];
controlNames[47] = ["housingSecondary","Motel: Secondary Usage",false];

function updateSettings()
{
    switch (currentSettingWindow) {
        case "tokovoip":
            updateTokoSettings();
            break;
        case "control":
            $.post('http://varial-newphone/settingsUpdateToko', JSON.stringify({tag: "controlUpdate", controls: currentBinds}));
            break;
        case "browser":
            break;
        default:
            console.log("Error: incorrect active tab found")
            break;
    }

}

function ResetSettings()
{
    switch (currentSettingWindow) {
        case "tokovoip":
            $.post('http://varial-newphone/settingsResetToko', JSON.stringify());
            break;
        case "control":
            $.post('http://varial-newphone/settingsResetControls', JSON.stringify());
            break;
        case "browser":
            break;
        default:
            console.log("Error: incorrect active tab found : reset")
            break;
    }
    openContainer(oldContainerHistory.pop(), null, currentContainer);
}


var validBinds = [
    "esc","f1","f2","f3","f5","f5","f6","f7","f8","f9","f10",
    "~","5","6","7","8","9","-","=","backspace",
    "tab","q","e","r","t","y","u","p","[","]","enter",
    "caps","f","g","h","k","l",
    "leftshift","z","x","c","b","n","m",",",".",
    "leftctrl","leftalt","space","rightctrl",
    "home","pageup","pagedown","delete",
    "left","right","top","down",
    "nenter","n4","n5","n6","n7","n8","n9","inputaim"
];

// Util Functions of Controls

function getCurrentBindFromID(bindID)
{
    for (var i = currentBinds.length - 1; i >= 0; i--) {
        if(currentBinds[i][0].toUpperCase() == bindID.toUpperCase())
        {
            return currentBinds[i][1];
        }
    }

    return false;
}

function setBindFromID(bindID,bind)
{
    for (var i = currentBinds.length - 1; i >= 0; i--) {
        if(currentBinds[i][0].toUpperCase() == bindID.toUpperCase())
        {
            currentBinds[i][1] = bind;
        }
    }
}

function validKey(key)
{
    var bindValid = false
    for (var i = validBinds.length - 1; i >= 0; i--) {
        if(validBinds[i].toUpperCase() == key.toUpperCase())
        {
            bindValid = true
        }
    }
    return bindValid
    
}


// Fill fucntion of control
function createControlList()
{
    for (let i = 0; i < controlNames.length; i++) { 
        var bindID = controlNames[i][0];
        var bindIsLocked = controlNames[i][2];

        if(bindID == "label")
        {
             var element = $(`
                <div class="row settings-switchBorder">
                  <div class="col s12 resizeBorder">
                      <label class="resizeBorder-Text">${controlNames[i][1]}</label>
                  </div>
                </div> 
            `);

            $('#controlSettings').append(element);
        }
        else
        {
            var element;
            if(bindIsLocked)
            {
                element = $(`
                    <div class="row settings-switchBorder">
                        <div class="col s8">
                            <label class="resizeBorder2 lockedText">${controlNames[i][1]}</label>
                        </div>
                        <div class="input-field col s4 input-field-small">
                             <input class="errorChecking white-text" id="${bindID}" type="text" onfocusout="TriggerSubmit(id)" data-isUnique="${controlNames[i][2]}"> 
                        </div>
                    </div>
                <span class="error" id="${bindID}-error" aria-live="polite"></span> 
                `);
            }
            else
            {
                element = $(`
                    <div class="row settings-switchBorder">
                        <div class="col s8">
                            <label class="resizeBorder2">${controlNames[i][1]}</label>
                        </div>
                        <div class="input-field col s4 input-field-small">
                             <input class="errorChecking white-text" id="${bindID}" type="text" onfocusout="TriggerSubmit(id)" data-isUnique="${controlNames[i][2]}"> 
                        </div>
                    </div>
                <span class="error" id="${bindID}-error" aria-live="polite"></span> 
                `);
            }
            $('#controlSettings').append(element);
            $("#"+bindID).val(getCurrentBindFromID(bindID))
        }
         
    }
}

function setSettings()
{
    for (i in currentSettings) {
        for (j in currentSettings[i]) {
            var name = j
            var outcome = currentSettings[i][j]
           
            if(findTypeOf(name) == 1)
            {   
                $('#'+name).prop('checked', outcome);
            }
            else if(findTypeOf(name) == 2)
            {
                $('#' + name).val(outcome * 10);
            }
        }
    }
}

function updateOnID(settingID,varData)
{
    for (i in currentSettings) {
        for (j in currentSettings[i]) {
            if(j == settingID)
            {   
                currentSettings[i][j] = varData
            }
        }
    }
}
function delay() {
  return new Promise(resolve => setTimeout(resolve, 30));
}

async function delayedLog(item) {
  await delay();
}

// I have autism
// this gets the minimum number in a slider, the maximum, then returns the exact opposite.

async function updateTokoSettings()
{

    for (j in checkedFunctions) {
        var name = checkedFunctions[j]
        var varData = $('#'+name).prop('checked');
        updateOnID(name,varData);
        await delayedLog(name);
    }

    for (j in sliderFunctions) {
        var name = sliderFunctions[j]
        var varData = $('#'+name).val();

        updateOnID(name, varData / 10);
        await delayedLog(name);
    }

    await delayedLog();
    $.post('http://varial-newphone/settingsUpdateToko', JSON.stringify({
        tag: "settings",
        settings: currentSettings,
    }));

}



function findTypeOf(settingID)
{
    var type = 0

    for (j in checkedFunctions) {
        if(settingID == checkedFunctions[j])
        {
            type = 1
        }
    }

    if(type == 0)
    {
        for (j in sliderFunctions) {
            if(settingID == sliderFunctions[j])
            {
                type = 2
            }
        }
    }

    return type
}

//Submit Function / check function / main function of control
function TriggerSubmit(name)
{
    var error = $("#"+name+"-error")[0]; 
   
    var valid = true
    var errorMessage = "Invalid Control Input."

    var inputVal = $("#"+name).val();
    var isUnique = $("#"+name).attr("data-isUnique");


     if(inputVal == "")
    {
        valid = false;
        errorMessage = "There must be a bind for this.";
    }

    if(valid)
    {

        if(inputVal.includes('+'))
        {
            var split = inputVal.split("+");
            if(split.length == 2){
                if(!validKey(split[0]))
                {
                    valid = false 
                    errorMessage = "Not a valid bind [1]."
                }
                if(!validKey(split[1]) && valid)
                {
                    valid = false 
                    errorMessage = "Not a valid bind [2]."
                }
            }
            else
            {
                valid = false 
                errorMessage = "Cannot bind 3 keys."
            }
        }
        else
        {
            if(!validKey(inputVal))
            {
                valid = false 
                errorMessage = "Not a valid bind."
            }
        }
    }

    if (valid) {
        for (var i = controlNames.length - 1; i >= 0; i--) {
            if(controlNames[i][0] != "label")
            {
                var nameArr = controlNames[i][0]
                var isUniqueArr = $("#"+nameArr).attr("data-isUnique");
                if(nameArr != name){

                    // If input is the same as another already set input and that found input is unique then error
                    if($("#"+nameArr).val().toUpperCase() == inputVal.toUpperCase() && isUniqueArr == "true"){
                        valid = false;
                        errorMessage = "This Bind is already Being Used";
                    }
                    // if input is same as another already set input and THIS is unique then error
                    
                    if($("#"+nameArr).val().toUpperCase() == inputVal.toUpperCase() && isUnique == "true")
                    {
                        valid = false;
                        errorMessage = "Already in Use : "+controlNames[i][1];
                    }

                    if(inputVal.includes('+'))
                    {
                        var split = inputVal.split("+");
                        var newInput = split[1]+"+"+split[0]

                        if(split[1].toUpperCase() == split[0].toUpperCase()){
                            valid = false;
                            errorMessage = "Both Binds cannot be the same";
                        }

                        // If input is the same as another already set input and that found input is unique then error
                        if($("#"+nameArr).val().toUpperCase() == newInput.toUpperCase() && isUniqueArr == "true"){
                            valid = false;
                            errorMessage = "This Bind is already Being Used";
                        }
                        // if input is same as another already set input and THIS is unique then error
                        
                        if($("#"+nameArr).val().toUpperCase() == newInput.toUpperCase() && isUnique == "true")
                        {
                            valid = false;
                            errorMessage = "Already in Use : "+controlNames[i][1];
                        }
                    }
                }
            }
        }
    }

    if (!valid) {
        error.innerHTML = errorMessage;
        error.className = "error active";
    }
    else
    {
        $("#"+name).val(inputVal.toUpperCase())
        setBindFromID(name,inputVal)
        error.innerHTML = "";
        error.className = "error";
    }
}

function reply_click(clicked_id)
{
  currentSettingWindow = clicked_id;
}

$('#manage-keys-search').keyup(debounce(function () {
    ManageKeysFilter();
}, 500));

$('#outstanding-search').keyup(debounce(function () {
    OutstandingFilter();
}, 500));

$('#keys-search').keyup(debounce(function () {
    KeysFilter();
}, 500));

$('#gps-search').keyup(debounce(function () {
    GPSFilter();
}, 500));

$('#gurgle-search').keyup(debounce(function () {
    GurgleFilter();
}, 500));

$('#new-contact-search').keyup(debounce(function () {
    ContactsFilter();
}, 500));


$('#u-contact-search').keyup(debounce(function(){
    NewContactsFilter();
}, 500));

$("#employee-Search").keyup(debounce(function(){
    EmployeeFilter();
},500));

$("#business-search").keyup(debounce(function(){
    businessFilter()
},500));

$('#new-message-search').keyup(debounce(function () {
   MessagesFilter();
}, 500));

$('#new-car-search').keyup(debounce(function () {
    CarsFilter();
}, 500));

$('#group-manage-search').keyup(debounce(function () {
    ManageFilter();
}, 500));

$("#yp_search").keyup(debounce(function(){
    YPFilter();
}, 500));

$('#racing-create-form').on('reset', function (e) {
    $.post('http://varial-newphone/racing:map:cancel', JSON.stringify({}));
});

$('#racing-start-tracks').on('change', function (e) {
    let selectedMap = $(this).val();
    if(maps[selectedMap] !== undefined) {
        $.post('http://varial-newphone/racing:map:removeBlips', JSON.stringify({}));
        $.post('http://varial-newphone/racing:map:load', JSON.stringify({ id: selectedMap}));
        $('#racing-start-map-creator').text(maps[selectedMap].creator);
        $('#racing-start-map-distance').text(maps[selectedMap].distance);
        $('#racing-start-description').text(maps[selectedMap].description);
    }
});

$('#racing-start').submit(function (e) {
    e.preventDefault();
    let reverseTrack = false;
    if ($('#racing-reverse-track').is(":checked")) { reverseTrack = true };
    $.post('http://varial-newphone/racing:event:start', JSON.stringify({
        raceMap: $('#racing-start-tracks').val(),
        raceLaps: $('#racing-start-laps').val(),
        raceStartTime: moment.utc().add($('#racing-start-time').val(), 'seconds'),
        reverseTrack: reverseTrack,
        raceCountdown: $('#racing-start-time').val(),
        raceName: $('#racing-start-name').val(),
        mapCreator: $('#racing-start-map-creator').text(),
        mapDistance: $('#racing-start-map-distance').text(),
        mapDescription: $('#racing-start-description').text()
    }));
});

$('#racing-create-form').submit(function (e) {
    e.preventDefault();
    $.post('http://varial-newphone/racing:map:save', JSON.stringify({
        name: escapeHtml($('#racing-create-name').val()),
        desc: escapeHtml($('#racing-create-description').val()),
    }));
});

$("#real-estate-sell-form").submit(function (e) {
    e.preventDefault();
    $.post('http://varial-newphone/btnAttemptHouseSale', JSON.stringify({
        cid: escapeHtml($("#real-estate-sell-form #real-estate-sell-id").val()),
        price: escapeHtml($("#real-estate-sell-form #real-estate-sell-amount").val()),
    }));

    $('#real-estate-sell-form').trigger('reset');
    $('#real-estate-sell-modal').modal('close');
});

$('#real-estate-transfer-form').submit(function (e) {
    e.preventDefault();
    $.post('http://varial-newphone/btnTransferHouse', JSON.stringify({
        cid: escapeHtml($("#real-estate-transfer-form #real-estate-transfer-id").val()),
    }));
    $('#real-estate-transfer-form').trigger('reset');
    $('#real-estate-transfer-modal').modal('close');
});

$("#group-manage-pay-form").submit(function (e) {
    e.preventDefault();

    let cashToPay = escapeHtml($("#group-manage-pay-form #group-manage-amount").val());
    $.post('http://varial-newphone/payGroup', JSON.stringify({
        gangid: escapeHtml($(".group-manage-company-name").data('group-id')),
        cid: escapeHtml($("#group-manage-pay-form #group-manage-id").val()),
        cashamount: cashToPay
    }));

    $('#group-manage-pay-form').trigger('reset');
    $('#group-manage-pay-modal').modal('close');
    let currentValue = $('.group-manage-company-bank').text();
    let newValue = parseInt(currentValue.substring(1, currentValue.length)) - parseInt(cashToPay);
    $('.group-manage-company-bank').text('$' + newValue);

});

$("#group-manage-rank-form").submit(function (e) {
    e.preventDefault();
    $.post('http://varial-newphone/promoteGroup', JSON.stringify({
        gangid: escapeHtml($(".group-manage-company-name").data('group-id')),
        cid: escapeHtml($("#group-manage-rank-form #group-manage-rank-id").val()),
        newrank: escapeHtml($("#group-manage-rank-form #group-manage-rank").val())
    }));
    $('#group-manage-rank-form').trigger('reset');
    $('#group-manage-rank-modal').modal('close');
});

$("#group-manage-bank-form").submit(function (e) {
    e.preventDefault();
    let cashToAdd = escapeHtml($("#group-manage-bank-form #group-manage-bank-amount").val());
    $.post('http://varial-newphone/bankGroup', JSON.stringify({
        gangid: escapeHtml($(".group-manage-company-name").data('group-id')),
        cashamount: cashToAdd,
    }));
    $('#group-manage-bank-form').trigger('reset');
    $('#group-manage-bank-modal').modal('close');
    let currentValue = $('.group-manage-company-bank').text();
    let newValue = parseInt(currentValue.substring(1, currentValue.length)) + parseInt(cashToAdd);
    $('.group-manage-company-bank').text('$' + newValue);
});

$("#group-tasks-assign-modal-form").submit(function (e) {
    e.preventDefault();

    $.post('http://varial-newphone/btnGiveTaskToPlayer', JSON.stringify({
        taskid: escapeHtml($("#group-tasks-assign-modal-form #group-task-id").val()),
        targetid: escapeHtml($("#group-tasks-assign-modal-form #group-task-target").val()),
    }));

    $("#group-tasks-assign-modal-form").trigger('reset')
    $('#group-tasks-assign-modal').modal('close');
});



$("#contacts-submit").click(function (e) {
    e.preventDefault();
    var escapedName = escapeHtml($("#contacts-form #contacts-new-name").val());
    var clean = escapedName;

    $.post('http://varial-newphone/newContactSubmit', JSON.stringify({
        name: clean,
        number: escapeHtml($("#contacts-form #contacts-new-number").val())
    }));

    if (currentContainer === "message") {
        $(".message-recipient").empty();
        $(".message-recipient").append(clean);
    }

    $('#contacts-form').trigger('reset');
    $('#contacts-add-new').modal('close');
})

$("#contacts-edit-submit").click(function (e) {
    e.preventDefault();
    // console.log("THSI IS CONTACT EDIT",$("#contacts-edit-form #old-name").val())
    var escapedName = escapeHtml($("#contacts-edit-form #contacts-edit-name").val());
    var clean = escapedName;

    $.post('http://varial-newphone/editContactSubmit', JSON.stringify({
        name: clean,
        number: escapeHtml($("#contacts-edit-form #contacts-edit-number").val()),
        oldName: escapeHtml($("#contacts-edit-form #old-name").val())
        
    }));

    if (currentContainer === "message") {
        $(".message-recipient").empty();
        $(".message-recipient").append(clean);
    }
    setTimeout(() => {
        $.post('http://varial-newphone/refreshContacts', JSON.stringify({}));
    }, 2000);
    
    $('#contacts-edit-form').trigger('reset');
    $('#contacts-edit').modal('close');
});


$("#wallpaper-form").submit(function (e) {
    e.preventDefault();
    var escapedName = $("#wallpaper-form #wallpaper-teste").val();

    $.post('http://varial-newphone/updateMyWallpaper', JSON.stringify({
        name: escapedName,
    }));

    if (currentContainer === "message") {
        $(".message-recipient").empty();
        $(".message-recipient").append(clean);
    }

    $('#wallpaper-form').trigger('reset');
    $('#mudar-wallpaper').modal('close');
});

$("#stock-form").submit(function (event) {
    event.preventDefault();
    $.post('https://varial-newphone/stocksTradeToPlayer', JSON.stringify({
        identifier: escapeHtml($("#stock-form #stock-id").val()),
        playerid: escapeHtml($("#stock-form #stock-target-id").val()),
        amount: escapeHtml($("#stock-form #stock-amount").val()),
    }));
    $("#stock-form").trigger("reset");
    $('#stock-modal').modal('close');
});

$("#stock-buy-form").submit(function (event) {
    event.preventDefault();
    $.post('https://varial-newphone/exchangeCrypto', JSON.stringify({
        identifier: escapeHtml($("#stock-buy-form #stock-id").val()),
        playerid: escapeHtml($("#stock-buy-form #stock-target-id").val()),
        amount: escapeHtml($("#stock-buy-form #stock-buy-amount").val()),
    }));
    $("#stock-buy-form").trigger("reset");
    $('#stock-buy-modal').modal('close');
});

// $("#twat-form").submit(function (event) {
//     event.preventDefault();
//     $.post('http://varial-newphone/newTwatSubmit', JSON.stringify({
//         twat: $("#twat-form #twat-body").val(),
//         time: moment.utc()
//     }));
//     $("#twat-form").trigger("reset");
//     $('#twat-modal').modal('close');
// });

$("#twat-submit-input").click(function (event){

    $(".send-twat-form").hide()
    if ($('.twat-message').val() == '') {

    } else {
        event.preventDefault();
        // console.log("TJIOS SUBMIT")
        complateInputJustGreen();
        var msg = escapeHtml($(".send-twat-form .twat-message").val())
        var attach = $(".send-twat-form .twat-attach").val()
        $.post('http://varial-newphone/newTwatSubmit', JSON.stringify({
            twat: { text: msg, attachment: attach },
            time: moment.utc()
        }));
        // setTimeout(() => {
        //     $("#twat-message-container").val("")
        //     $("#twat-attach").val("")
        // }, 2000);
        $('#twat-lenght').text('0/255');
    }
});

$(".submit-bg").click(function (event){
    if ($('#bg-set-body').val() == '') {

    } else {
        event.preventDefault();
        complateInputJustGreen();
        var bg = $("#bg-set-form #bg-set-body").val()
        $.post('http://varial-newphone/submitBg', JSON.stringify({
            bg: bg
        }));
    
        $("#bg-set-form").trigger("reset");
        $('#bg-set-modal').modal('close');
        $('#twat-lenght').text('0/255');
        $('#twat-modal').modal('close');
    }
});

function complateInputJustGreen() {
    // $('#twat-modal').modal('open');
    $("#twat-modal").each(function (i) {
        this.style.display = "none";
    });
    $('.complate-marks').css("display", "flex");
    $('.component-checkmark').css("display", "flex");
    setTimeout(function () {
        $('.complate-marks').css("display", "none");
        $('.component-checkmark').css("display", "none");
    }, 1900)
}

function complateInput(app) {
    // $('#twat-modal').modal('open');
    $("#twat-modal").each(function (i) {
        this.style.display = "none";
    });
    $('.complate-marks').css("display", "flex");
    $('.spinner-wrapper').css("display", "flex");
    setTimeout(function () {
        $('.spinner-wrapper').css("display", "none");
        $('.component-checkmark').css("display", "flex");
        setTimeout(function () {
            $('.complate-marks').css("display", "none");
            $('.component-checkmark').css("display", "none");
        }, 1700)
    }, 2700)
}

$("#call-form").submit(function (event) {
    event.preventDefault();
    $.post('http://varial-newphone/callContact', JSON.stringify({
        name: '',
        number: escapeHtml($("#call-form #call-number").val())
    }));
    $("#call-form").trigger("reset");
    $('#call-modal').modal('close');
});

// $("#call-submit").submit(function (event) {
$("#calls-form").on('click', '#call-submit', function () {
    let numbers = escapeHtml($("#calls-form #calls-number").val())
    if(numbers === ""){

    }else{
        $.post('http://varial-newphone/callContact', JSON.stringify({
            name: '',
            number: numbers
        }));
    };
    $("#calls-number").val("");
    $('#calls-someone').modal('close');
    $("#calls-someone").trigger("reset");
});

$("#yp-submit-input").click(function (event) {
    event.preventDefault();
    let yp = escapeHtml($("#yellow-pages-form #yellow-pages-body").val())
    if (Number(yp.length) <= Number(5)){ 
        $('#text-yp').text("Character must be more than 5")
        $('#text-yp').css('display', 'flex')
        setTimeout(() => {
            $('#text-yp').css('display', 'none')
        }, 2000);
        return false
     }else{
        complateInputJustGreen();
        $.post('http://varial-newphone/newPostSubmit', JSON.stringify({
            advert: yp
        }));
        $("#yellow-pages-form #yellow-pages-body").attr("style", "").val('')
        $('#yellow-pages-modal').modal('close');
    }
   
});

// $("#yellow-pages-form").submit(function (event) {
//     event.preventDefault();
//     $.post('http://varial-newphone/newPostSubmit', JSON.stringify({
//         advert: escapeHtml($("#yellow-pages-form #yellow-pages-body").val())
//     }));
//     $("#yellow-pages-form #yellow-pages-body").attr("style", "").val('')
//     $('#yellow-pages-modal').modal('close');
// });

$("#new-message-form").submit(function (event) {
    event.preventDefault();
    // console.log("SUBMIT MESSAGE HERE TOO")
    $.post('http://varial-newphone/newMessageSubmit', JSON.stringify({
        number: escapeHtml($("#new-message-form #new-message-number").val()),
        message: escapeHtml($("#new-message-form #new-message-body").val())
    }));

    $('#new-message-form').trigger('reset');
    M.textareaAutoResize($('#new-message-body'));
    $('#messages-send-modal').modal('close');
    switch (currentContainer) {
        case "message":
            setTimeout(function () {
                let sender = $('.message-entries').data("sender");
                let receiver = $('.message-entries').data("clientNumber")
                let displayName = $('.message-entries').data("displayName")
                $.post('http://varial-newphone/messageRead', JSON.stringify({ sender: sender, receiver: receiver, displayName: displayName }));
            }, 300);
            break;
        case "messages":
            setTimeout(function () {
                $.post('http://varial-newphone/messages', JSON.stringify({}));
            }, 300);
            break;
    }
    //M.toast({ html: 'Message Sent!' });
});


$('.inboxMessages').on('click', '.msg-image', function () {
        var bg = $(this).css('background-image');
        let url = $(this).attr("img-url")
        bg = /^url\((['"]?)(.*)\1\)$/.exec(bg);
        // console.log("BG INBOX",url,bg)
        $(".viewImage").attr("src", url);
        $(".viewImage").show();         
        copyToClipboard(bg);
});

$(".inboxMessages").mouseout('.msg-image',function () {
    $(".viewImage").hide();
    $("#viewImage").hide();
});

function copyToClipboard(text) {
    var sampleTextarea = document.createElement("textarea");
    document.body.appendChild(sampleTextarea);
    sampleTextarea.value = text; //save main text in it
    sampleTextarea.select(); //select textarea contenrs
    document.execCommand("copy");
    document.body.removeChild(sampleTextarea);
}

$("#back-msg").click(function (event){
    openContainer("messages");    
});

$(document).on('keypress', function (event){
    let msg = $("#sendmessage").val();
    
        if (event.which === 13) {

            if (msg == "") {

            } else {
                event.preventDefault();
                $.post('http://varial-newphone/newMessageSubmit', JSON.stringify({
                    number: escapeHtml($('.inboxMessages').data('receiver')),
                    message: $("#sendmessage").val()
                }));
                complateInputJustGreen();
                $('#twat-modal').modal('close');
                $('#sendmessage').trigger('reset');
                $("#sendmessage").val("")
                switch (currentContainer) {
                    case "message":
                        setTimeout(function () {
                            let sender = $('.inboxMessages').data("sender");
                            let receiver = $('.inboxMessages').data("clientNumber")
                            let displayName = $('.inboxMessages').data("displayName")
                            $.post('http://varial-newphone/messageRead', JSON.stringify({ sender: sender, receiver: receiver, displayName: displayName }));
                        }, 1000);
                        break;
                    case "messages":
                        setTimeout(function () {
                            $.post('http://varial-newphone/messages', JSON.stringify({}));
                        }, 300);
                        break;
                    }
        }
    }
});

//sendmessage
// $(document).on('keypress', function (e) {
//     let msg = $("#sendmessage").val();
   
//     let clientNumber = $(".message-number").html()
//     // let sender = $("#mynumber").html()
//     let sender = $(".message-sender").html()
//     let name = $(".message-name").html()
//     console.log("sending message","receiver:"+clientNumber,"my number:"+sender,name)
//     // document.getElementById( 'messages' ).scrollIntoView();
   
//     if (e.which === 13) {

//         if (msg == "") {

//         } else {
//             e.preventDefault();
//             complateInputJustGreen();
//             $('#twat-modal').modal('close');
//             $.post('http://varial-newphone/newMessageSubmit', JSON.stringify({
//                 number: clientNumber,
//                 reciever: sender,
//                 msg: msg
//             }));
            
//             $("#sendmessage").val("")

//             setTimeout(function () {
//                 $.post('http://varial-newphone/messageRead', JSON.stringify({
//                     receiver: clientNumber,
//                     sender: sender,
//                     displayName: name
//                 }));
//             }, 300);

//         }
//     }
// });


// TODO: Add delete map
/*
$('.racing-map-delete').click(function () {  
    let mapname = $('#racing-map-selected option:selected').text()
    $("#confirm-delete-button").text("Confirm Delete: " + mapname);
    if ( $('.racing-delete-confirm').is(":visible") ) {
        $('.racing-delete-confirm').fadeOut(150)
    } else {
        $('.racing-delete-confirm').fadeIn(150)
    }
});
$('.racing-map-delete-confirm').click(function () {  
    let raceMap = $('#racing-map-selected').val()
    $.post('http://varial-newphone/racing:map:delete', JSON.stringify({ id: raceMap }));
    $('.racing-delete-confirm').fadeOut(150)
    $('.racing-map-creation').fadeOut(150)
    $('#racing-information').fadeOut(150)
    $('.racing-map-options').fadeOut(150)
});*/
//

$('#real-estate-evict-modal-accept').click(function () {
    $.post('http://varial-newphone/btnEvictHouse', JSON.stringify({}));
    $('#real-estate-evict-modal-').modal('close');
});

$('.btn-racing-clear').click(function() {
    $.post('http://varial-newphone/racing:map:removeBlips', JSON.stringify({}));
});

$('.racing-create').click(function () {
    openContainer('racing-create');
});



$('.keys-toggle-filter').click(function () {
    let filterData = $(this).data('filter');

    if ($(this).hasClass("grey-text")) {
        if (!keyFilters.includes(filterData))
            keyFilters.push(filterData);
    }
    else
        keyFilters = keyFilters.filter(filter => filter !== filterData);

    KeysFilter();
    $(this).toggleClass("grey-text white-text");
});

$('.gps-toggle-filter').click(function () {
    let filterData = $(this).data('filter');

    if ($(this).hasClass("grey-text")) {
        if (!gpsFilters.includes(filterData))
            gpsFilters.push(filterData);
    }
    else
        gpsFilters = gpsFilters.filter(filter => filter !== filterData);

    GPSFilter();
    $(this).toggleClass("grey-text white-text");
});

$('.message-send-new').click(function () {
    
    $('#messages-send-modal').modal('open');
    let sender = $('.inboxMessages').data("sender");
    $('#messages-send-modal #new-message-number').val(sender);
    M.updateTextFields();
});


$('.messages-call-contact').click(function () {
    $.post('http://varial-newphone/callContact', JSON.stringify({
        name: $('.inboxMessages').data('displayName'),
        number: $('.inboxMessages').data('sender')
    }));
});

$('.messages-add-new-contact').click(function () {
    $('#contacts-add-new').modal('open');
    $('#contacts-add-new #contacts-new-number').val($('.inboxMessages').data('receiver'));
    M.updateTextFields();
});

$('.twatter-toggle-notification').click(function () {
    icon = $(this).find("i");
    icon.toggleClass("fa-bell fa-bell-slash")
    $.post('http://varial-newphone/btnNotifyToggle', JSON.stringify({}));
});



$('.account-information-toggle-pager').click(function () {
    $.post('http://varial-newphone/btnPagerToggle', JSON.stringify({}));
    $(this).toggleClass("red-text green-text");
});




$('.change-theme').click(function () { 
    openContainer("cores"); 
});
function clickImage(img) {
    $('.selfieBox').click(function(){
        copyToClipboard(img);
        $.post('http://varial-newphone/closeSelfieBox', JSON.stringify({}));
    });
}


$('.racing-entries').on('click', '.racing-entries-entrants', function () {
    $('#racing-entrants-modal').modal('open');
    $('.racing-entrants').empty();
    $('#racing-info-description').text();
    let currentRace = races[$(this).data('id')]
    $('#racing-info-description').text(currentRace.mapDescription);
    if(currentRace.racers !== undefined)
        currentRace.racers = Object.values(currentRace.racers).sort((a,b) => a.total - b.total); 
    for (let id in currentRace.racers) {
        let racer = currentRace.racers[id];
        let racerElement = `
            <li>
                <div class="collapsible-header">Titanium#${racer.server_id}</div>
                <div class="collapsible-body">
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-shipping-fast fa-2x icon "></i>
                        </div>  
                        <div class="col s9">
                            <strong>Fastest Lap</strong>
                            <br>${moment(racer.fastest).format("mm:ss.SSS")}
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s3 right-align">
                            <i class="fas fa-stopwatch fa-2x icon"></i>
                        </div>  
                        <div class="col s9">
                            <strong>Total</strong>
                            <br>${moment(racer.total).format("mm:ss.SSS")}
                        </div>
                    </div>
                </div>
            </li>
        `
        $('.racing-entrants').append(racerElement);
    }
});

$('.racing-entries').on('click', '.racing-entries-join', function () {
    $.post('http://varial-newphone/racing:event:join', JSON.stringify({ identifier: $(this).data('id') }));
});

$('.keys-entries').on('click', '.manage-keys', function () {
    $.post('http://varial-newphone/retrieveHouseKeys', JSON.stringify({}));
});

$('.keys-entries').on('click', '.remove-shared-key', function(e) {
    $.post('http://varial-newphone/removeSharedKey', JSON.stringify({
        house_id: $(this).data('house-id'),
        house_model: $(this).data('house-model')
    }))
    $(this).closest('li').remove()
});

$('.manage-keys-entries').on('click', '.manage-keys-remove', function () {
    $.post('http://varial-newphone/removeHouseKey', JSON.stringify({
        targetId: $(this).data('target-id')
    }))
    $.post('http://varial-newphone/retrieveHouseKeys', JSON.stringify({}));
})

$('.yellow-pages-entries').on('click', '.yellow-pages-call', function () {
    $.post('http://varial-newphone/callContact', JSON.stringify({
        name: '',
        number: $(this).data('number')
    }));
});

$('.twatter-entries').on('click', '.twat-reply', function () {
    $(".send-twat-form").show()
    $('.send-twat-form #twat-message-container').val($(this).data('poster') + " ").trigger('change');
    M.updateTextFields();
    $(this).toggleClass('colorretwet')
    $(this).parent().find('.bubble').toggleClass('bubbleclick');
});

$('.twat-iconn').click(function(){
    // console.log("TWAT SEND")
    $('#twat-attach').val("")
    $('#twat-message-container').val("")
    $(".send-twat-form").show()
});

$('.twatter-entries').on('click', '.twat-retweet', function () {
    $(".send-twat-form").show()
    $('#twat-message-container').val($(this).data('poster') + " " +$(this).data('rt')).trigger('change');
    $('.send-twat-form #twat-attach').text($(this).data('photo'));
});

$('.twatter-entries').on('click', '.heart', function () {
    $(this).toggleClass('clicked')
    $(this).parent().find('.bubble').toggleClass('bubbleclick');
  });


$('.twatter-entries').on('click', '.twat-like', function () {
    $(".likehover").css("display" , "none")
    $(".superlikehover").css("display" , "flex")
});

$('.calls-container').on('click', '.btn-call-history-add-contact', function () {
    $('#contacts-add-new').modal('open');
    $('#contacts-add-new #contacts-new-number').val($(this).data('number'));
    M.updateTextFields();
});

$('.calls-container').on('click', '#call-someone', function () {
    $('#calls-someone').modal('open');
});

$('.group-manage-entries').on('click', '.group-manage-pay', function () {
    $('#group-manage-pay-modal').modal('open');
    $('#group-manage-pay-modal #group-manage-id').val($(this).data('id')).prop('disabled', true);
    M.updateTextFields();
});

$('.group-manage-entries').on('click', '.group-manage-rank', function () {
    $('#group-manage-rank-modal').modal('open');
    $('#group-manage-rank-modal #group-manage-rank-id').val($(this).data('id')).prop('disabled', true);
    $('#group-manage-rank-modal #group-manage-rank').val($(this).data('rank'));
    M.updateTextFields();
});

$('.group-manage-entries').on('click', '.group-manage-fire', function () {
    // $('#group-manage-rank-modal #group-manage-fire-id').val($(this).data('id')).prop('disabled', true);
    $.post('http://varial-newphone/varial-newphone:fireEmp', JSON.stringify({ id: $(this).data('id'), group: $(this).data('group'), name: $(this).data('name') }));
});

$('.group-tasks-entries').on('click', '.group-tasks-track', function () {
    $.post('http://varial-newphone/trackTaskLocation', JSON.stringify({ TaskIdentifier: $(this).data('id') }));
});

$('.delivery-job-entries').on('click', '.delivery-job-accept', function (e) {
    $.post('http://varial-newphone/selectedJob', JSON.stringify({ jobType: $(this).data('job-type'), jobId: $(this).data('job-id') }));
});

$('.crypto-container').on('click', '.stocks-buy', function (e) {
    $('#stock-modal').modal('open');
    $('#stock-modal #stock-id').val($(this).data('stock-id'));
    M.updateTextFields();
})

$('.crypto-container').on('click', '.stocks-exchange', function (e) {
    $('#stock-buy-modal').modal('open');
    $('#stock-buy-modal #stock-id').val($(this).data('stock-id'));
    M.updateTextFields();
})

$('.garage-entries').on('click', '.garage-spawn', function (e) {
    e.preventDefault();
    $.post('http://varial-newphone/vehspawn', JSON.stringify({ vehplate: $(this).data('plate') }));
    $.post('http://varial-newphone/btnGarage', JSON.stringify({}));
});

$('.garage-entries').on('click', '.garage-track', function () {
    $.post('http://varial-newphone/vehtrack', JSON.stringify({ vehplate: $(this).data('plate') }));
});

$('.garage-entries').on('click', '.garage-pay', function (e) {
    $.post('http://varial-newphone/vehiclePay', JSON.stringify({ vehiclePlate: $(this).data('plate') }));
    setTimeout(function () {
        $.post('http://varial-newphone/btnGarage', JSON.stringify({}));
    }, 1500);
});

$('.gps-entries, .keys-entries').on('click', '.gps-location-click', function () {
    $.post('http://varial-newphone/loadUserGPS', JSON.stringify({ house_id: $(this).data('house-id'), house_type: $(this).data('house-type') }));
})

$('.jss1481, .calls-container').on('click', '.btn-contacts-call', function () {
    $.post('http://varial-newphone/callContact', JSON.stringify({ name: $(this).data('name'), number: $(this).data('number') }));
});

$('.calls-container').on('click', '.btn-contacts-call', function () {
    $.post('http://varial-newphone/callContact', JSON.stringify({ name: $(this).data('name'), number: $(this).data('number') }));
});
$('.jss1481, .calls-container').on('click', '.btn-contacts-send-message', function (event) {
    $('#messages-send-modal').modal('open');
    $('#messages-send-modal #new-message-number').val($(this).data('number'));
    M.updateTextFields();
});

$('.jss1481, calls-container').on('click', '.btn-contacts-edit', function(events){
    // $('#messages-send-modal').modal('open');
    // $('#messages-send-modal #new-message-number').val($(this).data('number'));
    $('#contacts-edit').modal('open');
    $('#contacts-edit #old-name').val($(this).data('name'));
    $('#contacts-edit #contacts-edit-name').val($(this).data('name'));
    $('#contacts-edit #contacts-edit-number').val($(this).data('number'));
    M.updateTextFields();
});

$('.jss1481, calls-entries').on('click', '.btn-contacts-send-message', function (event) {
    $('#messages-send-modal').modal('open');
    $('#messages-send-modal #new-message-number').val($(this).data('number'));
    M.updateTextFields();
});

///old button
// $('.contacts-entries, calls-entries, .message-container').on('click', '.btn-contacts-send-message', function (event) {
//     console.log("OPEN HERE")
//     $('#contacts-send-modal').modal('open');
//     $('#contacts-send-modal #new-message-number').val($(this).data('number'));
//     M.updateTextFields();
// });

// $('.contacts-entries, .message-container').on('click', '#messages-send-modal', function (event) {
//     console.log("SEND MESSAGE")
//     $('#contacts-send-modal').modal('open');
//     $('#contacts-send-modal #new-message-number').val($(this).data('number'));
//     M.updateTextFields();
// });

$('.calls-entries, contacts-entries, .call-history-entries').on('click', '.btn-calls-send-message', function (event) {
    $('#contacts-send-modal').modal('open');
    $('#contacts-send-modal #new-message-number').val($(this).data('number'));
    M.updateTextFields();
    
});

$('.contacts-send-modal').on('click', '#message-submit', function(){
    // console.log("THIS IS SUBMIT",$(".contacts-send-modal #new-message-number").val(),$(".contacts-send-modal #new-message-body").val())
    // $.post('http://varial-newphone/newMessageSubmit', JSON.stringify({
    //     number: escapeHtml($(".contacts-send-modal #new-message-number").val()),
    //     message: $(".contacts-send-modal #new-message-body").val()
    // }));
    M.updateTextFields();
    $('#contacts-send-modal').modal('close');
});

$('.callshistory-send-modal').on('click', '#message-submit-callhistory', function(){
    // console.log("THIS IS SUBMIT",$(".callshistory-send-modal #new-message-number").val(),$(".callshistory-send-modal #new-message-body").val())
    $.post('http://varial-newphone/newMessageSubmit', JSON.stringify({
        number: escapeHtml($(".callshistory-send-modal #new-message-number").val()),
        message: $(".callshistory-send-modal #new-message-body").val()
    }));
    M.updateTextFields();
    $('#callshistory-send-modal').modal('close');
});

$('.group-tasks-entries').on('click', '.btn-group-tasks-assign', function () {
    $('#group-tasks-assign-modal').modal('open');
    $('#group-tasks-assign-modal #group-task-id').val($(this).data('id'));
    M.updateTextFields();
});
//deleting contact
$('.jss1481').on('click', '.btn-contacts-remove', function () {
    $('#confirm-modal-accept').data('name', $(this).data('name'));
    $('#confirm-modal-accept').data('number', $(this).data('number'));
    $('#confirm-modal').modal('open');
    $('#confirm-modal-question').text(`Are you sure you want to delete the contact from ${$(this).data('name')}?`);
});

$('#confirm-modal-accept').click(function (event) {
    $.post('http://varial-newphone/removeContact', JSON.stringify({ name: $(this).data('name'), number: $(this).data('number') }));
    $('#confirm-modal').modal('close');
});

$('#deleteting-yp').click(function (event) {
  $.post('http://varial-newphone/deleteYP', JSON.stringify({ name: $(this).data('name'), number: $(this).data('number') }));
});

$('.dial-button').click(function (e) {
    if ($('#call-number').val().length < 10)
        $('#call-number').val(parseInt($('#call-number').val().toString() + $(this).text()));
    M.updateTextFields();
});


$('.settings-submit').click(function (e) {
    updateSettings();
});

$('.settings-reset').click(function (e) {
    ResetSettings();
});

function openContainer(containerName, fadeInTime = 500, ...args) {
    closeContainer(currentContainer, (currentContainer !== containerName ? 300 : 0));
    $("." + containerName + "-container").hide().fadeIn((currentContainer !== containerName ? fadeInTime : 0));
    if (containerName === "home") {
        $(".phone-screen .rounded-square:not('.hidden-buttons')").each(function () {
            $(this).fadeIn(1000);
        });
        $(".navigation-menu").fadeTo("slow", 0.5, null);
    }
    else
        $(".navigation-menu").fadeTo("slow", 1, null);

    if (containerName === "racing")
        clearInterval(racingStartsTimer);

    if (containerName === "message")
        $('.message-entries-wrapper').animate({
            scrollTop: $('.message-entries-wrapper')[0].scrollHeight
        }, 0);

    if (args[0] === undefined) {
        oldContainerHistory.push(currentContainer);
    }
    currentContainer = containerName;
}

function closeContainer(containerName, fadeOutTime = 500) {
    $.when($("." + containerName + "-container").fadeOut(fadeOutTime).hide()).then(function () {
        if (containerName === "home")
            $(".phone-screen .rounded-square").each(function () {
                $(this).fadeIn(300);
            });
    });
}
//HOUSING
$("#hb-1").click(function () {
    $("#house-1").show();
    $("#house-2").hide();
    $('#h-current').css('display', 'none');
    $('#house-check').css('display', 'none');
    $('#apartment_room_number_hs-2').css('display', 'none');
    $('.h-owned').css('display', 'none');
    $('.house-entries').css('display', 'none');
    $('.access').css('display', 'none');
    $(".jss2907").css("left", (0));
    $("#hb-1").css("color", "#95ef77");
    $("#hb-2").css("color", "rgba(255, 255, 255, 0.7)");
});


$("#hb-2").click(function () {
    $("#house-1").hide();
    $("#house-2").show();
    $(".btn-2").show();
    $(".btn-2-house").show();
    $('#house-check').css('display', 'block');
    $('#apartment_room_number_hs-2').css('display', 'block');
    $('.house-entries').css('display', 'block');
    $('.access').css('display', 'block');
    if (isRealEstateAgent === true){    
        $("#sell-h").css('display', 'flex');
    }else{
        $("#sell-h").css('display', 'none');
    }
    $(".edit-h").show();
    $(".edit-h").css('display', 'flex');
    $(".edit-h").css('display', 'flex');
    $('.h-current').css('display', 'block');
    $(".jss2907").css("left", ("50%"));
    $("#hb-2").css("color", "#95ef77");
    $("#hb-1").css("color", "rgba(255, 255, 255, 0.7)");
});

function noPropty() {
    $('.h-no').css('display', 'flex');
    $('.h-no-close').click(function () {
        $('.h-no').css('display', 'none');
    })
}

function foundPropty() {
    $('.h-found').css('display', 'flex');
    $('.h-found-close').click(function () {
        $('.h-found').css('display', 'none');
    })
}

function sellOwnPropty(hid) {
    $("#h-p-id").val(hid)
    $('.sell-house-own').css('display', 'flex');
    $('.sell-house-close').click(function () {
        $('.sell-house-own').css('display', 'none');
    })
}

function editPropertyPrice() {
    // $('.h-found').css('display', 'flex');
    // $('.h-found-close').click(function () {
    //     $('.h-found').css('display', 'none');
    // })
    $('.housing-edit-price').show()
}

$("#h-check").click(function () {
    // console.log("CHECK PROPERTY")
    $.post('http://varial-newphone/checkHouse', JSON.stringify({}))
})

$("#edit-h").click(function () {
    // console.log("CHECK PROPERTY")
    // $.post('http://varial-newphone/editHouse', JSON.stringify({}))
    noPropty()
})

$("#sell-h").click(function () {
    // console.log("CHECK PROPERTY")
    $.post('http://varial-newphone/sellsHouse', JSON.stringify({}))
})

$('.h-found').on('click', '.h-found-purchase', function (event) {
    // console.log("PROPERTY PURCHASE",$('.property-name').text(),$('#property-price').val(),$('#h-p-id').val())
    event.preventDefault();
    $('.h-found').css('display', 'none');
    
    setTimeout(function () {
        complateInputJustGreen();
        $('#twat-modal').modal('close');
    }, 100)
   
    $.post('http://varial-newphone/purchaseHouse', JSON.stringify({
        name: $('.property-name').text(),
        price: $('#property-price').val(),
        hid: $('#h-p-id').val()
    }))
})

//confirm-sellHouse
$('.sell-house-own').on('click', '.confirm-sellHouse', function (event) {
    // console.log("PRoperty Sell",$('#h-p-id').val())
    event.preventDefault();
    $('.sell-house-own').css('display', 'none');
    
    setTimeout(function () {
        complateInputJustGreen();
        $('#twat-modal').modal('close');
    }, 100)
   
    $.post('http://varial-newphone/sellOwnHouse', JSON.stringify({
        hid: $('#h-p-id').val()
    }))
})

$('#close-h-price').click(function(){
    $('.housing-edit-price').css('display', 'none');
})
$('#submit-h-price').click(function(){
    let hid = $('#h-hid').val()
    let price = $('#h-price').val()
    // console.log(price,hid)
    $.post('http://varial-newphone/editHousePrice', JSON.stringify({
        hid: hid,
        price: price
    }))
    $('.housing-edit-price').css('display', 'none');
})
// $(document).ready(function () {
//     function noPropty() {
//         $('.h-no').css('display', 'flex');
//         $('.h-no-close').click(function () {
//             $('.h-no').css('display', 'none');
//         })
//     }
//     $('.h-check').click(function () {
//         noPropty();
//     });
//     $('.h-edit').click(function () {
//         noPropty();
//     });
//     $('.upgrade-button').click(function () {
//         $('.h-upgrade').css('display', 'flex');
//         $('#close-h-sure').click(function () {
//             $('.h-upgrade').css('display', 'none');
//         });
//         $('#confirm-h-sure').click(function () {
//             complateInput();
//             setTimeout(function () {
//                 $('.h-upgrade').css('display', 'none');
//             }, 3700)
//         });
//     })
// })

$(".component-paper").mouseover(function () {
    overid = $(this).attr("hoverid")
    $(".actions[hoverid=" + overid + "]").css("display", "flex");
}).mouseout(function () {
    $(".actions").css("display", "none");
});
$(".component-paper").mouseover(function () {
    overid = $(this).attr("camerahover")
    $(".actions[camerahover=" + overid + "]").css("display", "flex");
}).mouseout(function () {
    $(".actions").css("display", "none");
});

function phoneCallerScreenSetup() {
    switch (callStates[currentCallState]) {
        case "isNotInCall":
            if (currentContainer === "incoming-call") {
                currentCallState = 0;
                currentCallInfo = "";
                openContainer("home");
                $('.top-notifications-chamadas').h();
            }
            break;
        case "isDialing":
            $('.top-notifications-chamadas').show();
            $('#notificaçaoapp-titel').text(currentCallInfo);
            break;
        case "isReceivingCall":
            $('.top-notifications-chamadas').show();
            $('#notificaçaoapp-titel').text(currentCallInfo);
            break;
        case "isCallInProgress":
            $('.top-notifications-chamadas').show();
            $('#notificaçaoapp-titel').text(currentCallInfo);
            break;
        }
    }

function openPhoneShell() {
    
    $(".phone-screen").removeClass("closephone").addClass('openphone').show().css("bottom" , "32px").add($('.jss13')).fadeIn(500);
    $(".jss13").removeClass("closephone").addClass('openphone').show().css("bottom" , "12px").add($('.jss13')).fadeIn(200);
   
}

function closePhoneShell() {
    if(callStates[currentCallState] == "isCallInProgress" || callStates[currentCallState] == "isDialing" || callStates[currentCallState] == "isReceivingCall" || callStates[currentCallState] == "isCallInProgress" && activePing === true || hasNotif === true){
        openContainer('home');
        currentContainer = "home"
        $('.jss1154').css('display', 'none');
        $('.message-icon').css('display', 'none');
        $('.message-name').css('display', 'none');
        $('.message-number').css('display', 'none');
        $('.message-sender').css('display', 'none');
        $('.icon-immsage').css('display','none');
        $('#deleteting-yp').css('display','none');
        $('.yp-newpost').css('display','none');
        $('.twat-iconn').css('display','none');
        $(".jss13").removeClass("slideout").addClass('slidein').show().css("bottom" , "-540px").add($('.jss13')).fadeIn();
        $(".phone-screen").removeClass("slideout").addClass('slidein').show().css("bottom" , "-530px").add($('.phone-screen')).fadeIn();
        // $(".phone-app").removeClass("slideout").addClass('slidein').show().css("bottom" , "-540px").add($('.phone-screen')).fadeIn();
        $('.h-found').css('display', 'none');
        $('.h-no').css('display', 'none');
        $('#contacts-container').css('display',"none")
        // return
    }
    if (callStates[currentCallState] == "isNotInCall"){
        // $('.jss1154').css('display', 'none');
        // $(".jss13").removeClass("openphone").addClass("closephone").css("bottom" , "1000px").fadeIn(500);
        // $(".phone-screen").removeClass("openphone").addClass("closephone").css("bottom" , "1000px").fadeIn(500);
        openContainer('home');
        currentContainer = "home"
        $(".jss13").animate({ bottom: "-1000px" }, 450)
        $(".phone-screen").animate({ bottom: "-1000px" }, 450)
        $('.message-icon').css('display', 'none');
        $('.message-name').css('display', 'none');
        $('.message-number').css('display', 'none');
        $('.message-sender').css('display', 'none');
        $('.icon-immsage').css('display','none');
        $('#deleteting-yp').css('display','none');
        $('.yp-newpost').css('display','none');
        $('.twat-iconn').css('display','none');
        $(".send-twat-form").hide();
        $('#twat-modal').modal('close');
        $(".selfieImage").hide();
        $.post('https://varial-newphone/refreshMySMS', JSON.stringify({status: false}));
        $.post('http://varial-newphone/closeTwat')
        $('#twat-modal').modal('close');
        $('#contacts-container').css('display',"none")
        $('#contact-show').css('display','none');
    }
    $('#contacts-container').css('display',"none")
}


var entityMap = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    "'": '&#39;',
    '/': '&#x2F;',
    '`': '&#x60;',
    '=': '&#x3D;'
};

function escapeHtml(string) {
    return String(string).replace(/[&<>"'`=\/]/g, function (s) {
        return entityMap[s];
    });
}

function makeTimer(targetTime) {
    var endTime = new Date(targetTime);
    endTime = (Date.parse(endTime) / 1000);

    var now = new Date();
    now = (Date.parse(now) / 1000);

    var timeLeft = endTime - now;

    var days = Math.floor(timeLeft / 86400);
    var hours = Math.floor((timeLeft - (days * 86400)) / 3600);
    var minutes = Math.floor((timeLeft - (days * 86400) - (hours * 3600)) / 60);
    var seconds = Math.floor((timeLeft - (days * 86400) - (hours * 3600) - (minutes * 60)));

    if (hours < "10") { hours = "0" + hours; }
    if (minutes < "10") { minutes = "0" + minutes; }
    if (seconds < "10") { seconds = "0" + seconds; }

    return {
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds
    }
}


function httpGetAsync(theUrl, callback)
{
    // create the request object
    var xmlHttp = new XMLHttpRequest();

    // set the state change callback to capture when the response comes in
    xmlHttp.onreadystatechange = function()
    {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
        {
            callback(xmlHttp.responseText);
        }
    }

    // open as a GET call, pass in the url and set async = True
    xmlHttp.open("GET", theUrl, true);

    // call send with no params as they were passed in on the url string
    xmlHttp.send(null);

    return;
}
$(document).on('click','img',function(){
   var url = $(this).attr("data-url")
   event.preventDefault();
   if(url === undefined) {
       return
   }
   var matchd = url.match("https")
   if(matchd != null) {
       url = `<image width="100%" height="100%" src='${url}'>`
   }
   $.post('http://varial-newphone/newTwatSubmit', JSON.stringify({
       twat: url,
       time: moment.utc()
   }));
   $("#twat-form").trigger("reset");
   $('#twat-modal').modal('close');
})

function tenorCallback_search(responsetext)
{
    var response_objects = JSON.parse(responsetext);
    top_10_gifs = response_objects["results"];
    var i;
    for (i = 0; i < top_10_gifs.length; i++) {
        $('#gifsplace').append(`<button id="gifsss" type="button" style="background-color:transperent;border:none;outline:none;"><img class="gifs" data-url="${top_10_gifs[i]["media"][0]["nanogif"]["url"]}" src="${top_10_gifs[i]["media"][0]["nanogif"]["url"]}" alt="" style="width:220px;height:164px;"></button>`)
    }
    return;
}


function grab_data(searc)
{
    var apikey = "QO693EHK2Q8S";
    var lmt = 8;
    var search_term = searc;
    var search_url = "https://g.tenor.com/v1/search?q=" + search_term + "&key=" +
    apikey + "&limit=" + lmt;
    httpGetAsync(search_url,tenorCallback_search);
    return;
}

var opengif = false;
$("#twat-opengif").click(function(){
    if(opengif == false) {
        opengif = true
        $("#giflol").fadeIn()
    } else if(opengif == true) {
        opengif = false
        $("#giflol").fadeOut()
    }
})

$("#twat-gifword").change(function() {
    $("#gifsplace").empty()
    grab_data($(this).val());
});


   $(document).on('click', '#twat-sendimg', function (e) {
       
    $.post('http://varial-newphone/phone:selfie', JSON.stringify({}));
    e.preventDefault();
    $.post('http://varial-newphone/PostNewImage', JSON.stringify({}),
        function (url) {
            $('#tweet-new-url').val(url)
            event.preventDefault();
            if(url === undefined) {
                return
            }
            var matchd = url.match("https")
            if(matchd != null) {
                
                url = `<div class="userupimage">
                <img
                src='${url}'
                  alt="img"
                  class="givenimage"
                />
              </div>`

            }
            
            $.post('http://varial-newphone/newTwatSubmit', JSON.stringify({
                twat: url,
                time: moment.utc()
            }));
            $("#twat-form").trigger("reset");
            $('#twat-modal').modal('close');
            $.post('http://varial-newphone/phone:selfie', JSON.stringify({}));
          
        },
    );
    
});


// function closeOtherContainer(){
//     $(".top-notifications-wrapper").empty()
// }

function addWingzNotify(item,app,data,handle,time,sdId){
// console.log("IS PHONE OPEN?",pPhoneOpen,app,data,handle,time)
// console.log(data.twat['text'],JSON.stringify(data))
// console.log("WTF IS THIS",data, JSON.stringify(data))
const Args = currentContainer
const Time = time
const Id = getRandomIntInclusive(1, 10000000) 
const savedId = sdId
let twtImg = ""
let handler = ""
let apps = ""
let icon = ""
let color = ""
let message = ""
var answerPhone = false;
var activePing = false;
if(app === "twat"){
    // apps = "twatter"

    handler = truncateString(handle,18)
    icon = "twatters"
    color = "#35baf8"
    message = truncateString(data.twat['text'],30)
    twtImg = data.twat['attachment']
}else if(app === "sms"){
    // apps = "msg"
    // console.log("YEP THIS IS SMS")
    // console.log("NOTIFY",data,handle,app)
    handler = handle
    icon = "conversations"
    color = "#38832e"
    message = truncateString(data,30)
}else if(app === "email"){
    // apps = "msg"
    // console.log("YEP THIS IS SMS")
    // console.log("NOTIFY",data,handle,app)
    handler = handle
    icon = "email"
    color = "#38832e"
    message = truncateString(data,30)
    
}else if(app === "rcall"){
    handler = handle
    //<i class="fa-solid fa-square-phone-flip"></i>
    currentCallState = 2
    icon = "calls"
    color = "#aed581"
    message = `Incoming Call <a class="  phone-button btnAnswer" aria-label="Answer" id="call-answer" data-action="btnAnswer" style="color: #aed581; left: 128px;"><i class="fas fa-check-circle" style="font-size: 1rem"></i></a><a class="phone-button" aria-label="Hang Up" id="call-reject" style="color: orange;left: 128px;">&nbsp;
    <i class="fas fa-times-circle" style="font-size: 1rem"></i></a>`
}else if(app === "icall"){
    // isca
    currentCallState = 1
    handler = handle
    icon = "calls-flip"
    color = "#aed581"
    message = `Dialing.. <a class=" phone-button" aria-label="Hang Up" id="call-reject" style="color: orange;margin-left: 180px;"><i class="fas fa-times-circle" style="font-size: 1rem"></i></a>`
}else if(app === "ping"){
    // countdown()
    activePing = true
    handler = handle
    //<i class="fa-solid fa-square-phone-flip"></i>
    icon = "erpinger"
    color = "#055dc2"
    message = `${data}<a class="  phone-button btnAnswer" aria-label="Accept" id="ping-accept" style="color: #aed581; left: 116px;"><i class="fas fa-check-circle" style="font-size: 1rem"></i></a><a class="  phone-button btnHangup" aria-label="Reject" id="ping-reject" style="color: orange; left: 125px;"><i class="fas fa-times-circle" style="font-size: 1rem"></i></a>`
}
if(pPhoneOpen === false){
    // $('.yellow-pages-iconmove').css('display', 'none')
    $('.twat-iconn').css('display', 'none')
    $(".jss13").removeClass("slideout").addClass('slidein').show().css("bottom" , "-540px").add($('.jss13')).fadeIn();
    $(".phone-screen").removeClass("slideout").addClass('slidein').show().css("bottom" , "-530px").add($('.phone-screen')).fadeIn();
    $(".phone-app").removeClass("slideout").addClass('slidein').show().css("bottom" , "-540px").add($('.phone-screen')).fadeIn();
}

var count = 0

$.each(
    $(".notification-container"), function(i,d) {
        count = count + 1
})
globalNotify = count
// console.log("COUNT ", count)
document.getElementById("topNotify").style.zIndex = "900";
// if (count == 0){
    let notifContent = ``
    if (app === "icall" || app === "rcall" || app === "incall"){
        notifContent = `<div class="notification-container" data-id="${Id}-call" data-savedid="${savedId}"><div class="app-bar">
        <div class="icon">
            <img src="images/${icon}.png" style="border-radius: 5px; width: 20px; height: 20px;" width="5px" height="5px">
        </div>
        <div class="text name" style="margin-left:25px; height: 13px; margin-bottom: 3px;">${handler}</div>
        <p style="left:-50px; margin-bottom: 3px;" id="xtime">just now</p></div>
        <div class="content">
        ${message}
        </div>
    </div>
</div>`
    }else if (app === "ping"){
        notifContent = `<div class="notification-container" data-id="${Id}-ping" data-savedid="${savedId}"><div class="app-bar">
        <div class="icon">
            <img src="images/${icon}.png" style="border-radius: 5px; width: 20px; height: 20px;" width="5px" height="5px">
        </div>
        <div class="text name" style="margin-left:25px; height: 13px; margin-bottom: 3px;">${handler}</div>
        <p style="left:-50px; margin-bottom: 3px;" id="xtime">just now</p></div>
        <div class="content">
        ${message}
        </div>
    </div>
</div>`
    }else{
        notifContent = `<div class="notification-container" data-id="${Id}-n" data-savedid="${savedId}"><div class="app-bar">
        <div class="icon">
            <img src="images/${icon}.png" style="border-radius: 5px; width: 20px; height: 20px;" width="5px" height="5px">
        </div>
        <div class="text name" style="margin-left:25px; height: 13px; margin-bottom: 3px;">${handler}</div>
        <p style="left:-50px; margin-bottom: 3px;" id="xtime">just now</p></div>
        <div class="content">
        ${message}
        </div>
    </div>
</div>`
    }
   
$('.top-notifications-wrapper').append(notifContent).fadeIn();
// }
let timeElm = document.getElementById('xtime');
let x = 0
let timers = function(x) {
 if(x === 0) {
    return;
 }
 if (x < 10) {
    suffix = ':0';
} else {
    suffix = ':'
};
 timeElm.innerHTML = '00'+suffix+x;

 return setTimeout(() => {
     timers(--x)
}, 1000)
} 
if (app === "icall" || app === "rcall" || app === "incall"){
    document.getElementById("topNotify").style.zIndex = "900";
    const Notif = $(".notification-container").filter(`[data-id="${Id}-call"]`)
    globalNotify = globalNotify+1
    if (Notif) {
        var count = 0
        $.each($(".notification-container"), function(i, d) { count =	count + 1 })
        if (count <= 1) {
        }
        setTimeout(() => {
            var count = 0
            $.each($(".notification-container"), function(i, d) { count =	count + 1 })
            if (count == 0) {
                if(pPhoneOpen === false) {
                            $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
                            $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
                            $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
                            $(".phone-app").css("bottom" , "10px")
                            $(".top-notifications-wrapper").empty()
                        }
            }
            // document.getElementById("topNotify").style.zIndex = "-1";
        }, 599)
    }
    ///answering call
    $(document).ready(function () {

        $(".notification-container").on('click', '#call-answer', function () {
            callAccept = true
            if (app === "icall" || app === "rcall"){
                $.post('http://varial-newphone/btnAnswer', JSON.stringify({}));
            }
        });
        $(".notification-container").on('click', '#call-reject', function () {
            callAccept = false
            stopTimer();
            if (app === "icall" || app === "rcall"){
               stopTimer();
                const Notif = $(".notification-container").filter(`[data-id="${Id}-call"]`)
                if (Notif) {
                    var count = 0
                    $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                    if (count <= 1) {
                        $(".content").empty()
                        setTimeout(() => {
                            $(".content").append(`Disconnected`)
                            setTimeout(() => {
                                Notif.addClass('notification-container-fade-out')
                                $.post('http://varial-newphone/btnHangup', JSON.stringify({}));
                            }, 1000)
                        }, 200)
                    }

                    setTimeout(() => {
                        Notif.remove()
                        var count = 0
                        $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                        if (count == 0) {
                            if(pPhoneOpen === false) {
                                        $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
                                        $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
                                        $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
                                        $(".phone-app").css("bottom" , "10px")
                                        $(".top-notifications-wrapper").empty()
                                    }
                        }
                    }, 599)
                }
            }
        });
    })
}else if (app === "ping"){
    document.getElementById("topNotify").style.zIndex = "900";
    timers(15)
    setTimeout(() => {
        const Notif = $(".notification-container").filter(`[data-id="${Id}-ping"]`)
        activePing = true
        if (Notif) {
            var count = 0
            $.each($(".notification-container"), function(i, d) { count =	count + 1 })
            if (count <= 1) {
            }
            Notif.addClass('notification-container-fade-out')
            $.post('http://varial-newphone/pingEnded', JSON.stringify({}));
            setTimeout(() => {
                Notif.remove()
                var count = 0
                $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                if (count == 0) {
                    if(pPhoneOpen === false) {
                                $(".jss13").removeClass("slidein").addClass("slideout").fadeOut()
                                $(".phone-screen").removeClass("slidein").addClass("slideout").fadeOut()
                                $(".phone-app").removeClass("slidein").addClass("slideout").fadeOut()
                                $(".phone-app").css("bottom" , "10px")
                                $(".top-notifications-wrapper").empty()
                                activePing = false
                            }
                }
            }, 599)
        }
    }, 15000)
    $(document).ready(function () {

        //ping accept
        $(".notification-container").on('click', '#ping-accept', function () {
            $.post('http://varial-newphone/varial-ui:pingAccept', JSON.stringify({}));
            const Notif = $(".notification-container").filter(`[data-id="${Id}-ping"]`)
                if (Notif) {
                    var count = 0
                    $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                    if (count <= 1) {
                        Notif.addClass('notification-container-fade-out')
                        setTimeout(() => {
                         document.getElementById("topNotify").style.zIndex = "-1";
                        }, 200)
                    }
                }
        })

        //ping reject
        $(".notification-container").on('click', '#ping-reject', function () {
            activePing = false
            $.post('http://varial-newphone/varial-ui:pingReject', JSON.stringify({}));
            const Notif = $(".notification-container").filter(`[data-id="${Id}-ping"]`)
                if (Notif) {
                    var count = 0
                    Notif.remove()
                    $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                    if (count <= 1) {
                        Notif.addClass('notification-container-fade-out')
                        setTimeout(() => {
                            document.getElementById("topNotify").style.zIndex = "-1";
                           }, 200)
                    }
                }
        })
    })

}else if(app !== "call"){
    var count = 0;
    let  timerStart = 0;
    $.each($('.notification-container'), function (i, d) {
        count = count + 1;
        if (count > 1 ) {
            timerStart = timerStart + (Time-2000)
            return
        }
        timerStart = timerStart + Time
    });
    if (count == 0) {
        const Notif = $(".notification-container").filter(`[data-id="${Id}-n"]`)
        Notif.addClass('notification-container-fade-out')
        timerStart = 0
    }else{
        hasNotif = true
    }
    if (Time) {
        const Notif = $('.notification-container').filter(`[data-id="${Id}-n"]`);
        if (Notif) {

        }
        setTimeout(() => {
            var countNot = 0;
            $.each($('.notification-container'), function (i, d) {
                countNot = countNot + 1;
                hasNotif = true
                
            });
            if (count < 1) {
                Notif.addClass('notification-container-fade-out');
                setTimeout(() => {
                    $('#topNotify').css('display', 'none');
                }, countNot*500)
                timerStart = 0
                hasNotif = false
            }
            setTimeout(() => {
                
                Notif.addClass('notification-container-fade-out');
                var count = 0;
                timerStart = 0
                $.each($('.notification-container'), function (i, d) {
                    count = count + 1;
                });
                if (count >= 0) {
                    timerStart = 0
                    if(pPhoneOpen === false) {
                        closePhoneShell()
                        document.getElementById("topNotify").style.zIndex = "-1";
                        $(".top-notifications-wrapper").empty()
                        pPhoneOpen = false
                        Notif.remove();
                    }
                }else{
                   
                }
            }, timerStart);
        }, Number(timerStart));
    }
    //Removing Notification if not call
    $(document).ready(function () {

        $(".notification-container").click(function () {
            const Notif = $(".notification-container").filter(`[data-id="${Id}-n"]`)
            if (Notif) {
                $.each($(".notification-container"), function(i, d) { count =	count + 1 })
                Notif.addClass('notification-container-fade-out')
                setTimeout(() => {
                    if(callStates[currentCallState] !== "isCallInProgress" || callStates[currentCallState] !== "isReceivingCall" || callStates[currentCallState] !== "isDialing" && activePing !== true){
                        console.log("MAKE IT -1")
                        document.getElementById("topNotify").style.zIndex = "-1";
                        activePing = false
                        Notif.remove();
                    }
                }, 100)
                
            }
        });
    })
}   

}

function getRandomIntInclusive(min, max) {
min = Math.ceil(min);
max = Math.floor(max);
return Math.floor(Math.random() * (max - min + 1)) + min; //The maximum is inclusive and the minimum is inclusive 
}

const truncateString = (string, maxLength = 250) => {
if (!string) return null;
if (string.length <= maxLength) return string;
return `${string.substring(0, maxLength)}...`;
};

const truncateName = (string, maxLength = 250) => {
if (!string) return null;
if (string.length <= maxLength) return string;
return `${string.substring(0, maxLength)}...`;
};

function addOwnedHouse(item){
let element = `<div hoverid="${item.hid}" class="component-paper btn-2-house" style="width: 100%;">
<div class="main-container">
<div class="image">
    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="house-user"
        class="svg-inline--fa fa-house-user fa-w-18 fa-fw fa-3x " role="img"
        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
        <path fill="currentColor"
            d="M570.69,236.27,512,184.44V48a16,16,0,0,0-16-16H432a16,16,0,0,0-16,16V99.67L314.78,10.3C308.5,4.61,296.53,0,288,0s-20.46,4.61-26.74,10.3l-256,226A18.27,18.27,0,0,0,0,248.2a18.64,18.64,0,0,0,4.09,10.71L25.5,282.7a21.14,21.14,0,0,0,12,5.3,21.67,21.67,0,0,0,10.69-4.11l15.9-14V480a32,32,0,0,0,32,32H480a32,32,0,0,0,32-32V269.88l15.91,14A21.94,21.94,0,0,0,538.63,288a20.89,20.89,0,0,0,11.87-5.31l21.41-23.81A21.64,21.64,0,0,0,576,248.19,21,21,0,0,0,570.69,236.27ZM288,176a64,64,0,1,1-64,64A64,64,0,0,1,288,176ZM400,448H176a16,16,0,0,1-16-16,96,96,0,0,1,96-96h64a96,96,0,0,1,96,96A16,16,0,0,1,400,448Z">
        </path>
    </svg>
</div>
<div class="details">
    <div class="title ">
        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
        id = "" style="word-break: break-word;">${HousesInfo[item.hid].street}</p>
    </div>
    <div class="description ">
        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary ap-street"
            style="word-break: break-word;">${item.cat}</p>
    </div>
</div>
<div hoverid="${item.hid}" class="actions actions-show">
    <div title="Set GPS" houseId="${item.hid}" aria-label="Set GPS" class="h-setgps">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M288 0c-69.59 0-126 56.41-126 126 0 56.26 82.35 158.8 113.9 196.02 6.39 7.54 17.82 7.54 24.2 0C331.65 284.8 414 182.26 414 126 414 56.41 357.59 0 288 0zM20.12 215.95A32.006 32.006 0 0 0 0 245.66v250.32c0 11.32 11.43 19.06 21.94 14.86L160 448V214.92c-8.84-15.98-16.07-31.54-21.25-46.42L20.12 215.95zM288 359.67c-14.07 0-27.38-6.18-36.51-16.96-19.66-23.2-40.57-49.62-59.49-76.72v182l192 64V266c-18.92 27.09-39.82 53.52-59.49 76.72-9.13 10.77-22.44 16.95-36.51 16.95zm266.06-198.51L416 224v288l139.88-55.95A31.996 31.996 0 0 0 576 426.34V176.02c0-11.32-11.43-19.06-21.94-14.86z">
            </path>
        </svg>
    </div>`
    if (item.status === "Lock"){
        element +=`
        <div title="Unlock" houseId="${item.hid}" status="Unlock" aria-label="Unlock" class="h-unlock">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                <path fill="currentColor"
                d="M80 192V144C80 64.47 144.5 0 224 0C303.5 0 368 64.47 368 144V192H384C419.3 192 448 220.7 448 256V448C448 483.3 419.3 512 384 512H64C28.65 512 0 483.3 0 448V256C0 220.7 28.65 192 64 192H80zM144 192H304V144C304 99.82 268.2 64 224 64C179.8 64 144 99.82 144 144V192z">
                </path>
            </svg>
        </div>`
    }else{
        element +=`<div title="Lock" houseId="${item.hid}" status="Lock" aria-label="Lock" class="h-unlock">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M352 192H384C419.3 192 448 220.7 448 256V448C448 483.3 419.3 512 384 512H64C28.65 512 0 483.3 0 448V256C0 220.7 28.65 192 64 192H288V144C288 64.47 352.5 0 432 0C511.5 0 576 64.47 576 144V192C576 209.7 561.7 224 544 224C526.3 224 512 209.7 512 192V144C512 99.82 476.2 64 432 64C387.8 64 352 99.82 352 144V192z">
            </path>
        </svg>
    </div>`
    }
    element +=`
    <div title="Edit" houseId="${item.hid}" aria-label="Edit" class="h-edit-s">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M490.3 40.4C512.2 62.27 512.2 97.73 490.3 119.6L460.3 149.7L362.3 51.72L392.4 21.66C414.3-.2135 449.7-.2135 471.6 21.66L490.3 40.4zM172.4 241.7L339.7 74.34L437.7 172.3L270.3 339.6C264.2 345.8 256.7 350.4 248.4 353.2L159.6 382.8C150.1 385.6 141.5 383.4 135 376.1C128.6 370.5 126.4 361 129.2 352.4L158.8 263.6C161.6 255.3 166.2 247.8 172.4 241.7V241.7zM192 63.1C209.7 63.1 224 78.33 224 95.1C224 113.7 209.7 127.1 192 127.1H96C78.33 127.1 64 142.3 64 159.1V416C64 433.7 78.33 448 96 448H352C369.7 448 384 433.7 384 416V319.1C384 302.3 398.3 287.1 416 287.1C433.7 287.1 448 302.3 448 319.1V416C448 469 405 512 352 512H96C42.98 512 0 469 0 416V159.1C0 106.1 42.98 63.1 96 63.1H192z">
            </path>
        </svg>
    </div>
   
    <div title="Sell" houseId="${item.hid}" aria-label="Sell" class="h-sell-h">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M160 0C177.7 0 192 14.33 192 32V67.68C193.6 67.89 195.1 68.12 196.7 68.35C207.3 69.93 238.9 75.02 251.9 78.31C268.1 82.65 279.4 100.1 275 117.2C270.7 134.3 253.3 144.7 236.1 140.4C226.8 137.1 198.5 133.3 187.3 131.7C155.2 126.9 127.7 129.3 108.8 136.5C90.52 143.5 82.93 153.4 80.92 164.5C78.98 175.2 80.45 181.3 82.21 185.1C84.1 189.1 87.79 193.6 95.14 198.5C111.4 209.2 136.2 216.4 168.4 225.1L171.2 225.9C199.6 233.6 234.4 243.1 260.2 260.2C274.3 269.6 287.6 282.3 295.8 299.9C304.1 317.7 305.9 337.7 302.1 358.1C295.1 397 268.1 422.4 236.4 435.6C222.8 441.2 207.8 444.8 192 446.6V480C192 497.7 177.7 512 160 512C142.3 512 128 497.7 128 480V445.1C127.6 445.1 127.1 444.1 126.7 444.9L126.5 444.9C102.2 441.1 62.07 430.6 35 418.6C18.85 411.4 11.58 392.5 18.76 376.3C25.94 360.2 44.85 352.9 60.1 360.1C81.9 369.4 116.3 378.5 136.2 381.6C168.2 386.4 194.5 383.6 212.3 376.4C229.2 369.5 236.9 359.5 239.1 347.5C241 336.8 239.6 330.7 237.8 326.9C235.9 322.9 232.2 318.4 224.9 313.5C208.6 302.8 183.8 295.6 151.6 286.9L148.8 286.1C120.4 278.4 85.58 268.9 59.76 251.8C45.65 242.4 32.43 229.7 24.22 212.1C15.89 194.3 14.08 174.3 17.95 153C25.03 114.1 53.05 89.29 85.96 76.73C98.98 71.76 113.1 68.49 128 66.73V32C128 14.33 142.3 0 160 0V0z">
            </path>
        </svg>
    </div>
    <div title="Keys" houseId="${item.hid}" h-street="${HousesInfo[item.hid].street}" aria-label="Keys" class="h-access-h">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M282.3 343.7L248.1 376.1C244.5 381.5 238.4 384 232 384H192V424C192 437.3 181.3 448 168 448H128V488C128 501.3 117.3 512 104 512H24C10.75 512 0 501.3 0 488V408C0 401.6 2.529 395.5 7.029 391L168.3 229.7C162.9 212.8 160 194.7 160 176C160 78.8 238.8 0 336 0C433.2 0 512 78.8 512 176C512 273.2 433.2 352 336 352C317.3 352 299.2 349.1 282.3 343.7zM376 176C398.1 176 416 158.1 416 136C416 113.9 398.1 96 376 96C353.9 96 336 113.9 336 136C336 158.1 353.9 176 376 176z">
            </path>
        </svg>
    </div>
    <div title="Access" houseId="${item.hid}" aria-label="Access" class="h-access-keys">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
            class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6H511.8L512.5 447.7C512.6 483.2 483.9 512 448.5 512H128.1C92.75 512 64.09 483.3 64.09 448V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5H575.8zM288 160C252.7 160 224 188.7 224 224C224 259.3 252.7 288 288 288C323.3 288 352 259.3 352 224C352 188.7 323.3 160 288 160zM256 320C211.8 320 176 355.8 176 400C176 408.8 183.2 416 192 416H384C392.8 416 400 408.8 400 400C400 355.8 364.2 320 320 320H256z">
            </path>
        </svg>
    </div>
</div>
</div>
</div>`
    $('.house-entries').append(element)
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("hoverid")
        $(".actions[hoverid=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none");
    });
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("camerahover")
        $(".actions[camerahover=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none");
    });

     
}

///HOUSING SHIT HERE
$(".house-entries, .access-house-entries").on('click', '.h-setgps', function (e) {
    e.preventDefault();
    overid = $(this).attr("houseId")
    $.post('http://varial-newphone/sethGps', JSON.stringify({hid: overid}));
})

$(".house-entries, .access-house-entries").on('click', '.h-unlock', function (e) {
    e.preventDefault();
    overid = $(this).attr("houseId")
    hstatus = $(this).attr("status")
    $.post('http://varial-newphone/unlockHouses', JSON.stringify({hid: overid, status: hstatus}));
 })
 $(".house-entries").on('click', '.h-edit-s', function (e) {
    $.post('http://varial-newphone/editHousingOwn', JSON.stringify({}));
 })
 $(".house-entries").on('click', '.h-sell-h', function (e) {
    e.preventDefault();
    overid = $(this).attr("houseId")
    sellOwnPropty(overid)
 })
 $(".house-entries").on('click', '.h-access-h', function (e) {
    e.preventDefault();
    overid = $(this).attr("houseId")
    street = $(this).attr("h-street")
    $("#house_street").val(street)
    $("#h-id").val(overid)
    // console.log("House Access")
    $('.phone-acces-house').show()
 })
 $(".house-entries").on('click', '.h-access-keys', function (e) {
    // console.log("House Accesses")
    e.preventDefault();
    overid = $(this).attr("houseId")
    $.post('http://varial-newphone/houseAccess', JSON.stringify({
        hid: overid
    }));
 })

 $('.close-h-acess').click(function(){
     $('.phone-acces-house').hide()
 })

 $('.submit-h-acess').click(function(){
    let hid = $("#h-id").val()
    let cid = $("#h-access-cid").val()
    complateInputJustGreen();
    setTimeout(() => {
        $('#h-access-cid').val("")
    }, 200);

    $('.phone-acces-house').hide()
    $.post('http://varial-newphone/giveAccess', JSON.stringify({
        hid: hid,
        cid: cid
    }));
})



window.onload = function(){
	var option = document.getElementById('option-main');
    document.onclick = function(e){
        if(e.target.id !== 'phone-item' || e.target.id != 'phone-item' || e.target.id === 'option-main'){
            option.style.display = 'none';
        }
    };
};

function addAccessHouse(item){
    // console.log("ALL ACCESS NUI", item.house)
    let element = `<div hoverid="a-${item.house}" class="component-paper btn-2-house" style="width: 100%;">
    <div class="main-container">
    <div class="image">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="house-user"
            class="svg-inline--fa fa-house-user fa-w-18 fa-fw fa-3x " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
                d="M570.69,236.27,512,184.44V48a16,16,0,0,0-16-16H432a16,16,0,0,0-16,16V99.67L314.78,10.3C308.5,4.61,296.53,0,288,0s-20.46,4.61-26.74,10.3l-256,226A18.27,18.27,0,0,0,0,248.2a18.64,18.64,0,0,0,4.09,10.71L25.5,282.7a21.14,21.14,0,0,0,12,5.3,21.67,21.67,0,0,0,10.69-4.11l15.9-14V480a32,32,0,0,0,32,32H480a32,32,0,0,0,32-32V269.88l15.91,14A21.94,21.94,0,0,0,538.63,288a20.89,20.89,0,0,0,11.87-5.31l21.41-23.81A21.64,21.64,0,0,0,576,248.19,21,21,0,0,0,570.69,236.27ZM288,176a64,64,0,1,1-64,64A64,64,0,0,1,288,176ZM400,448H176a16,16,0,0,1-16-16,96,96,0,0,1,96-96h64a96,96,0,0,1,96,96A16,16,0,0,1,400,448Z">
            </path>
        </svg>
    </div>
    <div class="details">
        <div class="title ">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
            id = "" style="word-break: break-word;">${HousesInfo[item.house].street}</p>
        </div>
        <div class="description ">
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary ap-street"
                style="word-break: break-word;">${item.cat}</p>
        </div>
    </div>
    <div hoverid="a-${item.house}" class="actions actions-show">
        <div title="Set GPS" houseId="${item.house}" aria-label="Set GPS" class="h-setgps">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                <path fill="currentColor"
                d="M288 0c-69.59 0-126 56.41-126 126 0 56.26 82.35 158.8 113.9 196.02 6.39 7.54 17.82 7.54 24.2 0C331.65 284.8 414 182.26 414 126 414 56.41 357.59 0 288 0zM20.12 215.95A32.006 32.006 0 0 0 0 245.66v250.32c0 11.32 11.43 19.06 21.94 14.86L160 448V214.92c-8.84-15.98-16.07-31.54-21.25-46.42L20.12 215.95zM288 359.67c-14.07 0-27.38-6.18-36.51-16.96-19.66-23.2-40.57-49.62-59.49-76.72v182l192 64V266c-18.92 27.09-39.82 53.52-59.49 76.72-9.13 10.77-22.44 16.95-36.51 16.95zm266.06-198.51L416 224v288l139.88-55.95A31.996 31.996 0 0 0 576 426.34V176.02c0-11.32-11.43-19.06-21.94-14.86z">
                </path>
            </svg>
        </div>`
        if (item.status === "Lock"){
            element +=`
            <div title="Unlock" houseId="${item.house}" status="Unlock" aria-label="Unlock" class="h-unlock">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                    class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                    xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                    <path fill="currentColor"
                    d="M80 192V144C80 64.47 144.5 0 224 0C303.5 0 368 64.47 368 144V192H384C419.3 192 448 220.7 448 256V448C448 483.3 419.3 512 384 512H64C28.65 512 0 483.3 0 448V256C0 220.7 28.65 192 64 192H80zM144 192H304V144C304 99.82 268.2 64 224 64C179.8 64 144 99.82 144 144V192z">
                    </path>
                </svg>
            </div>`
        }else{
            element +=`<div title="Lock" houseId="${item.house}" status="Lock" aria-label="Lock" class="h-unlock">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                <path fill="currentColor"
                d="M352 192H384C419.3 192 448 220.7 448 256V448C448 483.3 419.3 512 384 512H64C28.65 512 0 483.3 0 448V256C0 220.7 28.65 192 64 192H288V144C288 64.47 352.5 0 432 0C511.5 0 576 64.47 576 144V192C576 209.7 561.7 224 544 224C526.3 224 512 209.7 512 192V144C512 99.82 476.2 64 432 64C387.8 64 352 99.82 352 144V192z">
                </path>
            </svg>
        </div>`
        }
        element +=`
    </div>
    </div>
    </div>`
        $('.access-house-entries').append(element)
        $(".component-paper").mouseover(function () {
            overid = $(this).attr("hoverid")
            $(".actions[hoverid=" + overid + "]").css("display", "flex");
        }).mouseout(function () {
            $(".actions").css("display", "none");
        });
        $(".component-paper").mouseover(function () {
            overid = $(this).attr("camerahover")
            $(".actions[camerahover=" + overid + "]").css("display", "flex");
        }).mouseout(function () {
            $(".actions").css("display", "none");
        });
        // $(".h-setgps").click(function(e){
           
        //  })
         
    }


    $(document).ready(function () {
        // console.log(globalNotify)
    })


    window.addEventListener('click' , (e) => {
        var option = document.getElementById('option-main');
        const target = e.target.className; 
        var check = $(".phone-item").css('display')
        if (target === "option-main" && check == "block"){
            option.style.display = 'none';
        }
    })
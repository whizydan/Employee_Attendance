/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */
var doc = document.getElementById("notification");
if(doc){
    playSound();
}

function playSound(){
    var audio = new Audio('assets/js/notification.mp3');
    audio.play();
};

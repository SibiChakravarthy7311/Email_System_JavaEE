const successNotification = document.querySelector(".successNotification");
const warningNotification = document.querySelector(".warningNotification");
const warningNotificationDelete = document.querySelector(".warningNotificationDelete");
const shareInbox = document.querySelector('.share-inbox');
const popup = document.querySelector('.popup');

function openCompose(){
    popup.style.display = 'flex';
}

function closeCompose(){
    popup.style.display = 'none';
}

function openShareInbox(){
    shareInbox.style.display = 'flex';
}

function closeShareInbox(){
    shareInbox.style.display = 'none';
}

function closeSuccessNotification() {
    successNotification.style.display = "none";
}

function closeWarningNotification() {
    warningNotification.style.display = "none";
}

function closeWarningNotificationDelete(){
    warningNotificationDelete.style.display = "none";
}

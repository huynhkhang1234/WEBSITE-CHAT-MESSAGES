
var username = null;
var websocket = null;
var receiver = null;
var userAvatar = null;
var receiverAvatar = null;

var groupName = null;
var groupId = null

var back = null;
var rightSide = null;
var leftSide = null;
var conversation = null;

var attachFile = null;
var imageFile = null;
var file = null;
var listFile = [];
var typeFile = "image";
var deleteAttach = null;
var typeChat = "user";
var listUserAdd = [];
var listUserDelete = [];
var numberMember = 0;
window.onload = function() {
	if ("WebSocket" in window) {
		username = document.getElementById("username").textContent;
		userAvatar = document.getElementById("userAvatar").textContent;
		console.log(username);
		console.log(userAvatar);
		websocket = new WebSocket('ws://' + window.location.host + '/chat-web-app/chat/' + username);

		websocket.onopen = function() {
		};

		websocket.onmessage = function(data) {
			setMessage(JSON.parse(data.data));
		};

		websocket.onerror = function() {
			console.log('Có lỗi xảy ra khi kết nối');
			cleanUp();
		};

		websocket.onclose = function(data) {
			console.log(data.reason);
			cleanUp();
		};
	} else {
		console.log("Websockets không được hổ trợ.");
	}
}

window.onclick = function(e) {
	let modals = document.querySelectorAll(".modal-box");
	let toggleBtns = document.querySelectorAll(".toggle-btn");
	let count = 0;

	modals.forEach(function(modal) {
		if (modal.contains(e.target)) count++;
	});

	toggleBtns.forEach(function(toggleBtn) {
		if (toggleBtn.contains(e.target)) count++;
	});

	//if (count !== 1) toggleAllModal();
}


function cleanUp() {
	username = null;
	websocket = null;
	receiver = null;
}
// clicl vào hiện thị thông tin nhắn tin bên phải.
function setReceiver(element) {

	groupId = null;
	receiver = element.id;
	//hiện thị icon người dùng trên header.
	receiverAvatar = document.getElementById('img-' + receiver).src;
	var status = '';
	if (document.getElementById('status-' + receiver).classList.contains('online')) {
		status = 'online';
	}



	var rightSide = '<div class="user-contact">' + '<div class="back">'
		+ '<i class="fa fa-arrow-left"></i>'
		+ '</div>'
		+ '<div class="user-contain">'
		+ '<div class="user-img">'
		+ '<img src="' + receiverAvatar + '" '
		+ 'alt="Image of user">'
		+ '<div class="user-img-dot ' + status + '"></div>'
		+ '</div>'
		+ '<div class="user-info">'
		+ '<span class="user-name">' + receiver + '</span>'
		+ '</div>'
		+ '</div>'
		+ '<div class="setting">'
		+ '<i class="fa fa-cog"></i>'
		+ '</div>'
		+ '</div>'
		+ '<div class="list-messages-contain">'
		+ '<ul id="chat" class="list-messages">'
		+ '</ul>'
		+ '</div>'
		+ '<form class="form-send-message" onsubmit="return sendMessage(event)">'
		+ '<ul class="list-file"></ul> '
		+ ' <a class="btn btn-image" id="likeButton"> <i onclick="toggleLike()" class="fa fa-bell" aria-hidden="true"></i></a>'
		+ '<input type="text" id="message" class="txt-input" placeholder="Type message...">'
		+ '<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>'
		+ '<input type="file" multiple id="attach">'
		+ '<label class="btn btn-image" for="image"><i class="fa fa-file-image-o"></i></label>'
		+ '<input type="file" accept="image/*" multiple id="image">'
		+ '<button type="submit" class="btn btn-send">'
		+ '<i class="fa fa-paper-plane"></i>'
		+ '</button>'
		+ '</form>';

	document.getElementById("receiver").innerHTML = rightSide;

	loadMessages();

	displayFiles();

	makeFriend(rightSide);
}
//set thông tin người vào group.
function setGroup(element) {

	receiver = null;
	groupName = element.getAttribute("data-name");
	groupId = element.getAttribute("data-id");
	receiverAvatar = document.getElementById("img-group-" + groupId).src;
	listUserAdd = [];
	numberMember = parseInt(element.getAttribute("data-number"));
	//lấy dữu liệu tư api isactive
	fetch("http://" + window.location.host + "/chat-web-app/api/getGroupIsactive?conversationId=" + groupId)
		.then(response => response.json())
		.then(data2 => {

			console.log(data2);
			isActive = data2;


			fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?usersConversationId=" + groupId)
				.then(function(data) {
					return data.json();
				})
				.then(function(data) {
					console.log(isAdmin)
					if (isActive != null) {
						console.log(data2)
					}
					let actice = '';					
					if (isAdmin) {
						if (data2 == 1) {
						active = '<form class="form-send-message" onsubmit="return sendMessage(event)">' +
							'<ul class="list-file"></ul> ' +
							'<a class="btn btn-image" id="likeButton"> <i onclick="toggleLike(groupId)" class="fa fa-bell" aria-hidden="true"></i></a>' +
							'<input type="text" id="message" class="txt-input" placeholder="Type message...">' +
							'<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>' +
							'<input type="file" multiple id="attach">' +
							'<label class="btn btn-image" for="image"><i class="fa fa-file-image-o"></i></label>' +
							'<input type="file" accept="image/*" multiple id="image">' +
							'<button type="submit" class="btn btn-send">' +
							'<i class="fa fa-paper-plane"></i>' +
							'</button>' +
							'</form>';
							}else{
									active = '<form class="form-send-message" onsubmit="return sendMessage(event)">' +
							'<ul class="list-file"></ul> ' +
							'<a class="btn btn-image" id="likeButton"> <i onclick="toggleLike(groupId)" class="fa fa-bell-slash-o" aria-hidden="true"></i></a>' +
							'<input type="text" id="message" class="txt-input" placeholder="Type message...">' +
							'<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>' +
							'<input type="file" multiple id="attach">' +
							'<label class="btn btn-image" for="image"><i class="fa fa-file-image-o"></i></label>' +
							'<input type="file" accept="image/*" multiple id="image">' +
							'<button type="submit" class="btn btn-send">' +
							'<i class="fa fa-paper-plane"></i>' +
							'</button>' +
							'</form>';
							}
																			

					} else {
						if (data2 == 1) {
							active = '<form class="form-send-message" onsubmit="return sendMessage(event)">' +
								'<ul class="list-file"></ul> ' +							
								'<input type="text" id="message" class="txt-input" placeholder="Type message...">' +
								'<label class="btn btn-image" for="attach"><i class="fa fa-file"></i></label>' +
								'<input type="file" multiple id="attach">' +
								'<label class="btn btn-image" for="image"><i class="fa fa-file-image-o"></i></label>' +
								'<input type="file" accept="image/*" multiple id="image">' +
								'<button type="submit" class="btn btn-send">' +
								'<i class="fa fa-paper-plane"></i>' +
								'</button>' +
								'</form>';
						} else {
							active = '';							
						}

					}


					var rightSide = '<div class="user-contact">' + '<div class="back">'
						+ '<i class="fa fa-arrow-left"></i>'
						+ '</div>'
						+ '<div class="user-contain">'
						+ '<div class="user-img">'
						+ '<img id="img-group-' + groupId + '" src="' + receiverAvatar + '"'
						+ 'alt="Image of user">'
						+ '</div>'
						+ '<div class="user-info">'
						+ '<a href="http://' + window.location.host + '/chat-web-app/conversation?conversationId=' + groupId + '" class="user-name">' + groupName + '</a>'
						+ '</div>'
						+ '</div>'
						+ '<div class="invite-user">'
						+ '<span class="total-invite-user">' + numberMember + ' paticipants</span>'
						+ '<span data-id="add-user" onclick="toggleModal(this, true); searchMemberByKeyword(``);" class="invite toggle-btn">Mời</span>'
						+ '</div>'
						+ '<div class="setting toggle-btn" data-id="manage-user" onclick="toggleModal(this, true);  fetchUser();">'
						+ '<i class="fa fa-cog"></i>'
						+ '</div>'
						+ '</div>'
						+ '<div class="list-messages-contain">'
						+ '<ul id="chat" class="list-messages">'
						+ '</ul>'
						+ '</div>'
						+ active

					document.getElementById("receiver").innerHTML = rightSide;

					loadMessagesGroup();

					displayFiles();

					//handleResponsive();
				})
				.catch(ex => console.log(ex));
		})
		.catch(ex => console.log(ex));
}

function resetChat() {
	//lấy thẻ chứa icon và icon.
	let chatBtn = document.querySelectorAll(".tab-control i");
	//lấy thẻ chứa  class và cả  thẻ search.
	let searchTxt = document.querySelector("#conversations");
	let addGroupBtn = document.querySelector(".add-group");

	searchTxt.value = "";

	chatBtn.forEach(function(ele) {
		ele.classList.remove("active");
	});

	if (typeChat == "group") {
		addGroupBtn.classList.add("active");
	} else {
		addGroupBtn.classList.remove("active");
	}
}


function createGroup(e) {

	e.preventDefault();

	let groupName = document.querySelector(".txt-group-name").value;
	//tạo 2 object
	let object = new Object();
	let user = new Object();

	user.username = username;
	user.admin = true;
	//object name là tên group
	object.name = groupName;
	//những người được mời vào.
	object.users = [];
	//thêm người vào group.
	object.users.push(user);
	//thêm giao diện group.
	toggleAllModal();

	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller", {
		method: "post",
		cache: 'no-cache',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify(object)
	})
		.then(function(data) {
			return data.json();
		})
		.then(function(data) {


			//if (typeChat != "group") return;

			let findObject = data.users.find(element => element.username == username);
			let isAdmin = findObject.admin;
			console.log('â' + data.users)
			let numberMember = data.users.length;

			//	let imgSrc = ' src="http://' + window.location.host + '/files/group-' + data.id + '/' + data.avatar + '"';
			let imgSrc = 'src="/chat-web-app/static/images/anhNhom.jpg"';
			//let imgSrc = 'src="/chat-web-app/static/images/anh2.jpg"';
			let appendDelete = '';
			//console.log(isAdmin)
			if (isAdmin) {
				appendDelete = '<button style="width: 300px;background: rebeccapurple;color: #fff;"  data-id="' + data.id + '" onclick="deleteGroup(this)">Xóa</button>';
			} else {
				appendDelete = '';
			}

			let appendUser = '<span id="group-' + data.id + '" >' +
				'<a  data-id="' + data.id + '"  data-number="' + numberMember + '" data-name="' + data.name + '"  onclick="setGroup(this)"' +
				'class="filterDiscussions all unread single active" ' +
				'data-toggle="list" role="tab"> ' +
				'<img class="avatar-md" id="img-group-' + data.id + '"  ' +
				'src="http://localhost:8080/chat-web-app/static/images/anhNhom.jpg" ' +
				'data-toggle="tooltip" data-placement="top" title="Janette" ' +
				'alt="avatar"> ' +
				'<div class="status"> ' +
				'<i class="material-icons online">fiber_manual_record</i> ' +
				'</div> ' +
				'<div class="new bg-yellow"> ' +
				'<span>+7</span> ' +
				'</div> ' +
				'<div class="data-id"> ' +
				'<h5>' + data.name + '</h5> ' +
				'<p>Mới tạo nhóm</p> ' +
				'</div> ' +
				'</a>' + appendDelete
				+ '</span>';


			document.querySelector("#discussionsChats").innerHTML += appendUser;
			document.querySelector(".txt-group-name").value = "";
		});
}
//add người vào nhóm
function addMember(e) {
	e.preventDefault();
	//tạo id ,name,user
	let object = new Object();
	object.name = groupName;
	object.id = groupId;
	object.users = [];


	listUserAdd.forEach(function(username) {
		let user = new Object();
		//gán tên
		user.username = username;
		//gán người thêm vào nhóm với quyền user.
		user.admin = false;
		user.avatar = null;
		//thêm vào object.
		object.users.push(user);
	});


	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller", {
		method: "post",
		cache: 'no-cache',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify(object)
	})
		.then(function(data) {
			return data.json();
		})
		.then(function(data) {
			//hiện thị người có trong group củng như số lượng.
			numberMember += parseInt(listUserAdd.length);
			listUserAdd = [];
			let inviteNumber = document.querySelector(".total-invite-user");
			if (inviteNumber) inviteNumber.innerHTML = numberMember + " paticipants";
			//set vào
			document.getElementById("group-" + groupId).querySelector(".user-contain").setAttribute("data-number", numberMember);
			// thêm vào lạ group.			
		});
}
//tìm kiếm user và thông tin message add vào group lại
function fetchUser() {

	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?usersConversationId=" + groupId)
		.then(data => data.json())
		.then(users => {
			document.querySelector(".manage-member-body .list-user ul").innerHTML = "";

			//chi tiết group.
			//nếu user trong group ko có 
			if (users.length == 1) {
				document.querySelector(".manage-member-body .list-user ul").innerHTML = "Bạn là thành viên duy nhất";
				document.querySelector(".manage-member-body .list-user ul").style = "text-align: center; font-size: 1.8rem;";
			} else {
				document.querySelector(".manage-member-body .list-user ul").style = "";
			}
			//nếu có duyệt hiện thị.
			users.forEach(function(data) {
				if (data.username == username) return;

				let appendUser = '<li>'
					+ '<div class="user-contain">'
					+ '<div class="user-img">'
					+ '<img '
					+ ' src="http://' + window.location.host + '/files/' + data.username + '/' + data.avatar + '"'
					+ 'alt="Image of user">'
					+ '</div>'
					+ '<div class="user-info" style="flex-grow: 1;">'
					+ '<span class="user-name">' + data.username + '</span>'
					+ '</div>';
				//chỉ có admin mới có quyền xóa nhóm.

				if (!data.admin)
					appendUser += '<div class="user-delete" style="font-weight: 700;" data-username="' + data.username + '" onclick="deleteMember(this)">Delete</div>'

				appendUser += '</div></li>';

				document.querySelector(".manage-member-body .list-user ul").innerHTML += appendUser;
			});

		})
		.catch(ex => console.log(ex));

}

function deleteGroup(ele) {
	alert('Xóa nhóm thành công');
	document.getElementById('receiver').innerHTML = "";
	let grpId = ele.getAttribute('data-id');

	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?conversationId=" + grpId, {
		method: 'delete'
	})
		.then(function(data) {
			return data.json();
		})
		.then(function(data) {
			let groupNumber = document.getElementById("group-" + grpId);
			if (groupNumber) groupNumber.outerHTML = "";

		})
		.catch(ex => console.log(ex));
}

function toggleLike(id) {	
	if (likeButton) {
		if (liked) {

			alert('chat dc')
			
			likeButton.innerHTML = '<i onclick="toggleLike(groupId)" class="fa fa-bell" aria-hidden="true"></i>';
			liked = false;
		} else {

			alert('ko chat')
			likeButton.innerHTML = '<i onclick="toggleLike(groupId)" class="fa fa-bell-slash-o" aria-hidden="true"></i>';
			liked = true;
		}
	}
	
	fetch("http://" + window.location.host + "/chat-web-app/update-conversations-rest-controller?conversationId=" + id, {
		method: 'post'
	})
		.then(function(data) {
			
			return data.json();
		})
		.then(function(data) {
			
		})
		.catch(ex => console.log(ex));
}



function deleteMember(ele) {
	let username = ele.getAttribute("data-username");

	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?conversationId=" + groupId + "&username=" + username, {
		method: 'delete'
	})
		.then(function(data) {
			return data.json();
		})
		.then(function(data) {

			numberMember -= 1;

			let inviteNumber = document.querySelector(".total-invite-user");
			if (inviteNumber) inviteNumber.innerHTML = numberMember + " thành viên";
			//thêm group vào trang.
			toggleAllModal();
		})
		.catch(ex => console.log(ex));

}
//thêm group vào giao diện.
function toggleAllModal() {

	let modalBox = document.querySelectorAll(".modal-box");

	modalBox.forEach(function(modal) {
		modal.classList.remove("active");
	});

}

function toggleModal(ele, mode) {

	let modalBox = document.querySelectorAll(".modal-box");
	let id = ele.getAttribute("data-id");

	modalBox.forEach(function(modal) {
		modal.classList.remove("active");
	});
	if (mode) document.getElementById(id).classList.add("active");
	else document.getElementById(id).classList.remove("active");
}

function showAddGroup(ele, mode) {

	let modalBox = document.querySelectorAll(".modal-box");
	let id = ele.getAttribute("data-id");
	if (mode) document.getElementById(id).classList.add("active");

}



function chatOne(ele) {
	document.querySelector("#receiver").innerHTML = "";
	typeChat = "user";
	//resetChat();
	//ele.classList.add("active");
	searchFriendByKeyword("");
	listFiles = [];
}

function chatGroup(ele) {

	typeChat = "group";
	//resetChat();
	//ele.classList.add("active");
	fetchGroup();
	listFiles = [];
}

function addUserChange(e) {
	if (e.checked) {
		listUserAdd.push(e.value);
	} else {
		let index = listUserAdd.indexOf(e.value);
		listUserAdd.splice(index, 1);
	}

}
//lấy thông tin từ 
function makeFriend(rightSide) {
	fetch("http://" + window.location.host + "/chat-web-app/friend-rest-controller?sender=" + username + "&receiver=" + receiver)
		.then(function(data) {
			return data.json();
		})
		.then(data => {
			var status = '';
			if (document.getElementById('status-' + receiver).classList.contains('online')) {
				status = 'online';
			}

			if (data.status == false && data.owner == username && data.owner != "any") {
				rightSide = '<div class="user-contact">' + '<div class="back">'
					+ '<i class="fa fa-arrow-left"></i>'
					+ '</div>'
					+ '<div class="user-contain">'
					+ '<div class="user-img">'
					+ '<img src="' + receiverAvatar + '" '
					+ 'alt="Image of user">'
					+ '<div class="user-img-dot ' + status + '"></div>'
					+ '</div>'
					+ '<div class="user-info">'
					+ '<span class="user-name">' + receiver + '</span>'
					+ '</div>'
					+ '</div>'
					+ '<span style="font-size:1.8rem">Sent Request</span>'
					+ '</form>'
					+ '</div>'
					+ '<div class="list-messages-contain">'
					+ '<ul id="chat" class="list-messages">'
					+ '</ul>'
					+ '</div>';

				document.getElementById("receiver").innerHTML = rightSide;
			} else if (data.status == false && data.owner != username && data.owner != "any") {
				rightSide = '<div class="user-contact">' + '<div class="back">'
					+ '<i class="fa fa-arrow-left"></i>'
					+ '</div>'
					+ '<div class="user-contain">'
					+ '<div class="user-img">'
					+ '<img src="' + receiverAvatar + '" '
					+ 'alt="Image of user">'
					+ '<div class="user-img-dot ' + status + '"></div>'
					+ '</div>'
					+ '<div class="user-info">'
					+ '<span class="user-name">' + receiver + '</span>'
					+ '</div>'
					+ '</div>'
					+ '<form action="http://' + window.location.host + '/chat-web-app/chat" method="post" >'
					+ '<input type="hidden" name="sender" value="' + username + '">'
					+ '<input type="hidden" name="receiver" value="' + receiver + '">'
					+ '<input type="hidden" name="status" value="true">'
					+ '<input type="hidden" name="isAccept" value="true">'
					+ '<input class="btn" type="submit" value="Accept Friend Request">'
					+ '</form>'
					+ '</div>'
					+ '<div class="list-messages-contain">'
					+ '<ul id="chat" class="list-messages">'
					+ '</ul>'
					+ '</div>';
				document.getElementById("receiver").innerHTML = rightSide;

			} else if (data.status == false && data.sender == "any" && data.receiver == "any") {
				rightSide = '<div class="user-contact">' + '<div class="back">'
					+ '<i class="fa fa-arrow-left"></i>'
					+ '</div>'
					+ '<div class="user-contain">'
					+ '<div class="user-img">'
					+ '<img src="' + receiverAvatar + '" '
					+ 'alt="Image of user">'
					+ '<div class="user-img-dot ' + status + '"></div>'
					+ '</div>'
					+ '<div class="user-info">'
					+ '<span class="user-name">' + receiver + '</span>'
					+ '</div>'
					+ '</div>'
					+ '<form action="http://' + window.location.host + '/chat-web-app/chat" method="post" >'
					+ '<input type="hidden" name="sender" value="' + username + '">'
					+ '<input type="hidden" name="receiver" value="' + receiver + '">'
					+ '<input type="hidden" name="status" value="false">'
					+ '<input type="hidden" name="isAccept" value="false">'
					+ '<input class="btn" type="submit" value="Add Friend">'
					+ '</form>'
					+ '</div>'
					+ '<div class="list-messages-contain">'
					+ '<ul id="chat" class="list-messages">'
					+ '</ul>'
					+ '</div>';
				document.getElementById("receiver").innerHTML = rightSide;
			}
			//
			handleResponsive();
		})
		.catch(ex => console.log(ex));
}

function fetchGroup() {
	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?username=" + username)
		.then(function(data) {
			return data.json();
		})
		.then(data => {

			document.querySelector("#discussionsChats").innerHTML = "";
			document.querySelector("#receiver").innerHTML = "";
			data.forEach(function(data) {
				let numberMember = data.users ? data.users.length : 0;

				let findObject = data.users.find(element => element.username == username);
				let isAdmin = findObject.admin;

				//let imgSrc = ' src="http://' + window.location.host + '/files/group-' + data.id + '/' + data.avatar + '"';
				let imgSrc = 'src="/chat-web-app/static/images/anh2.jpg"';
				if (isAdmin) {
					appendDelete = '<button style="width: 300px;background: rebeccapurple;color: #fff;" data-id="' + data.id + '" onclick="deleteGroup(this)">Xóa</button>';
				} else {
					appendDelete = '';
				}

				let appendUser = '<span id="group-' + data.id + '" >' +
					'<a  data-id="' + data.id + '"  data-number="' + numberMember + '" data-name="' + data.name + '"  onclick="setGroup(this)"' +
					'class="filterDiscussions all unread single active" ' +
					'data-toggle="list" role="tab"> ' +
					'<img class="avatar-md" id="img-group-' + data.id + '"  ' +
					'src="http://localhost:8080/chat-web-app/static/images/anhNhom.jpg" ' +
					'data-toggle="tooltip" data-placement="top" title="Janette" ' +
					'alt="avatar"> ' +
					'<div class="status"> ' +
					'<i class="material-icons online">fiber_manual_record</i> ' +
					'</div> ' +
					'<div class="new bg-yellow"> ' +
					'<span>+7</span> ' +
					'</div> ' +
					'<div class="data-id"> ' +
					'<h5>' + data.name + '</h5> ' +
					'<p>Mới tạo nhóm</p> ' +
					'</div> ' +
					'</a>' + appendDelete
					+ '</span>';


				document.querySelector("#discussionsChats").innerHTML += appendUser;
			});
		}).catch(ex => {
			console.log(ex);
		});
}


function handleResponsive() {
	back = document.querySelector(".back");
	rightSide = document.querySelector(".right-side");
	leftSide = document.querySelector(".left-side");

	if (back) {
		back.addEventListener("click", function() {
			rightSide.classList.remove("active");
			leftSide.classList.add("active");
			listFile = [];
			renderFile();
		});
	}

	rightSide.classList.add("active");
	leftSide.classList.remove("active");

}

//hiện thị dữ liệu khi gửi file đi.
function displayFiles() {
	attachFile = document.getElementById("attach");
	imageFile = document.getElementById("image");
	file = document.querySelector(".list-file");
	deleteAttach = document.querySelectorAll(".delete-attach");

	attachFile.addEventListener("change", function(e) {
		let filesInput = e.target.files;

		for (const file of filesInput) {
			listFile.push(file);
		}

		typeFile = "file";
		renderFile("attach");

		this.value = null;
	});

	imageFile.addEventListener("change", function(e) {
		let filesImage = e.target.files;

		for (const file of filesImage) {
			listFile.push(file);
		}

		typeFile = "image";

		renderFile("image");

		this.value = null;
	});



}

function deleteFile(idx) {
	if (!isNaN(idx)) listFile.splice(idx, 1);

	renderFile(typeFile);
}

function renderFile(typeFile) {
	let listFileHTML = "";
	let idx = 0;

	if (typeFile == "image") {
		for (const file of listFile) {
			listFileHTML += '<li><img src="' + URL.createObjectURL(file)
				+ '" alt="Image file"><span data-idx="'
				+ (idx) + '" onclick="deleteFile('
				+ idx + ')" class="delete-attach">X</span></li>';
			idx++;
		}
	} else {
		for (const file of listFile) {
			listFileHTML += '<li><div class="file-input">' + file.name
				+ '</div><span data-idx="'
				+ (idx) + '" onclick="deleteFile('
				+ idx + ')" class="delete-attach">X</span></li>';
			idx++;
		}
	}


	if (listFile.length == 0) {
		file.innerHTML = "";
		file.classList.remove("active");
	} else {
		file.innerHTML = listFileHTML;
		file.classList.add("active");
	}

	deleteAttach = document.querySelectorAll(".delete-attach");
}
//khi click vào nút gửi tinh nhắn.
function sendMessage(e) {
	e.preventDefault();
	//lấy dữu liệu
	var inputText = document.getElementById("message").value;
	if (inputText != '') {
		//có dữ liệu
		console.log(inputText + 'inputtest');
		sendText();
	} else {
		console.log('dữ liệu  rông');
		sendAttachments();
	}

	return false;
}
//gửi dữ liệu đi trong tin nhắn.
function sendText() {

	var messageContent = document.getElementById("message").value;
	var messageType = "text";
	//console.log('Nội dung tin nhắn' + messageContent);
	document.getElementById("message").value = '';
	//lấy dữ liệu data về và kiểm tra kiểu gửi.
	var message = buildMessageToJson(messageContent, messageType);
	setMessage(message);
	websocket.send(JSON.stringify(message));
}
//ảnh và file được sử lí.
function sendAttachments() {
	var messageType = "attachment";
	console.log('Vô hàm kiểm tra file');
	for (file of listFile) {
		//lấy tên file
		messageContent = file.name.trim();
		//đuôi ảnh .jpg chăng hạng.
		messageType = file.type;
		console.log('Kiểu file là gì:' + messageType);
		console.log('Nội dung file là gì:' + messageContent);
		var message = buildMessageToJson(messageContent, messageType);
		//	console.log('message là gì: ' + message);
		//dùng để lưu hình ảnh trong database.
		websocket.send(JSON.stringify(message));
		websocket.send(file);
		//kiểm tra để render đúng theo yêu cầu..
		if (messageType.startsWith("audio")) {
			message.message = '<audio controls>'
				+ '<source src="' + URL.createObjectURL(file) + '" type="' + messageType + '">'
				+ '</audio>';
		} else if (messageType.startsWith("video")) {
			message.message = '<video width="400" controls>'
				+ '<source src="' + URL.createObjectURL(file) + '" type="' + messageType + '">'
				+ '</video>';
		} else if (messageType.startsWith("image")) {
			console.log('FIle này là dạng hình ảnh');
			console.log('file hiện thị hình ảnh là: ' + URL.createObjectURL(file));
			//cai file la hinh anh hay tat ca gi do			
			message.message = '<img src="' + URL.createObjectURL(file) + '" alt="">';
			console.log('chạy vô hình ảnh file: ' + file);


			// console.log('message.message là gì: ' +message.message);
			//hien thij file gui di ko anh.
			var imgElement = document.createElement('img');
			imgElement.src = URL.createObjectURL(file);
			imgElement.alt = "";
			message.message = imgElement.outerHTML;
			console.log('chay qua in html')
		}
		else {

			message.message = '<a href= "' + URL.createObjectURL(file) + '">' + messageContent + '</a>'
		}
		setMessage(message);
	}
	file = document.querySelector(".list-file");
	file.classList.remove("active");
	file.innerHTML = "";
	listFile = [];
}
//hàm này nó lấy object chuyển thông tin cần gửi
function buildMessageToJson(message, type) {//kiểm tra kiểu tin nhắn hay hình ảnh video.
	return {
		username: username,
		message: message,
		type: type,
		receiver: receiver,
		groupId: Number(groupId)
	};
}
//hàm gửi và đồng thời load lại thông tin.
function setMessage(msg) {
	//console.log('msg là gì:' + msg);
	if (msg.message != '[P]open' && msg.message != '[P]close') {
		var currentChat = document.getElementById('chat').innerHTML;
		//	console.log('in ra thông tin của chat:' + currentChat);
		var newChatMsg = '';
		if (msg.receiver != null) {
			newChatMsg = customLoadMessage(msg.username, msg.message);
		} else {
			newChatMsg = customLoadMessageGroup(msg.username, msg.groupId, msg.message, msg.avatar);
		}
		document.getElementById('chat').innerHTML = currentChat
			+ newChatMsg;
		goLastestMsg();
	} else {
		console.log('chạy xuống đoạn chat thứ 2:');
		//mới vô sẽ chạy đoạn code thứ 2 trươc
		//set trạng thái người dùng lại.
		if (msg.message === '[P]open') {
			msg.onlineList.forEach(username => {
				try {
					setOnline(username, true);
				} catch (ex) { }
			});
		} else {
			setOnline(msg.username, false);
		}

	}
}

function setOnline(username, isOnline) {
	let ele = document.getElementById('status-' + username);

	if (isOnline === true) {
		ele.classList.add('online');
	} else {
		ele.classList.remove('online');
	}
}

//load thông tin từ group
function loadMessagesGroup() {
	var currentChatbox = document.getElementById("chat");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var messages = JSON.parse(this.responseText);
			var chatbox = "";
			messages.forEach(msg => {
				try {
					chatbox += customLoadMessageGroup(msg.username, groupId, msg.message, msg.avatar);
				} catch (ex) {

				}
			});
			currentChatbox.innerHTML = chatbox;
			goLastestMsg();
		}
	};
	xhttp.open("GET", "http://" + window.location.host + "/chat-web-app/conversations-rest-controller?messagesConversationId=" + groupId, true);
	xhttp.send();
}
//load tin nhắn và load lại trang.
function loadMessages() {
	var currentChatbox = document.getElementById("chat");
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4 && this.status == 200) {
			var messages = JSON.parse(this.responseText);
			var chatbox = "";
			messages.forEach(msg => {
				try {
					chatbox += customLoadMessage(msg.username, msg.message);
				} catch (ex) {

				}
			});
			currentChatbox.innerHTML = chatbox;
			//cuonjso xuống tin nhắn gần nhất.
			goLastestMsg();
		}
	};
	xhttp.open("GET", "http://" + window.location.host + "/chat-web-app/chat-rest-controller?sender=" + username
		+ "&receiver=" + receiver, true);
	xhttp.send();
}
//load tin nhắn của 2 người.
//hiện thị thông tin nhắn cho 2 người.
function customLoadMessage(sender, message) {
	//console.log('hiện thị thông tin người dùng custom:' + sender, message);
	//	console.log('receiver:' + receiver);
	//console.log('username:' + username);
	//console.log('sender:' + sender);
	//console.log('img:' + userAvatar);
	//console.log('Hiện thi thông tin message:' + message);
	var imgSrc = receiverAvatar;

	//kết hợp hiện thị ra.
	var msgDisplay = '<li>' + '<div class="message';
	if (receiver != sender && username != sender) {
		return '';
	}
	else if (receiver == sender) {
		msgDisplay += '">';
	} else {
		//hình ảnh người mình nhắn.
		imgSrc = userAvatar;
		msgDisplay += ' right">';
	}
	return msgDisplay + '<div class="message-img">'
		+ '<img src="' + imgSrc + '" alt="">'
		+ ' </div>'
		+ '<div class="message-text">' + message + '</div>'
		+ '</div>'
		+ '</li>';
}

function customLoadMessageGroup(sender, groupIdFromServer, message, avatar) {
	//let imgSrc = 'http://' + window.location.host + '/files/' + sender + '/' + avatar;
	let imgSrc = '/chat-web-app/static/images/anh5.jpg';
	var msgDisplay = '<li>'
		+ '<div class="message';
	if (groupIdFromServer != groupId) {
		return '';
	}
	if (username != sender) {
		msgDisplay += '">';
	} else {
		imgSrc = userAvatar;
		msgDisplay += ' right">';
	}
	return msgDisplay + '<div class="message-img">'
		+ '<img src="' + imgSrc + '" alt="">'
		+ '<div class="sender-name">' + sender + '</div>'
		+ ' </div>'
		+ '<div class="message-text">' + message + '</div>'
		+ '</div>'
		+ '</li>';
}
//tìm kiếm bạn, click vào bạn hiện thị tin nhắn bạn bè đã nhắn.
//message bên trái.
function searchFriendByKeyword(keyword) {
	fetch("http://" + window.location.host + "/chat-web-app/users-rest-controller?username=" + username + "&keyword=" + keyword)
		.then(function(data) {
			return data.json();
		})
		.then(data => {

			document.querySelector("#contacts").innerHTML = "";
			data.forEach(function(data) {
				if (data.online) status = "online";
				else status = "";


				let appendUser = '<a id="' + data.username + '" onclick="setReceiver(this);" class="filterMembers all online contact" data-toggle="list">'
					+ '<img id="img-' + data.username + '" class="avatar-md" src="http://localhost:8080/chat-web-app/static/data/' + data.username + '/' + data.avatar + '"data-toggle="tooltip" data-placement="top" title="Janette" alt="avatar">'
					+ '<div class="status" id="status-' + data.username + '" class="user-img-dot">'
					+ '<i class="material-icons online">fiber_manual_record</i>'
					+ '</div>'
					+ '<div class="data">'
					+ '<h5>' + data.username + '</h5>'
					+ '<p>Bạc Liêu, VIệt Nam</p>'
					+ '</div>'
					+ '</a>';

				document.querySelector("#contacts").innerHTML += appendUser;
			});
		});
}
//message bên phải // thay đổi ảnh khi tìm kiếm.
function searchMemberByKeyword(ele) {
	let keyword = ele.value;
	fetch("http://" + window.location.host + "/chat-web-app/users-rest-controller?username=" + username + "&keyword=" + keyword + "&conversationId=" + groupId)
		.then(function(data) {
			return data.json();
		})
		.then(data => {// tìm kiếm bạn set cứng.

			document.querySelector(".add-member-body .list-user ul").innerHTML = "";
			data.forEach(function(data) {
				if (data.online) status = "online";
				else status = "";

				let check = "";
				if (listUserAdd.indexOf(data.username) >= 0) check = "checked";

				let appendUser = '<li>'
					+ '<input id="member-' + data.username + '" type="checkbox" ' + check + ' value="' + data.username + '" onchange="addUserChange(this)">'
					+ '<label for="member-' + data.username + '">'
					+ '<div class="user-contain">'
					+ '<div class="user-img">'
					+ '<img '
					+ ' src="/chat-web-app/static/images/anh12.jpg"'
					+ 'alt="Image of user">'
					+ '</div>'
					+ '<div class="user-info">'
					+ '<span class="user-name">' + data.username + '</span>'
					+ '</div>'
					+ '</div>'
					+ '</label>'
					+ '<div class="user-select-dot"></div>'
					+ '</li>';
				document.querySelector(".add-member-body .list-user ul").innerHTML += appendUser;
			});
		});
}

function searchGroupByKeyword(value) {
	let keyword = value;
	fetch("http://" + window.location.host + "/chat-web-app/conversations-rest-controller?username=" + username + "&conversationKeyword=" + keyword)
		.then(function(data) {
			return data.json();
		})
		.then(data => {

			document.querySelector("#discussionsChats").innerHTML = "";
			data.forEach(function(data) {

				let numberMember = data.users ? data.users.length : 0;
				let findObject = data.users.find(element => element.username == username);
				let isAdmin = false;

				if (findObject) isAdmin = findObject.admin;
				//đường dẫn khi thêm vào nhóm ở đây.
				//let imgSrc = ' src="http://' + window.location.host + '/files/group-' + data.id + '/' + data.avatar + '"';

				let imgSrc = 'src="/chat-web-app/static/images/anh2.jpg"';
				let appendUser = '<a  data-id="' + data.id + '"  data-number="' + numberMember + '" data-name="' + data.name + '"  onclick="setGroup(this)"' +
					'class="filterDiscussions all unread single active" ' +
					'data-toggle="list" role="tab"> ' +
					'<img class="avatar-md" id="img-group-' + data.id + '"  ' +
					'src="http://localhost:8080/chat-web-app/static/data/khang/anh1.jpg" ' +
					'data-toggle="tooltip" data-placement="top" title="Janette" ' +
					'alt="avatar"> ' +
					'<div class="status"> ' +
					'<i class="material-icons online">fiber_manual_record</i> ' +
					'</div> ' +
					'<div class="new bg-yellow"> ' +
					'<span>+7</span> ' +
					'</div> ' +
					'<div class="data-id"> ' +
					'<h5>' + data.name + '</h5> ' +
					'<p>Mới tạo nhóm</p> ' +
					'</div> ' +
					'<button style="width: 300px;background: rebeccapurple;color: #fff;" data-id="' + data.id + '" onclick="deleteGroup(this)">Xóa</button>' +
					'</a>';
				//	if (isAdmin) {
				//	appendUser += '<div class="group-delete border" data-id="' + data.id + '" onclick="deleteGroup(this)">Delete</div>';
				//}				
				document.querySelector("#discussionsChats").innerHTML += appendUser;
			});
		});
}

function searchUser(ele) {
	if (typeChat == "user") {
		console.log('tìm kiếm bạn bè');
		searchFriendByKeyword(ele.value);
	} else {
		console.log('tìm kiếm nhóm');
		if (ele.value == "") {
			fetchGroup();
		} else {
			console.log('chay vo if 3');
			searchGroupByKeyword(ele.value);
		}
	}
}
//tự động load tin nhắn cuối cùng nếu ko có thì ko load..
function goLastestMsg() {
	var msgLiTags = document.querySelectorAll(".message");
	var last = msgLiTags[msgLiTags.length - 1];
	try {
		last.scrollIntoView();
	} catch (ex) { }
}
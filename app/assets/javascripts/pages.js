$(document).ready(function(){
	var text_area = document.getElementById('post_content');
	var char = document.getElementById('content_size');
	var submit_button = document.getElementById('submit_button');
	
	text_area.addEventListener('input',function(){
		
		char.innerHTML = 140 - text_area.value.length + ' Characters left';
		
		
		if(text_area.value.length > 140)
		{
		char.style.color = "red";
		submit_button.disabled = true;
		char.innerHTML = 0;
		}
		else{
		char.style.color = "black";
		submit_button.disabled = false;
		}
	});
});


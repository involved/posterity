$(document).ready(function() {
	bindTagInputs();
});

/* Handles tag list creation */
function bindTagInputs(){
	setInterval(updateTagInputs, 50);
	$('.tag.removable a').live('click', removeTag);
}

function updateTagInputs(){
	$(".tag_input").each(function(){
		var input = $(this);
		var target = $(input.attr('data-target'));
		var form_target = $(input.attr('data-form-target'));
		if(input.val().indexOf(",") != -1){
			var tag = $("<span class=\"tag removable\"></span>");
			var link = $("<a href=\"javascript:void(0);\" data-form-target=\"" + input.attr('data-form-target') + "\"></a>");
			var contents = input.val().split(",");
			var label = $.trim(contents.shift());
			
			input.val(contents.join(","));
			
			link.html(label);
						
			tag.append(link);
			target.append(tag);
			
			var form_input_value = form_target.val().split(",");
			form_input_value.unshift(label);
			form_target.val( form_input_value.join(",") );
		}
	});
}

function removeTag(){
	var link = $(this);
	var tag = link.html();
	var form_target = $(link.attr('data-form-target'));
	var tags = form_target.val().split(",");
	for(var i in tags){
		tags[i] = $.trim(tags[i]);
	}
	tags.splice(tags.indexOf(tag), 1);
	form_target.val(tags.join(","));
	link.parent('.tag').detach();
}
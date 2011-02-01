# Posterity TODO
	
* Add 'Activity' model for tracking changes
	* 3 fields: user_name, model name, action
	* models should use callbacks to report actions or maybe a reports_activity [:update, :create, :destroy]
	* adds before filters for each of those symbols
	* Should also include some sort of link ref
	
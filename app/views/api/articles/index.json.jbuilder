json.articles @articles do |article|
	json.(article, :id, :author, :title)
end
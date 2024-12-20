local M = {}

function M.list_saved_queries()
	local dbs = vim.call("db_ui#list")

	local joinedList = {}

	for _, entry in pairs(dbs) do
		local db = vim.call("db_ui#get_db", entry.key_name)
		if db.saved_queries and type(db.saved_queries) == "table" then
			for _, item in ipairs(db.saved_queries.list) do
				-- table.insert(joinedList, { display_name = item, file_name: item, db_name: entry.key_name })
				-- table.insert(joinedList, item)
				table.insert(
					joinedList,
					{ display_name = item:match(".*/(.*)"), db_name = "Database2", file_name = "File2.sql" }
				)
			end
		end
	end

	local displayList = {}
	for i, entry in ipairs(joinedList) do
		displayList[i] = entry.display_name -- Or any other string you want to show in the list
	end

	local function getEntryData(selectedDisplay)
		for _, entry in ipairs(joinedList) do
			if entry.display_name == selectedDisplay then
				return entry
			end
		end
	end

	vim.ui.select(displayList, { prompt = "Saved queries" }, function(choice, index)
		if choice then
			-- local db = vim.call("db_ui#get_db", choice.key_name)
			local selected = getEntryData(choice)
			for key, value in pairs(selected) do
				print(key .. ": " .. tostring(value))
			end
		else
			print("Invalid choice.")
		end
	end)
end

function M.new_buffer()
	-- {'label': 'New query', 'dbui_db_key_name': 'Prod - Claims_file', 'action': 'open', 'level': 1, 'icon': '  󰓰', 'type': 'query'}
	print("ja")
end
return M

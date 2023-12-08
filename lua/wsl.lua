if vim.fn.has('wsl') then
	-- 系统剪切板
	vim.g.clipboard = {
		name = 'WslClipboard',
		copy = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe'
		},
		paste = {
			['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
	
	-- 切换输入法
	local imselect = "/mnt/e/wsl/im-select.exe"
	local curInput = tonumber(vim.fn.system(imselect))
	vim.api.nvim_create_autocmd({"InsertLeave"}, {
		pattern = {"*"},
		callback = function()
			curInput = tonumber(vim.fn.system(imselect))
			local swich_to_en = imselect .. " " .. 1033
			vim.fn.system(swich_to_en)
		end
	})
	vim.api.nvim_create_autocmd({"InsertEnter"}, {
		pattern = {"*"},
		callback = function()
			local swich_to_org = imselect .. " " .. curInput
			vim.fn.system(swich_to_org)
		end
	})
end

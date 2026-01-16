return require("telescope").register_extension({
	exports = {
		convert = require("convert.telescope").actions_picker
	}
})

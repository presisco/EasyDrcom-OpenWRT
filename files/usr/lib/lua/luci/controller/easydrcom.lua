module("luci.controller.easydrcom", package.seeall)

function index()
	entry({"admin", "services", "easydrcom"}, cbi("easydrcom"), _("easydrcom"), 100)
	end
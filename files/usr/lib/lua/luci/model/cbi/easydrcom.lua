require("luci.sys")

m = Map("easydrcom", translate("HITWH EasyDrcom"), translate("Configure HITWH 802.1x client."))

s = m:section(TypedSection, "login", "")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
enable.default = "0"


s:option(Flag, "boot", translate("Start at boot")).default="0"


autoredial = s:option(ListValue, "AutoRedial", translate("Auto Redial"))
autoredial:value("0",translate("0(no)"))
autoredial:value("1",translate("1(yes)"))
autoredial.default = "1"

s:option(Value, "UserName", translate("Username"))
pass = s:option(Value, "PassWord", translate("Password"))
pass.password = true

mode = s:option(ListValue, "Mode", translate("Mode"))
mode:value("0",translate("0(dormitory area1)"))
mode:value("1",translate("1(office area)"))
mode:value("2",translate("2(dormitory area2)"))
mode.default = "2"

s:option(Value, "IP", translate("authentication's IP")).default="172.25.8.4"
s:option(Value, "Port", translate("authentication's port")).default="61440"

broadcast = s:option(ListValue, "UseBroadcast", translate("MAC BROADCAST"))
broadcast:value("0",translate("0(no)"))
broadcast:value("1",translate("1(yes)"))
broadcast.default = "1"

s:option(Value, "MAC", translate("authentication's MAC address")).default="00:1a:a9:c3:3a:59"


ifname = s:option(ListValue, "NIC", translate("Interfaces"))
for k, v in ipairs(luci.sys.net.devices()) do
	if v ~= "lo" then
		ifname:value(v)
	end
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/easydrcom restart")
end

s:option(Value, "EAPTimeout", translate("Packet timeout (ms)")).default="1000"
s:option(Value, "UDPTimeout", translate("UDP Packet timeout (ms)")).default="2000"
s:option(Value, "HostName", "HostName").default="EasyDrcom for HITwh"
s:option(Value, "KernelVersion" ,"KernelVersion").default="0.7_mips_AR7xxx_AR9xxxx"

return m

------------------------------------------------
-- This Source Was Developed By (Rio) @C_F_4.--
--   This Is The Source Channel @F_L_3 .   --
--                - Prox -                 --
--        -- https://t.me/F_L_3 --         --
------------------------------------------------ 
DevRio  = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
serpent = dofile("./libs/serpent.lua")
JSON    = dofile("./libs/dkjson.lua")
json    = dofile("./libs/JSON.lua")
URL     = dofile("./libs/url.lua")
http    = require("socket.http") 
HTTPS   = require("ssl.https") 
https   = require("ssl.https") 
User    = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
Server  = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a') 
DirName = io.popen("echo $(cd $(dirname $0); pwd)"):read('*a'):gsub('[\n\r]+', '')
Ip      = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name    = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port    = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
UpTime  = io.popen([[uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}']]):read('*a'):gsub('[\n\r]+', '')
--     Source Prox     --
local AutoSet = function() 
if not DevRio:get(Server.."IdProx") then 
io.write('\27[1;35m\nالان ارسل ايدي المطور الاساسي ↫ ⤈\n\27[0;33;49m') 
local DevId = io.read():gsub(' ','') 
if tostring(DevId):match('%d+') then 
io.write('\27[1;36mتم حفظ ايدي المطور الاساسي\n27[0;39;49m') 
DevRio:set(Server.."IdProx",DevId) 
else 
print('\27[1;31m──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\nلم يتم حفظ ايدي المطور الاساسي ارسله مره اخرى\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈') 
end 
os.execute('lua Prox.lua') 
end 
if not DevRio:get(Server.."TokenProx") then 
io.write('\27[1;35m\nالان قم بارسال توكن البوت ↫ ⤈\n\27[0;33;49m') 
local TokenBot = io.read() 
if TokenBot ~= '' then 
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe') 
if res ~= 200 then 
print('\27[1;31m──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\nالتوكن غير صحيح تاكد منه ثم ارسله\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈') 
else 
io.write('\27[1;36mتم حفظ توكن البوت بنجاح\n27[0;39;49m') 
DevRio:set(Server.."TokenProx",TokenBot) 
end  
else 
print('\27[1;31m──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\nلم يتم حفظ توكن البوت ارسله مره اخرى\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈') 
end  
os.execute('lua Prox.lua') 
end
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
local CreateConfigAuto = function()
Config = {
DevId = DevRio:get(Server.."IdProx"),
TokenBot = DevRio:get(Server.."TokenProx"),
Prox = DevRio:get(Server.."TokenProx"):match("(%d+)"),
SudoIds = {DevRio:get(Server.."IdProx")},
}
Create(Config, "./config.lua") 
file = io.open("Prox.sh", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Prox
token="]]..DevRio:get(Server.."TokenProx")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉ ┉"
echo "~ The tg File Was Not Found In The Bot Files!"
echo "──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "~ The Token Was Not Found In The config.lua File!"
echo "──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
./tg -s ./Prox.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("Run", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/Prox
while(true) do
rm -fr ../.telegram-cli
screen -S Prox -X kill
screen -S Prox ./Prox.sh
done
]]) 
file:close() 
io.popen("mkdir Files")
os.execute('chmod +x Run;./Run')
end 
CreateConfigAuto()
end
local Load_Prox = function() 
local f = io.open("./config.lua", "r") 
if not f then 
AutoSet() 
else 
f:close() 
DevRio:del(Server.."IdProx");DevRio:del(Server.."TokenProx")
end 
local config = loadfile("./config.lua")() 
return config 
end  
Load_Prox() 
print("\27[36m"..[[          

    $$$$$$$\                                
    $$  __$$\                               
    $$ |  $$ | $$$$$$\   $$$$$$\  $$\   $$\ 
    $$$$$$$  |$$  __$$\ $$  __$$\ \$$\ $$  |
    $$  ____/ $$ |  \__|$$ /  $$ | \$$$$  / 
    $$ |      $$ |      $$ |  $$ | $$  $$<  
    $$ |      $$ |      \$$$$$$  |$$  /\$$\ 
    \__|      \__|       \______/ \__/  \__|
                                            
                                        
]]..'\27[m'.."\n\27[35mServer Information ↬ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉\27[m\n\27[36m~ \27[mUser \27[36m: \27[10;32m"..User.."\27[m\n\27[36m~ \27[mIp \27[36m: \27[10;32m"..Ip.."\27[m\n\27[36m~ \27[mName \27[36m: \27[10;32m"..Name.."\27[m\n\27[36m~ \27[mPort \27[36m: \27[10;32m"..Port.."\27[m\n\27[36m~ \27[mUpTime \27[36m: \27[10;32m"..UpTime.."\27[m\n\27[35m──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉\27[m")
Config = dofile("./config.lua")
DevId = Config.DevId
SudoIds = {Config.SudoIds,1823672541}
Prox = Config.Prox
TokenBot = Config.TokenBot
NameBot = (DevRio:get(Prox..'Rio:NameBot') or 'كيلوا')
--     Source Prox     --
FilesPrint = "\27[35m".."\nAll Source Files Started ↬ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉\n"..'\27[m'
FilesNumber = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
FilesNumber = FilesNumber + 1
FilesPrint = FilesPrint.."\27[39m"..FilesNumber.."\27[36m".."~ : \27[10;32m"..v.."\27[m \n"
end
end
FilesPrint = FilesPrint.."\27[35m".."──┈┈┈┄┄╌╌╌╌┄┄┈┈┈ ┉ ┉ ┉ ┉\n".."\27[m"
if FilesNumber ~= 0 then
print(FilesPrint)
end
--     Source Prox     --
--     Start Functions    --
function vardump(value)
print(serpent.block(value, {comment=false}))
end
--     Source Prox     --
function dl_cb(arg, data)
end
--     Source Prox     --
----------  Sudo  ----------
function Sudo(msg) 
local var = false 
for k,v in pairs(SudoIds) do 
if msg.sender_user_id_ == v then 
var = true 
end end 
if msg.sender_user_id_ == tonumber(DevId) then 
var = true 
end 
return var 
end
function SudoId(user_id) 
local var = false 
for k,v in pairs(SudoIds) do 
if user_id == v then 
var = true 
end end 
if user_id == tonumber(DevId) then 
var = true 
end 
return var 
end
--     Source Prox     --
-------  RioSudo  -------
function RioSudo(msg) 
local Status = DevRio:sismember(Prox..'Rio:RioSudo:',msg.sender_user_id_) 
if Status or Sudo(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
-------  SecondSudo  -------
function SecondSudo(msg) 
local Status = DevRio:sismember(Prox..'Rio:SecondSudo:',msg.sender_user_id_) 
if Status or RioSudo(msg) or Sudo(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
----------  Bot  -----------
function Bot(msg) 
local var = false  
if msg.sender_user_id_ == tonumber(Prox) then  
var = true  
end  
return var  
end 
--     Source Prox     --
---------  SudoBot  --------
function SudoBot(msg) 
local Status = DevRio:sismember(Prox..'Rio:SudoBot:',msg.sender_user_id_) 
if Status or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
    --     Source Prox     --
----   RioConstructor   ----
function RioConstructor(msg) 
local Status = DevRio:sismember(Prox..'Rio:RioConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
----  BasicConstructor  ----
function BasicConstructor(msg) 
local Status = DevRio:sismember(Prox..'Rio:BasicConstructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
----    Constructor     ----
function Constructor(msg) 
local Status = DevRio:sismember(Prox..'Rio:Constructor:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or BasicConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
---------  Manager  --------
function Manager(msg) 
local Status = DevRio:sismember(Prox..'Rio:Managers:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
----------  Admin  ---------
function Admin(msg) 
local Status = DevRio:sismember(Prox..'Rio:Admins:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
---------Vip Member---------
function VipMem(msg) 
local Status = DevRio:sismember(Prox..'Rio:VipMem:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioConstructor(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Admin(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
--------- Cleaner ----------
function Cleaner(msg) 
local Status = DevRio:sismember(Prox..'Rio:Cleaner:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
--------- CleanerNum ----------
function CleanerNum(msg) 
local Status = DevRio:sismember(Prox..'Rio:CleanerNum:'..msg.chat_id_,msg.sender_user_id_) 
if Status or SudoBot(msg) or Cleaner(msg) or RioConstructor(msg) or RioSudo(msg) or Sudo(msg) or SecondSudo(msg) or Bot(msg) then  
return true  
else  
return false  
end  
end
--     Source Prox     --
---------  Banned  ---------
local function Ban(user_id, chat_id)
if DevRio:sismember(Prox..'Rio:Ban:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
--     Source Prox     --
---------  BanAll  ---------
function BanAll(user_id)
if DevRio:sismember(Prox..'Rio:BanAll:', user_id) then
var = true
else
var = false
end
return var
end
--     Source Prox     --
----------  Muted  ---------
local function Muted(user_id, chat_id)
if DevRio:sismember(Prox..'Rio:Muted:'..chat_id, user_id) then
var = true
else
var = false
end
return var
end
--     Source Prox     --
---------  MuteAll  --------
function MuteAll(user_id)
if DevRio:sismember(Prox..'Rio:MuteAll:', user_id) then
var = true
else
var = false
end
return var
end
--     Source Prox     --
function DeleteMessage(chatid ,mid)
pcall(tdcli_function ({
ID = "DeleteMessages",
chat_id_ = chatid,
message_ids_ = mid
},function(arg,data) 
end,nil))
end
--     Source Prox     --
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
pcall(tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil))
end
--     Source Prox     --
function ProxFiles(msg)
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
plugin = dofile("Files/"..v)
if plugin.Prox and msg then
FilesText = plugin.Prox(msg)
end
end
end
send(msg.chat_id_, msg.id_,FilesText)  
end
--     Source Prox     --
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
--     Source Prox     --
function AddFile(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if File_Name:lower():match('(%d+)') ~= Prox:lower() then 
send(chat,msg.id_,"⌔  عذرا هذا الملف ليس تابع لهذا البوت")   
return false 
end
send(chat,msg.id_,"⌔  جاري رفع الملف ... .")
local File = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..File.result.file_path, ''..File_Name) 
else
send(chat,msg.id_,"⌔  عذرا الملف ليس بصيغة ↫ Json يرجى رفع الملف الصحيح")
end
local info_file = io.open('./'..Prox..'.json', "r"):read('*a')
local JsonInfo = JSON.decode(info_file)
vardump(JsonInfo)
DevRio:set(Prox.."Rio:NameBot",JsonInfo.BotName) 
for IdGps,v in pairs(JsonInfo.GroupsList) do
DevRio:sadd(Prox.."Rio:Groups",IdGps) 
DevRio:set(Prox.."Rio:Lock:Bots"..IdGps,"del") DevRio:hset(Prox.."Rio:Spam:Group:User"..IdGps ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevRio:set(Prox..Lock..IdGps,true)
end
if v.RioConstructors then
for k,IdRioConstructors in pairs(v.RioConstructors) do
DevRio:sadd(Prox..'Rio:RioConstructor:'..IdGps,IdRioConstructors)  
print('تم رفع منشئين المجموعات')
end
end
if v.BasicConstructors then
for k,IdBasicConstructors in pairs(v.BasicConstructors) do
DevRio:sadd(Prox..'Rio:BasicConstructor:'..IdGps,IdBasicConstructors)  
print('تم رفع ( '..k..' ) منشئين اساسيين')
end
end
if v.Constructors then
for k,IdConstructors in pairs(v.Constructors) do
DevRio:sadd(Prox..'Rio:Constructor:'..IdGps,IdConstructors)  
print('تم رفع ( '..k..' ) منشئين')
end
end
if v.Managers then
for k,IdManagers in pairs(v.Managers) do
DevRio:sadd(Prox..'Rio:Managers:'..IdGps,IdManagers)  
print('تم رفع ( '..k..' ) مدراء')
end
end
if v.Admins then
for k,idmod in pairs(v.Admins) do
vardump(IdAdmins)
DevRio:sadd(Prox..'Rio:Admins:'..IdGps,IdAdmins)  
print('تم رفع ( '..k..' ) ادمنيه')
end
end
if v.Vips then
for k,IdVips in pairs(v.Vips) do
DevRio:sadd(Prox..'Rio:VipMem:'..IdGps,IdVips)  
print('تم رفع ( '..k..' ) مميزين')
end
end
if v.LinkGroups then
if v.LinkGroups ~= "" then
DevRio:set(Prox.."Rio:Groups:Links"..IdGps,v.LinkGroups)   
print('( تم وضع روابط المجموعات )')
end
end
if v.Welcomes then
if v.Welcomes ~= "" then
DevRio:set(Prox.."Rio:Groups:Welcomes"..IdGps,v.Welcomes)   
print('( تم وضع ترحيب المجموعات )')
end
end
end
send(chat,msg.id_,"⌔  تم رفع النسخه بنجاح \n⌔  تم تفعيل جميع المجموعات \n⌔  تم استرجاع مشرفين المجموعات \n⌔  تم استرجاع اوامر القفل والفتح في جميع مجموعات البوت ")
end
--     Source Prox     --
function resolve_username(username,cb)
tdcli_function ({
ID = "SearchPublicChat",
username_ = username
}, cb, nil)
end
--     Source Prox     --
function getInputFile(file)
if file:match('/') then
infile = {ID = "InputFileLocal", path_ = file}
elseif file:match('^%d+$') then
infile = {ID = "InputFileId", id_ = file}
else
infile = {ID = "InputFilePersistentId", persistent_id_ = file}
end
return infile
end
--     Source Prox     --
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
--     Source Prox     --
function ChatLeave(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
end
--     Source Prox     --
function ChatKick(chat_id, user_id)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = chat_id, user_id_ = user_id, status_ = { ID = "ChatMemberStatusKicked" }, }, dl_cb, nil)
end
--     Source Prox     --
function getParseMode(parse_mode)
if parse_mode then
local mode = parse_mode:lower()
if mode == 'markdown' or mode == 'md' then
P = {ID = "TextParseModeMarkdown"}
elseif mode == 'html' then
P = {ID = "TextParseModeHTML"}
end
end
return P
end
--     Source Prox     --
function getMessage(chat_id, message_id,cb)
tdcli_function ({
ID = "GetMessage",
chat_id_ = chat_id,
message_id_ = message_id
}, cb, nil)
end
--     Source Prox     --
function sendContact(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, phone_number, first_name, last_name, user_id)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessageContact", contact_ = { ID = "Contact", phone_number_ = phone_number, first_name_ = first_name, last_name_ = last_name, user_id_ = user_id },},}, dl_cb, nil)
end
--     Source Prox     --
function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo, caption)
tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = { ID = "InputMessagePhoto", photo_ = getInputFile(photo), added_sticker_file_ids_ = {}, width_ = 0, height_ = 0, caption_ = caption }, }, dl_cb, nil)
end
--     Source Prox     --
function Dev_Rio(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
local TextParseMode = getParseMode(parse_mode) tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text, disable_web_page_preview_ = disable_web_page_preview, clear_draft_ = 0, entities_ = {}, parse_mode_ = TextParseMode, }, }, dl_cb, nil)
end
--     Source keloa     --
function Dev_Rio(chat_id, reply_to_message_id, disable_notification, text, disable_web_page_preview, parse_mode)
if text then 
local TextParseMode = getParseMode(parse_mode)
local text2 = text
if parse_mode then
if parse_mode == 'markdown' or parse_mode == 'md' then
parse_mode = "Markdown"
elseif parse_mode == 'html' then
parse_mode = "Html"
end
end
keyboard = {}
keyboard.inline_keyboard = {{{text = '⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯',url="t.me/F_L_3"}}}
local Abs = "https://api.telegram.org/bot" ..TokenBot.. '/sendMessage?chat_id=' .. chat_id
if reply_to_message_id ~= 0 then
Abs = Abs .. '&reply_to_message_id=' .. reply_to_message_id/2097152/0.5 
end
if disable_web_page_preview then
Abs = Abs .. '&disable_web_page_preview=true'
end
if text then
Abs = Abs..'&text='..URL.escape(text2)
end
if parse_mode then
Abs = Abs .. '&parse_mode='..parse_mode
end
Abs = Abs..'&reply_markup='..JSON.encode(keyboard)
return GetApi(Abs) 
else
tdcli_function ({
ID = "SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_to_message_id,
disable_notification_ = disable_notification,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID = "InputMessageText",
text_ = text,
disable_web_page_preview_ = disable_web_page_preview,
clear_draft_ = 0,
entities_ = {},
parse_mode_ = TextParseMode,
},}, dl_cb, nil)
end
end
--     Source Prox     --
function GetApi(web) 
local info, res = https.request(web) 
local req = json:decode(info) if res ~= 200 then 
return false 
end 
if not req.ok then 
return false 
end 
return req 
end 
--     Source Prox     --
function SendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..TokenBot 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown&disable_web_page_preview=true" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return GetApi(url) 
end

--     Source Prox     --
function SendInline(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local send_api = "https://api.telegram.org/bot"..TokenBot.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return GetApi(send_api) 
end
--     Source Prox     --
function EditMsg(chat_id, message_id, text, markdown) local send_api = "https://api.telegram.org/bot"..TokenBot.."/editMessageText?chat_id="..chat_id.."&message_id="..message_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true" return GetApi(send_api)  end
--     Source Prox     --
function Pin(channel_id, message_id, disable_notification) 
tdcli_function ({ 
ID = "PinChannelMessage", 
channel_id_ = getChatId(channel_id).ID, 
message_id_ = message_id, 
disable_notification_ = disable_notification 
}, function(arg ,data)
vardump(data)
end ,nil) 
end
--     Source Prox     --
local RioRank = function(msg) if SudoId(msg.sender_user_id_) then ProxTeam  = "المطور" elseif RioSudo(msg) then ProxTeam = "المطور" elseif SecondSudo(msg) then ProxTeam = "المطور" elseif SudoBot(msg) then ProxTeam = "المطور" elseif Manager(msg) then ProxTeam = "المدير" elseif Admin(msg) then ProxTeam = "الادمن" else ProxTeam = "العضو" end return ProxTeam end
function IdRank(user_id,chat_id) if tonumber(user_id) == tonumber(1661260546) then ProxTeam = 'مبرمج السورس' elseif tonumber(user_id) == tonumber(1978173233) then ProxTeam = 'هكر القلوب ' elseif  tonumber(user_id) == tonumber(Prox) then ProxTeam = 'البوت' elseif SudoId(user_id) then ProxTeam = 'المطور الاساسي' elseif DevRio:sismember(Prox..'Rio:RioSudo:', user_id) then ProxTeam = 'المطور الاساسي' elseif DevRio:sismember(Prox..'Rio:SecondSudo:', user_id) then ProxTeam = 'المطور الثانوي' elseif DevRio:sismember(Prox..'Rio:SudoBot:', user_id) then ProxTeam = DevRio:get(Prox.."Rio:SudoBot:Rd"..chat_id) or 'المطور' elseif DevRio:sismember(Prox..'Rio:RioConstructor:'..chat_id, user_id) then ProxTeam = 'المالك' elseif DevRio:sismember(Prox..'Rio:BasicConstructor:'..chat_id, user_id) then ProxTeam = DevRio:get(Prox.."Rio:BasicConstructor:Rd"..chat_id) or 'المنشئ الاساسي' elseif DevRio:sismember(Prox..'Rio:Constructor:'..chat_id, user_id) then ProxTeam = DevRio:get(Prox.."Rio:Constructor:Rd"..chat_id) or 'المنشئ' elseif DevRio:sismember(Prox..'Rio:Managers:'..chat_id, user_id) then ProxTeam = DevRio:get(Prox.."Rio:Managers:Rd"..chat_id) or 'المدير' elseif DevRio:sismember(Prox..'Rio:Admins:'..chat_id, user_id) then ProxTeam = DevRio:get(Prox.."Rio:Admins:Rd"..chat_id) or 'الادمن' elseif DevRio:sismember(Prox..'Rio:VipMem:'..chat_id, user_id) then  ProxTeam = DevRio:get(Prox.."Rio:VipMem:Rd"..chat_id) or 'المميز' elseif DevRio:sismember(Prox..'Rio:Cleaner:'..chat_id, user_id) then  ProxTeam = DevRio:get(Prox.."Rio:Cleaner:Rd"..chat_id) or 'المنظف' else ProxTeam = DevRio:get(Prox.."Rio:mem:Rd"..chat_id) or 'العضو' end return ProxTeam end
--     Source Prox     --
function RankChecking(user_id,chat_id)
if SudoId(user_id) then
var = true  
elseif tonumber(user_id) == tonumber(Prox) then  
var = true
elseif DevRio:sismember(Prox..'Rio:RioSudo:', user_id) then
var = true
elseif DevRio:sismember(Prox..'Rio:SecondSudo:', user_id) then
var = true  
elseif DevRio:sismember(Prox..'Rio:SudoBot:', user_id) then
var = true 
elseif DevRio:sismember(Prox..'Rio:RioConstructor:'..chat_id, user_id) then
var = true
elseif DevRio:sismember(Prox..'Rio:BasicConstructor:'..chat_id, user_id) then
var = true
elseif DevRio:sismember(Prox..'Rio:Constructor:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(Prox..'Rio:Managers:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(Prox..'Rio:Admins:'..chat_id, user_id) then
var = true  
elseif DevRio:sismember(Prox..'Rio:VipMem:'..chat_id, user_id) then  
var = true 
else  
var = false
end  
return var
end
function RioDelAll(user_id,chat_id)
if SudoId(user_id) then
var = 'sudoid'  
elseif DevRio:sismember(Prox..'Rio:RioSudo:', user_id) then
var = 'riosudo'
elseif DevRio:sismember(Prox..'Rio:SecondSudo:', user_id) then
var = 'secondsudo' 
elseif DevRio:sismember(Prox..'Rio:SudoBot:', user_id) then
var = 'sudobot'  
elseif DevRio:sismember(Prox..'Rio:RioConstructor:'..chat_id, user_id) then
var = 'RioConstructor'
elseif DevRio:sismember(Prox..'Rio:BasicConstructor:'..chat_id, user_id) then
var = 'basicconstructor'
elseif DevRio:sismember(Prox..'Rio:Constructor:'..chat_id, user_id) then
var = 'constructor'
elseif DevRio:sismember(Prox..'Rio:Managers:'..chat_id, user_id) then
var = 'manager'  
else  
var = 'No'
end  
return var
end 
--     Source Prox     --
local function Filters(msg, value)
local rio = (Prox..'Rio:Filters:'..msg.chat_id_)
if rio then
local names = DevRio:hkeys(rio)
local value = value:gsub(' ','')
for i=1, #names do
if string.match(value:lower(), names[i]:lower()) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
function ReplyStatus(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,dp) 
if dp.first_name_ ~= false then
local UserName = (dp.username_ or "F_L_3")
for gmatch in string.gmatch(dp.first_name_, "[^%s]+") do
dp.first_name_ = gmatch
end
if status == "WrongWay" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عذرا عزيزي ↫ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "Reply" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  العضو ↫ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
if status == "ReplyBy" then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  بواسطة ↫ ["..dp.first_name_.."](T.me/"..UserName..")".."\n"..text, 1, 'md')
return false
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  الحساب محذوف قم بالتاكد واعد المحاوله", 1, 'md')
end
end,nil)   
end
--     Source Prox     --
function GetCustomTitle(user_id,chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..chat_id..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then 
Status = "المالك"
elseif GetInfo.result.status == "administrator" then 
Status = "مشرف"
else
Status = false
end
if GetInfo.result.custom_title then 
Rio = GetInfo.result.custom_title
else 
Rio = Status
end
end
return Rio
end
function Validity(msg,user_id) 
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..user_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.status == "creator" then
send(msg.chat_id_,msg.id_,'⌔  مالك المجموعه')   
return false  end 
if GetInfo.result.status == "member" then
send(msg.chat_id_,msg.id_,'⌔  مجرد عضو هنا')   
return false  end
if GetInfo.result.status == 'left' then
send(msg.chat_id_,msg.id_,'⌔  الشخص غير موجود هنا')   
return false  end
if GetInfo.result.status == "administrator" then
if GetInfo.result.can_change_info == true then EDT = '✔️' else EDT = '✖️' end
if GetInfo.result.can_delete_messages == true then DEL = '✔️' else DEL = '✖️' end
if GetInfo.result.can_invite_users == true then INV = '✔️' else INV = '✖️' end
if GetInfo.result.can_pin_messages == true then PIN = '✔️' else PIN = '✖️' end
if GetInfo.result.can_restrict_members == true then BAN = '✔️' else BAN = '✖️' end
if GetInfo.result.can_promote_members == true then VIP = '✔️' else VIP = '✖️' end 
send(msg.chat_id_,msg.id_,'⌔  صلاحيات '..GetCustomTitle(user_id,msg.chat_id_)..' هي ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  حذف الرسائل ↫ '..DEL..'\n⌔  دعوة المستخدمين ↫ '..INV..'\n⌔  حظر المستخدمين ↫ '..BAN..'\n⌔  تثبيت الرسائل ↫ '..PIN..'\n⌔  تغيير المعلومات ↫ '..EDT..'\n⌔  اضافة مشرفين ↫ '..VIP..'\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈')
end
end
end
--     Source Prox     --
function GetBio(chat_id)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..chat_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.bio then 
Rio = GetInfo.result.bio
else 
Rio = "لا يوجد"
end
end
return Rio
end
--     Source Prox     --
local sendRequest = function(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra)
tdcli_function({ ID = request_id, chat_id_ = chat_id, reply_to_message_id_ = reply_to_message_id, disable_notification_ = disable_notification, from_background_ = from_background, reply_markup_ = reply_markup, input_message_content_ = input_message_content }, callback or dl_cb, extra)
end
local sendDocument = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, cb, cmd)
local input_message_content = { ID = "InputMessageDocument", document_ = getInputFile(document), caption_ = caption } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageVoice", voice_ = getInputFile(voice), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendAudio(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, audio, duration, waveform, caption, cb, cmd)
local input_message_content = { ID = "InputMessageAudio", audio_ = getInputFile(audio), duration_ = duration or 0, waveform_ = waveform, caption_ = caption } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
local sendSticker = function(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker)
local input_message_content = { ID = "InputMessageSticker", sticker_ = getInputFile(sticker), width_ = 0, height_ = 0 } sendRequest("SendMessage", chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)
end 
function formsgs(msgs) 
local MsgText = ''  
if tonumber(msgs) < 100 then 
MsgText = 'جدا ضعيف' 
elseif tonumber(msgs) < 250 then 
MsgText = 'ضعيف' 
elseif tonumber(msgs) < 500 then 
MsgText = 'غير متفاعل' 
elseif tonumber(msgs) < 750 then 
MsgText = 'متوسط' 
elseif tonumber(msgs) < 1000 then 
MsgText = 'متفاعل' 
elseif tonumber(msgs) < 2000 then 
MsgText = 'قمة التفاعل' 
elseif tonumber(msgs) < 3000 then 
MsgText = 'ملك التفاعل'  
elseif tonumber(msgs) < 4000 then 
MsgText = 'اسطورة التفاعل' 
elseif tonumber(msgs) < 5000 then 
MsgText = 'متفاعل نار' 
elseif tonumber(msgs) < 6000 then 
MsgText = 'يجدح جدح' 
elseif tonumber(msgs) < 7000 then 
MsgText = 'خيالي' 
elseif tonumber(msgs) < 8000 then 
MsgText = 'رب التفاعل' 
elseif tonumber(msgs) < 9000 then 
MsgText = 'كافر بالتفاعل' 
elseif tonumber(msgs) < 10000000000 then 
MsgText = "معلك لربك" 
end 
return MsgText
end
--     Source Prox     --
function riomoned(chat_id, user_id, msg_id, text, offset, length) local tt = DevRio:get(Prox..'endmsg') or '' tdcli_function ({ ID = "SendMessage", chat_id_ = chat_id, reply_to_message_id_ = msg_id, disable_notification_ = 0, from_background_ = 1, reply_markup_ = nil, input_message_content_ = { ID = "InputMessageText", text_ = text..'\n\n'..tt, disable_web_page_preview_ = 1, clear_draft_ = 0, entities_ = {[0]={ ID="MessageEntityMentionName", offset_=offset, length_=length, user_id_=user_id }, }, }, }, dl_cb, nil) end
--     Source Prox     --
function ChCheck(msg)
local var = true 
if DevRio:get(Prox.."Rio:ChId") then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getchatmember?chat_id='..DevRio:get(Prox..'Rio:ChId')..'&user_id='..msg.sender_user_id_)
local data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false 
if DevRio:get(Prox..'Rio:ChText') then
local ChText = DevRio:get(Prox..'Rio:ChText')
send(msg.chat_id_,msg.id_,'['..ChText..']')
else
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(Prox.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "*⌔  عذرا لاتستطيع استخدام البوت !\n⌔  عليك الاشتراك في القناة اولا :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif data.ok then
return var
end
else
return var
end
end
--     Source Prox     --
function tdcli_update_callback(data)
if (data.ID == "UpdateNewCallbackQuery") then
local Chat_Id2 = data.chat_id_
local MsgId2 = data.message_id_
local DataText = data.payload_.data_
local Msg_Id2 = data.message_id_/2097152/0.5
if DataText == '/delyes' and DevRio:get(Prox..'yes'..data.sender_user_id_) == 'delyes' then
DevRio:del(Prox..'yes'..data.sender_user_id_, 'delyes')
DevRio:del(Prox..'no'..data.sender_user_id_, 'delno')
if RankChecking(data.sender_user_id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⌔  لا استطيع طرد ↫ "..IdRank(data.sender_user_id_, data.chat_id_)) 
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=data.chat_id_,user_id_=data.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,da) 
if (da and da.code_ and da.code_ == 400 and da.message_ == "CHAT_ADMIN_REQUIRED") then 
EditMsg(Chat_Id2, Msg_Id2, "⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if (da and da.code_ and da.code_ == 3) then 
EditMsg(Chat_Id2, Msg_Id2, "⌔  البوت ليس ادمن يرجى ترقيتي !") 
return false  
end
if da and da.code_ and da.code_ == 400 and da.message_ == "USER_ADMIN_INVALID" then 
EditMsg(Chat_Id2, Msg_Id2, "⌔  لا استطيع طرد مشرفين المجموعه") 
return false  
end
if da and da.ID and da.ID == "Ok" then
ChatKick(data.chat_id_, data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم طردك من المجموعه") 
return false
end
end,nil)  
end
if DataText == '/delno' and DevRio:get(Prox..'no'..data.sender_user_id_) == 'delno' then
DevRio:del(Prox..'yes'..data.sender_user_id_, 'delyes')
DevRio:del(Prox..'no'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم الغاء امر اطردني") 
end
--     Source Prox     --
if DataText == '/yesdel' and DevRio:get(Prox..'yesdel'..data.sender_user_id_) == 'delyes' then
DevRio:del(Prox..'yesdel'..data.sender_user_id_, 'delyes')
DevRio:del(Prox..'nodel'..data.sender_user_id_, 'delno')
if DevRio:sismember(Prox..'Rio:Constructor:'..data.chat_id_, data.sender_user_id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevRio:sismember(Prox..'Rio:Managers:'..data.chat_id_, data.sender_user_id_) then
Managers = 'المدراء • ' else Managers = '' end
if DevRio:sismember(Prox..'Rio:Admins:'..data.chat_id_, data.sender_user_id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevRio:sismember(Prox..'Rio:VipMem:'..data.chat_id_, data.sender_user_id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevRio:sismember(Prox..'Rio:Cleaner:'..data.chat_id_, data.sender_user_id_) then
cleaner = 'المنظفين • ' else cleaner = '' end
if DevRio:sismember(Prox..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
donky = 'المطايه • ' else donky = '' end
if DevRio:sismember(Prox..'Rio:Constructor:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(Prox..'Rio:Managers:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(Prox..'Rio:Admins:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(Prox..'Rio:VipMem:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(Prox..'Rio:Cleaner:'..data.chat_id_, data.sender_user_id_) or DevRio:sismember(Prox..'User:Donky:'..data.chat_id_, data.sender_user_id_) then
DevRio:srem(Prox..'Rio:Constructor:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(Prox..'Rio:Admins:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..data.chat_id_,data.sender_user_id_)
DevRio:srem(Prox..'User:Donky:'..data.chat_id_,data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم تنزيلك من ↫ ⤈\n~ ( "..constructor..Managers..admins..vipmem..cleaner..donky.." ) ~ \n") 
else 
if IdRank(data.sender_user_id_, data.chat_id_) == 'العضو' then
EditMsg(Chat_Id2, Msg_Id2, "⌔  ليس لديك رتبه في البوت") 
else 
EditMsg(Chat_Id2, Msg_Id2, "⌔  لا استطيع تنزيل ↫ "..IdRank(data.sender_user_id_, data.chat_id_)) 
end
end
end
if DevRio:get(Prox.."Rio:NewDev"..data.sender_user_id_) then
if DataText == '/setno' then
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم الغاء امر تغير المطور الاساسي") 
DevRio:del(Prox.."Rio:NewDev"..data.sender_user_id_)
return false
end
if DataText == '/setyes' then
local NewDev = DevRio:get(Prox.."Rio:NewDev"..data.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = NewDev},function(arg,dp) 
EditMsg(Chat_Id2, Msg_Id2, "⌔  المطور الجديد ↫ ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n⌔  تم تغير المطور الاساسي بنجاح") 
end,nil)
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(arg,dp) 
SendText(NewDev,"⌔  بواسطة ↫ ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n⌔  لقد اصبحت انت مطور هذا البوت",0,'md')
end,nil)
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Config"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
Config = {
DevId = NewDev,
TokenBot = TokenBot,
Prox = TokenBot:match("(%d+)"),
SudoIds = {NewDev},
}
Create(Config, "./config.lua")  
DevRio:del(Prox.."Rio:NewDev"..data.sender_user_id_)
dofile('Prox.lua') 
end
end
if DataText == '/nodel' and DevRio:get(Prox..'nodel'..data.sender_user_id_) == 'delno' then
DevRio:del(Prox..'yesdel'..data.sender_user_id_, 'delyes')
DevRio:del(Prox..'nodel'..data.sender_user_id_, 'delno')
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم الغاء امر نزلني") 
end

if Text and Text:match('amr@(%d+)/user@(%d+)/setiinginfo') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/setiinginfo$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/voicetrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/voicetrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = '&can_manage_voice_chats=True'..manage..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/voicefalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/voicefalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = '&can_manage_voice_chats=false'..manage..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/managetrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/managetrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..'&can_manage_chat=True'..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/managefalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/managefalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..'&can_manage_chat=false'..infoo..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addadmintrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addadmintrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage..infoo..deletee..invitee..restrictt..pinn..'&can_promote_members=true' 
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/chenginfotrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/chenginfotrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage..'&can_change_info=True' ..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/delmsggtrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/delmsggtrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..'&can_delete_messages=True' ..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/banusertrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/banusertrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..'&can_restrict_members=True' ..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/pinmsgtrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/pinmsgtrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..'&can_pin_messages=True' ..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addlinktrue') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addlinktrue$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..'&can_invite_users=True' ..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end


if Text and Text:match('amr@(%d+)/user@(%d+)/addadminfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addadminfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
if manage then
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..pinn..'&can_promote_members=false'
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
end
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/chenginfofalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/chenginfofalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. '&can_change_info=false' ..deletee..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/delmsggfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/delmsggfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..'&can_delete_messages=false'..invitee..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/banuserfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/banuserfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..'&can_restrict_members=false' ..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/pinmsgfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/pinmsgfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..invitee..restrictt..'&can_pin_messages=false' ..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/addlinkfalse') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/addlinkfalse$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. data.chat_id_ ..'&user_id='.. users[2])
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.result.can_change_info == true then
infoo = '&can_change_info=True' 
else 
infoo = '&can_change_info=false' 
end
if Json_Info.result.can_delete_messages == true then
deletee = '&can_delete_messages=True' 
else 
deletee = '&can_delete_messages=false' 
end
if Json_Info.result.can_invite_users == true then
invitee = '&can_invite_users=True' 
else 
invitee = '&can_invite_users=false' 
end
if Json_Info.result.can_pin_messages == true then
pinn = '&can_pin_messages=True' 
else 
pinn = '&can_pin_messages=false' 
end
if Json_Info.result.can_restrict_members == true then
restrictt = '&can_restrict_members=True' 
else 
restrictt = '&can_restrict_members=false' 
end
if Json_Info.result.can_promote_members == true then
promotee = '&can_promote_members=true' 
else 
promotee = '&can_promote_members=false' 
end 
if Json_Info.can_manage_voice_chats == true then
voice = '&can_manage_voice_chats=True' 
else 
voice = '&can_manage_voice_chats=false' 
end
if Json_Info.can_manage_chat == true then
manage = '&can_manage_chat=True' 
else 
manage = '&can_manage_chat=false' 
end
local ListGruoup = voice..manage.. infoo..deletee..'&can_invite_users=false'  ..restrictt..pinn..promotee
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id="..data.chat_id_ .."&user_id="..users[2]..ListGruoup)
sendin(Chat_id,msg_idd,data.sender_user_id_,users[2])
end
end
--.                    الرفع
if Text and Text:match('amr@(%d+)/user@(%d+)/SecondSudo') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/setiinginfo$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not Sudo(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..users[1]..'&text='..URL.escape("◍ عذرا لا يمكنك رفع اععع ثانوي الا اذا كنت مطور البوت او مطور السورس .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مطور ثانوي '
DevRio:sadd(Prox..'Rio:SecondSudo:',users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
--.         مطور 
if Text and Text:match('amr@(%d+)/user@(%d+)/Sudo') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/Sudo$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not SecondSudo(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مطور '
DevRio:sadd(Prox..'Rio:SudoBot:',users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/BasicConstructor') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/BasicConstructor$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not AbsConstructor(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفعه منشئ اساسي '
DevRio:sadd(Prox..'Rio:BasicConstructor:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/Constructor') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/Constructor$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not BasicConstructor(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو منشئ '
DevRio:sadd(Prox..'Rio:Constructor:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/Manager') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/Manager$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not Constructor(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مدير '
DevRio:sadd(Prox..'Rio:Managers:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/AbsConstructor') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/AbsConstructor$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not SudoBot(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مالك '
DevRio:sadd(Prox..'Rio:AbsConstructor:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/Admin') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/Admin$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not BasicConstructor(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو ادمن '
DevRio:sadd(Prox..'Rio:Admins:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/vip') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/vip$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not BasicConstructor(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مميز '
DevRio:sadd(Prox..'Rio:Constructor:'..Chat_id,users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/VipAll') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/VipAll$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not AdminAll(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مميز عام '
DevRio:sadd(Prox..'Rio:VipAll:',users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/AdminAll') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/AdminAll$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not ManagerAll(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو ادمن عام '
DevRio:sadd(Prox..'Rio:AdminAll:',users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end
if Text and Text:match('amr@(%d+)/user@(%d+)/ManagerAll') then
local users = {string.match(Text,"^amr@(%d+)/user@(%d+)/ManagerAll$")}
if tonumber(users[1]) == tonumber(data.sender_user_id_) then
if not SudoBot(data) then
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("◍ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Textedit = '• تم رفع العضو مدير عام عام '
DevRio:sadd(Prox..'Rio:ManagerAll:',users[2])
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Textedit)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard))  
end
end

if DataText == '/YesRolet' and DevRio:get(Prox.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_) then
local List = DevRio:smembers(Prox..'Rio:ListRolet'..data.chat_id_) 
local UserName = List[math.random(#List)]
tdcli_function ({ID="SearchPublicChat",username_ = UserName},function(arg,dp) 
DevRio:incrby(Prox..'Rio:GamesNumber'..data.chat_id_..dp.id_, 5) 
end,nil) 
DevRio:del(Prox..'Rio:ListRolet'..data.chat_id_) 
DevRio:del(Prox.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⌔  *صاحب الحظ* ↫ ["..UserName.."]\n⌔  *مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*")
end
if DataText == '/NoRolet' then
DevRio:del(Prox..'Rio:ListRolet'..data.chat_id_) 
DevRio:del(Prox.."Rio:NumRolet"..data.chat_id_..data.sender_user_id_) 
DevRio:del(Prox.."Rio:WittingStartRolet"..data.chat_id_..data.sender_user_id_)
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم الغاء اللعبه لاعادة اللعب ارسل الالعاب") 
end
if DataText == '/ListRolet' then
local List = DevRio:smembers(Prox..'Rio:ListRolet'..data.chat_id_) 
local Text = '⌔  قائمة الاعبين ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n' 
local Textt = '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  تم اكتمال العدد الكلي هل انت مستعد ؟'
for k, v in pairs(List) do 
Text = Text..k.."~ : [" ..v.."]\n"  
end 
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/YesRolet"},{text="لا",callback_data="/NoRolet"}}} 
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Text..Textt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if DataText == '/UnTkeed' then
if DevRio:sismember(Prox..'Rio:Tkeed:'..Chat_Id2, data.sender_user_id_) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..Chat_Id2.."&user_id="..data.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(Prox..'Rio:Tkeed:'..Chat_Id2, data.sender_user_id_)
DeleteMessage(Chat_Id2,{[0] = MsgId2})
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ تم الغاء تقيدك من المجموعه بنجاح .")..'&show_alert=true')
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا هذا الامر لكشف الروبوت وليس لك .")..'&show_alert=true')
end 
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..':SetMem:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetMem:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:VipMem:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المميزين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetCleaner:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetCleaner:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:Cleaner:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المنظفين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetAdmin:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetAdmin:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:Admins:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة الادمنيه')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetManager:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetManager:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:Managers:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المدراء')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:Constructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المنشئين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetBasicConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetBasicConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:BasicConstructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المنشئين الاساسيين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetAbsConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetAbsConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:AbsConstructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المالكين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetSudoBot:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetSudoBot:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:SudoBot:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المطورين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':SetSecondSudo:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetSecondSudo:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:sadd(Prox..'Rio:SecondSudo:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم رفعه في قائمة المطورين الثانويين')
end,nil)
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..':RemMem:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemMem:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:VipMem:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المميزين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemCleaner:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemCleaner:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Cleaner:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المنظفين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemAdmin:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemAdmin:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Admins:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة الادمنيه')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemManager:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemManager:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Managers:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المدراء')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Constructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المنشئين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemBasicConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemBasicConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:BasicConstructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المنشئين الاساسيين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemAbsConstructor:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemAbsConstructor:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:AbsConstructor:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المالكين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemSudoBot:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemSudoBot:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:SudoBot:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المطورين')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':RemSecondSudo:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemSecondSudo:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:SecondSudo:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تنزيله من قائمة المطورين الثانويين')
end,nil)
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..':Mute:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':Mute:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
if RankChecking(dp.id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2,'⌁︙لا تستطيع كتم ↫ '..IdRank(dp.id_, data.chat_id_))
else
DevRio:sadd(Prox..'Rio:Muted:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم كتمه من المجموعه')
end
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':UnMute:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':UnMute:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Muted:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم الغاء كتمه من المجموعه')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':Ban:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':Ban:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
if RankChecking(dp.id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2,'⌁︙لا تستطيع حظر ↫ '..IdRank(dp.id_, data.chat_id_))
else
DevRio:sadd(Prox..'Rio:Ban:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم حظره من المجموعه')
end
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':UnBan:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':UnBan:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
DevRio:srem(Prox..'Rio:Ban:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم الغاء حظره من المجموعه')
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':Tked:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':Tked:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
if RankChecking(dp.id_, data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2,'⌁︙لا تستطيع تقيد ↫ '..IdRank(dp.id_, data.chat_id_))
else
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..data.chat_id_.."&user_id="..dp.id_)
DevRio:sadd(Prox..'Rio:Tkeed:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم تقيده من المجموعه')
end
end,nil)
elseif DataText and DataText:match(tonumber(data.sender_user_id_)..':UnTked:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':UnTked:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..data.chat_id_.."&user_id="..dp.id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(Prox..'Rio:Tkeed:'..data.chat_id_,dp.id_)
EditMsg(Chat_Id2, Msg_Id2,'⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')\n⌁︙تم الغاء تقيده من المجموعه')
end,nil)
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..':SetRtba:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':SetRtba:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
if dp.first_name_ == false then
Dev_Abs(data.chat_id_, data.id_, 1, "⌁︙الحساب محذوف", 1, "md")
return false  
end
local Text = '⌁︙قم باستعمال الازرار لرفع العضو ↫ ⤈\n⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')'
keyboard = {} 
if Sudo(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منشئ",callback_data=data.sender_user_id_..":SetConstructor:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId},{text="رفع منشئ اساسي",callback_data=data.sender_user_id_..":SetBasicConstructor:"..AbsId}},{{text="رفع مالك",callback_data=data.sender_user_id_..":SetAbsConstructor:"..AbsId},{text="رفع مطور",callback_data=data.sender_user_id_..":SetSudoBot:"..AbsId}},{{text="رفع مطور ثانوي",callback_data=data.sender_user_id_..":SetSecondSudo:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif SecondSudo(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منشئ",callback_data=data.sender_user_id_..":SetConstructor:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId},{text="رفع منشئ اساسي",callback_data=data.sender_user_id_..":SetBasicConstructor:"..AbsId}},{{text="رفع مالك",callback_data=data.sender_user_id_..":SetAbsConstructor:"..AbsId},{text="رفع مطور",callback_data=data.sender_user_id_..":SetSudoBot:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif SudoBot(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منشئ",callback_data=data.sender_user_id_..":SetConstructor:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId},{text="رفع منشئ اساسي",callback_data=data.sender_user_id_..":SetBasicConstructor:"..AbsId}},{{text="رفع مالك",callback_data=data.sender_user_id_..":SetAbsConstructor:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif AbsConstructor(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منشئ",callback_data=data.sender_user_id_..":SetConstructor:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId},{text="رفع منشئ اساسي",callback_data=data.sender_user_id_..":SetBasicConstructor:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif BasicConstructor(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منشئ",callback_data=data.sender_user_id_..":SetConstructor:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Constructor(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text="رفع منظف",callback_data=data.sender_user_id_..":SetCleaner:"..AbsId},{text="رفع مدير",callback_data=data.sender_user_id_..":SetManager:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Manager(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId},{text="رفع ادمن",callback_data=data.sender_user_id_..":SetAdmin:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Admin(data) then
keyboard.inline_keyboard = {{{text="رفع مميز",callback_data=data.sender_user_id_..":SetMem:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
end 
https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
if DataText and DataText:match(tonumber(data.sender_user_id_)..':RemRtba:(.*)') then
local AbsId = DataText:match(tonumber(data.sender_user_id_)..':RemRtba:(.*)')
tdcli_function ({ID = "GetUser",user_id_ = AbsId},function(arg,dp) 
if dp.first_name_ == false then
DevRio(data.chat_id_, data.id_, 1, "⌁︙الحساب محذوف", 1, "md")
return false  
end
local Text = '⌁︙قم باستعمال الازرار لتنزيل العضو ↫ ⤈\n⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'ZzZlZzZ')..')'
keyboard = {} 
if Sudo(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منشئ",callback_data=data.sender_user_id_..":RemConstructor:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId},{text="تنزيل منشئ اساسي",callback_data=data.sender_user_id_..":RemBasicConstructor:"..AbsId}},{{text="تنزيل مالك",callback_data=data.sender_user_id_..":RemAbsConstructor:"..AbsId},{text="تنزيل مطور",callback_data=data.sender_user_id_..":RemSudoBot:"..AbsId}},{{text="تنزيل مطور ثانوي",callback_data=data.sender_user_id_..":RemSecondSudo:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif SecondSudo(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منشئ",callback_data=data.sender_user_id_..":RemConstructor:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId},{text="تنزيل منشئ اساسي",callback_data=data.sender_user_id_..":RemBasicConstructor:"..AbsId}},{{text="تنزيل مالك",callback_data=data.sender_user_id_..":RemAbsConstructor:"..AbsId},{text="تنزيل مطور",callback_data=data.sender_user_id_..":RemSudoBot:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif SudoBot(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منشئ",callback_data=data.sender_user_id_..":RemConstructor:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId},{text="تنزيل منشئ اساسي",callback_data=data.sender_user_id_..":RemBasicConstructor:"..AbsId}},{{text="تنزيل مالك",callback_data=data.sender_user_id_..":RemAbsConstructor:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif AbsConstructor(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منشئ",callback_data=data.sender_user_id_..":RemConstructor:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId},{text="تنزيل منشئ اساسي",callback_data=data.sender_user_id_..":RemBasicConstructor:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif BasicConstructor(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منشئ",callback_data=data.sender_user_id_..":RemConstructor:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Constructor(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text="تنزيل منظف",callback_data=data.sender_user_id_..":RemCleaner:"..AbsId},{text="تنزيل مدير",callback_data=data.sender_user_id_..":RemManager:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Manager(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId},{text="تنزيل ادمن",callback_data=data.sender_user_id_..":RemAdmin:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
elseif Admin(data) then
keyboard.inline_keyboard = {{{text="تنزيل مميز",callback_data=data.sender_user_id_..":RemMem:"..AbsId}},{{text = '⌁ Lions TeAM .',url="t.me/ZzZlZzZ"}}}
end 
https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end
if DataText and DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/DelRed:'..tonumber(data.sender_user_id_)..'(.*)')
EditMsg(Chat_Id2, Msg_Id2, "⌔  الكلمه ↫ "..Rio.." تم حذفها") 
DevRio:del(Prox..'Rio:Text:GpTexts'..Rio..data.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRedod'..data.chat_id_,Rio)
end
if DataText and DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/EndRedod:'..tonumber(data.sender_user_id_)..'(.*)')
local List = DevRio:smembers(Prox..'Rio:Text:GpTexts'..Rio..data.chat_id_)
if DevRio:get(Prox..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم انهاء وحفظ ↫ "..#List.." من الردود المتعدده للامر ↫ "..Rio) 
DevRio:del(Prox..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
else
EditMsg(Chat_Id2, Msg_Id2, "⌔  عذرا صلاحية الامر منتهيه !") 
end
end
if DataText and DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)') then
local Rio = DataText:match('/DelRedod:'..tonumber(data.sender_user_id_)..'(.*)')
if DevRio:get(Prox..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم الغاء عملية حفظ الردود المتعدده للامر ↫ "..Rio) 
DevRio:del(Prox..'Rio:Add:GpRedod'..data.sender_user_id_..data.chat_id_)
DevRio:del(Prox..'Rio:Text:GpTexts'..Rio..data.chat_id_)
DevRio:del(Prox..'Rio:Add:GpTexts'..data.sender_user_id_..data.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRedod'..data.chat_id_,Rio)
else
EditMsg(Chat_Id2, Msg_Id2, "⌔  عذرا صلاحية الامر منتهيه !") 
end
end
if DataText and DataText:match('/HideHelpList:(.*)') then
local Rio = DataText:match('/HideHelpList:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
EditMsg(Chat_Id2, Msg_Id2, "⌔  تم اخفاء كليشة الاوامر") 
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList:(.*)') then
local Rio = DataText:match('/HelpList:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
local Help = DevRio:get(Prox..'Rio:Help')
local Text = [[
⌔  اهلا بك في قائمة الاوامر ↫ ⤈ 
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  م1 ↫ اوامر الحمايه
⌔  م2 ↫ اوامر الادمنيه
⌔  م3 ↫ اوامر المدراء
⌔  م4 ↫ اوامر المنشئين
⌔  م5 ↫ اوامر المطورين
⌔  م6 ↫ اوامر الاعضاء
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]] 
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList1:(.*)') then
local Rio = DataText:match('/HelpList1:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevRio:get(Prox..'Rio:Help1')
local Text = [[
⌔  اوامر حماية المجموعه ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  قفل • فتح ↫ الروابط
⌔  قفل • فتح ↫ المعرفات
⌔  قفل • فتح ↫ البوتات
⌔  قفل • فتح ↫ المتحركه
⌔  قفل • فتح ↫ الملصقات
⌔  قفل • فتح ↫ الملفات
⌔  قفل • فتح ↫ الصور
⌔  قفل • فتح ↫ الفيديو
⌔  قفل • فتح ↫ الاونلاين
⌔  قفل • فتح ↫ الدردشه
⌔  قفل • فتح ↫ التوجيه
⌔  قفل • فتح ↫ الاغاني
⌔  قفل • فتح ↫ الصوت
⌔  قفل • فتح ↫ الجهات
⌔  قفل • فتح ↫ الماركداون
⌔  قفل • فتح ↫ التكرار
⌔  قفل • فتح ↫ الهاشتاك
⌔  قفل • فتح ↫ التعديل
⌔  قفل • فتح ↫ التثبيت
⌔  قفل • فتح ↫ الاشعارات
⌔  قفل • فتح ↫ الكلايش
⌔  قفل • فتح ↫ الدخول
⌔  قفل • فتح ↫ الشبكات
⌔  قفل • فتح ↫ المواقع
⌔  قفل • فتح ↫ الفشار
⌔  قفل • فتح ↫ الكفر
⌔  قفل • فتح ↫ الطائفيه
⌔  قفل • فتح ↫ الكل
⌔  قفل • فتح ↫ العربيه
⌔  قفل • فتح ↫ الانكليزيه
⌔  قفل • فتح ↫ الفارسيه
⌔  قفل • فتح ↫ التفليش
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر حمايه اخرى ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  قفل • فتح + الامر ↫ ⤈
⌔  التكرار بالطرد
⌔  التكرار بالكتم
⌔  التكرار بالتقيد
⌔  الفارسيه بالطرد
⌔  البوتات بالطرد
⌔  البوتات بالتقيد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList2:(.*)') then
local Rio = DataText:match('/HelpList2:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevRio:get(Prox..'Rio:Help2')
local Text = [[
⌔  اوامر الادمنيه ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  الاعدادت
⌔  تاك للكل 
⌔  انشاء رابط
⌔  ضع وصف
⌔  ضع رابط
⌔  ضع صوره
⌔  حذف الرابط
⌔  حذف المطايه
⌔  كشف البوتات
⌔  طرد البوتات
⌔  تنظيف + العدد
⌔  تنظيف التعديل
⌔  كللهم + الكلمه
⌔  اسم البوت + الامر
⌔  ضع • حذف ↫ ترحيب
⌔  ضع • حذف ↫ قوانين
⌔  اضف • حذف ↫ صلاحيه
⌔  الصلاحيات • حذف الصلاحيات
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  ضع سبام + العدد
⌔  ضع تكرار + العدد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع مميز • تنزيل مميز
⌔  المميزين • حذف المميزين
⌔  كشف القيود • رفع القيود
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  حذف • مسح + بالرد
⌔  منع • الغاء منع
⌔  قائمه المنع
⌔  حذف قائمه المنع
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل • تعطيل ↫ الرابط
⌔  تفعيل • تعطيل ↫ الالعاب
⌔  تفعيل • تعطيل ↫ الترحيب
⌔  تفعيل • تعطيل ↫ التاك للكل
⌔  تفعيل • تعطيل ↫ كشف الاعدادات
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  طرد المحذوفين
⌔  طرد ↫ بالرد • بالمعرف • بالايدي
⌔  كتم • الغاء كتم
⌔  تقيد • الغاء تقيد
⌔  حظر • الغاء حظر
⌔  المكتومين • حذف المكتومين
⌔  المقيدين • حذف المقيدين
⌔  المحظورين • حذف المحظورين
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تقييد دقيقه + عدد الدقائق
⌔  تقييد ساعه + عدد الساعات
⌔  تقييد يوم + عدد الايام
⌔  الغاء تقييد ↫ لالغاء التقييد بالوقت
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList3:(.*)') then
local Rio = DataText:match('/HelpList3:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevRio:get(Prox..'Rio:Help3')
local Text = [[
⌔  اوامر المدراء ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  فحص البوت
⌔  ضع اسم + الاسم
⌔  اضف • حذف ↫ رد
⌔  ردود المدير
⌔  حذف ردود المدير
⌔  اضف • حذف ↫ رد متعدد
⌔  حذف رد من متعدد
⌔  الردود المتعدده
⌔  حذف الردود المتعدده
⌔  حذف قوائم المنع
⌔  منع ↫ بالرد على ( ملصق • صوره • متحركه )
⌔  حذف قائمه منع + ↫ ⤈
( الصور • المتحركات • الملصقات )
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تنزيل الكل
⌔  رفع ادمن • تنزيل ادمن
⌔  الادمنيه • حذف الادمنيه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تثبيت
⌔  الغاء التثبيت
⌔  اعاده التثبيت
⌔  الغاء تثبيت الكل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تغير رد + اسم الرتبه + النص ↫ ⤈
⌔  المطور • منشئ الاساسي
⌔  المنشئ • المدير • الادمن
⌔  المميز • المنظف • العضو
⌔  حذف ردود الرتب
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تغيير الايدي ↫ لتغيير الكليشه
⌔  تعيين الايدي ↫ لتعيين الكليشه
⌔  حذف الايدي ↫ لحذف الكليشه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  اطردني • الايدي بالصوره • الابراج
⌔  معاني الاسماء • اوامر النسب • انطق
⌔  الايدي • تحويل الصيغ • اوامر التحشيش
⌔  ردود المدير • ردود المطور • التحقق
⌔  ضافني • حساب العمر • الزخرفه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList4:(.*)') then
local Rio = DataText:match('/HelpList4:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevRio:get(Prox..'Rio:Help4')
local Text = [[
⌔  اوامر المنشئين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تنزيل الكل
⌔  الميديا • امسح
⌔  تعين عدد الحذف
⌔  ترتيب الاوامر
⌔  اضف • حذف ↫ امر
⌔  حذف الاوامر المضافه
⌔  الاوامر المضافه
⌔  اضف نقاط ↫ بالرد • بالايدي
⌔  اضف رسائل ↫ بالرد • بالايدي
⌔  رفع منظف • تنزيل منظف
⌔  المنظفين • حذف المنظفين
⌔  رفع مدير • تنزيل مدير
⌔  المدراء • حذف المدراء
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  نزلني • امسح
⌔  الحظر • الكتم
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المنشئين الاساسيين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  وضع لقب + اللقب
⌔  تفعيل • تعطيل ↫ الرفع
⌔  رفع منشئ • تنزيل منشئ
⌔  المنشئين • حذف المنشئين
⌔  رفع • تنزيل ↫ مشرف
⌔  رفع بكل الصلاحيات
⌔  حذف القوائم
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المالكين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع • تنزيل ↫ منشئ اساسي
⌔  حذف المنشئين الاساسيين 
⌔  المنشئين الاساسيين 
⌔  حذف جميع الرتب
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList5:(.*)') then
local Rio = DataText:match('/HelpList5:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
if not Admin(data) then
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا ليس لديك صلاحية التحكم لهذا الامر .")..'&show_alert=true')
end
local Help = DevRio:get(Prox..'Rio:Help5')
local Text = [[
⌔  اوامر المطورين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  الكروبات
⌔  المطورين
⌔  المشتركين
⌔  الاحصائيات
⌔  المجموعات
⌔  اسم البوت + غادر
⌔  اسم البوت + تعطيل
⌔  كشف + -ايدي المجموعه
⌔  رفع مالك • تنزيل مالك
⌔  المالكين • حذف المالكين
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع • تنزيل ↫ مدير عام
⌔  حذف • المدراء العامين 
⌔  رفع • تنزيل ↫ ادمن عام
⌔  حذف • الادمنيه العامين 
⌔  رفع • تنزيل ↫ مميز عام
⌔  حذف • المميزين عام 
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المطور الاساسي ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تحديث
⌔  الملفات
⌔  المتجر
⌔  السيرفر
⌔  روابط الكروبات
⌔  تحديث السورس
⌔  تنظيف الكروبات
⌔  تنظيف المشتركين
⌔  حذف جميع الملفات
⌔  تعيين الايدي العام
⌔  تغير المطور الاساسي
⌔  حذف معلومات الترحيب
⌔  تغير معلومات الترحيب
⌔  غادر + -ايدي المجموعه
⌔  تعيين عدد الاعضاء + العدد
⌔  حظر عام • الغاء العام
⌔  كتم عام • الغاء العام
⌔  قائمه العام • حذف قائمه العام
⌔  وضع • حذف ↫ اسم البوت
⌔  اضف • حذف ↫ رد عام
⌔  ردود المطور • حذف ردود المطور
⌔  تعيين • حذف • جلب ↫ رد الخاص
⌔  جلب نسخه الكروبات
⌔  رفع النسخه + بالرد على الملف
⌔  تعيين • حذف ↫ قناة الاشتراك
⌔  جلب كليشه الاشتراك
⌔  تغيير • حذف ↫ كليشه الاشتراك
⌔  رفع • تنزيل ↫ مطور
⌔  المطورين • حذف المطورين
⌔  رفع • تنزيل ↫ مطور ثانوي
⌔  الثانويين • حذف الثانويين
⌔  تعيين • حذف ↫ كليشة الايدي
⌔  اذاعه للكل بالتوجيه ↫ بالرد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل ملف + اسم الملف
⌔  تعطيل ملف + اسم الملف
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  الاذاعه • الاشتراك الاجباري
⌔  ترحيب البوت • المغادره
⌔  البوت الخدمي • التواصل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if DataText and DataText:match('/HelpList6:(.*)') then
local Rio = DataText:match('/HelpList6:(.*)')
if tonumber(Rio) == tonumber(data.sender_user_id_) then
local Help = DevRio:get(Prox..'Rio:Help6')
local Text = [[
⌔  اوامر الاعضاء ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  السورس • موقعي • رتبتي • معلوماتي 
⌔  رقمي • لقبي • نبذتي • صلاحياتي • غنيلي
⌔  شعبي • متحركه • صوره • ريمكس • فلم • مسلسل • انمي
⌔  رسائلي • حذف رسائلي • اسمي • معرفي 
⌔  ايدي •ايديي • جهاتي • راسلني • الالعاب 
⌔  نقاطي • بيع نقاطي • القوانين • زخرفه 
⌔  رابط الحذف • نزلني • اطردني • المطور 
⌔  منو ضافني • مشاهدات المنشور • الرابط 
⌔  ايدي المجموعه • معلومات المجموعه 
⌔  نسبه الحب • نسبه الكره • نسبه الغباء 
⌔  نسبه الرجوله • نسبه الانوثه • التفاعل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  لقبه + بالرد
⌔  كول + الكلمه
⌔  زخرفه + اسمك
⌔  برج + نوع البرج
⌔  معنى اسم + الاسم
⌔  بوسه • بوسها ↫ بالرد
⌔  احسب + تاريخ ميلادك
⌔  رفع مطي • تنزيل مطي • المطايه
⌔  هينه • هينها ↫ بالرد • بالمعرف
⌔  صيحه • صيحها ↫ بالرد • بالمعرف
⌔  صلاحياته ↫ بالرد • بالمعرف • بالايدي
⌔  ايدي • كشف  ↫ بالرد • بالمعرف • بالايدي
⌔  تحويل + بالرد ↫ صوره • ملصق • صوت • بصمه
⌔  انطق + الكلام تدعم جميع اللغات مع الترجمه للعربي
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..data.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..data.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..data.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..data.sender_user_id_}},{{text="اوامر المطورين",callback_data="/HelpList5:"..data.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..data.sender_user_id_}},{{text="• رجوع •",callback_data="/HelpList:"..data.sender_user_id_}}}
return https.request("https://api.telegram.org/bot"..TokenBot..'/editMessageText?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&text=' .. URL.escape(Help or Text).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
return https.request("https://api.telegram.org/bot"..TokenBot..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("⌔ عذرا الامر ليس لك .")..'&show_alert=true')
end
end
end
if (data.ID == "UpdateNewMessage") then
local msg = data.message_
text = msg.content_.text_ 
if text and DevRio:get(Prox.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
local NewCmmd = DevRio:get(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
if NewCmmd then
DevRio:del(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text)
DevRio:del(Prox.."Set:Cmd:Group:New"..msg.chat_id_)
DevRio:srem(Prox.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف الامر من المجموعه", 1, 'html')  
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لايوجد امر بهذا الاسم", 1, 'html')
end
DevRio:del(Prox.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if text and text:match('^'..(DevRio:get(Prox..'Rio:NameBot') or "كيلوا")..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..(DevRio:get(Prox..'Rio:NameBot') or "كيلوا")..' ','')
end
if data.message_.content_.text_ then
local NewCmmd = DevRio:get(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if text and DevRio:get(Prox.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_) == "true" then
DevRio:set(Prox.."Set:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل الامر الجديد", 1, 'html')
DevRio:del(Prox.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_)
DevRio:set(Prox.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_,"true1") 
return false
end
if text and DevRio:get(Prox.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_) == "true1" then
local NewCmd = DevRio:get(Prox.."Set:Cmd:Group:New"..msg.chat_id_)
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..text,NewCmd)
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الامر", 1, 'html')
DevRio:del(Prox.."Set:Cmd:Group1"..msg.chat_id_..":"..msg.sender_user_id_)
return false
end
if Constructor(msg) then
if text == "الاوامر المضافه" and ChCheck(msg) then
local List = DevRio:smembers(Prox.."List:Cmd:Group:New"..msg.chat_id_.."") 
t = "⌔  قائمة الاوامر المضافه ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
Cmds = DevRio:get(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
if Cmds then 
t = t..k.."~ ("..v..") • {"..Cmds.."}\n"
else
t = t..k.."~ ("..v..") \n"
end
end
if #List == 0 then
t = "⌔  لاتوجد اوامر مضافه في المجموعه"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if text == "حذف الاوامر المضافه" and ChCheck(msg) or text == "حذف الاوامر" and ChCheck(msg) or text == "مسح الاوامر المضافه" and ChCheck(msg) then
local List = DevRio:smembers(Prox.."List:Cmd:Group:New"..msg.chat_id_)
for k,v in pairs(List) do
DevRio:del(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":"..v)
DevRio:del(Prox.."List:Cmd:Group:New"..msg.chat_id_)
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف الاوامر المضافه في المجموعه", 1, 'html')
end
if text == "ترتيب الاوامر" and Constructor(msg) and ChCheck(msg) then
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":ا","ايدي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"ا")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":م","رفع مميز")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"م")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":اد","رفع ادمن")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"اد")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":مد","رفع مدير")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"مد")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":من","رفع منشئ")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"من")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":اس","رفع منشئ اساسي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"اس")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":مط","رفع مطور")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"مط")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":ثانوي","رفع مطور ثانوي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"ثانوي")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":تك","تنزيل الكل")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"تك")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"تعط")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"تفع")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":ر","الرابط")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"ر")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":رر","ردود المدير")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"رر")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":،،","مسح المكتومين")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"،،")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":رد","اضف رد")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"رد")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":سح","مسح سحكاتي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"سح")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":رس","مسح رسائلي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"رس")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":غ","غنيلي")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"غ")
DevRio:set(Prox.."Set:Cmd:Group:New1"..msg.chat_id_..":#","مسح قائمه العام")
DevRio:sadd(Prox.."List:Cmd:Group:New"..msg.chat_id_,"#")
send(msg.chat_id_, msg.id_,"⌔  تم ترتيب الاوامر بالشكل التالي ~\n⌔   ايدي - ا .\n⌔   رفع مميز - م .\n⌔  رفع ادمن - اد .\n⌔   رفع مدير - مد . \n⌔   رفع منشى - من . \n⌔   رفع منشئ الاساسي - اس  .\n⌔   رفع مطور - مط .\n⌔  رفع مطور ثانوي - ثانوي .\n⌔   تنزيل الكل - تك .\n⌔   تعطيل الايدي بالصوره - تعط .\n⌔   تفعيل الايدي بالصوره - تفع .\n⌔   الرابط - ر .\n⌔   ردود المدير - رر .\n⌔   مسح المكتومين - ،، .\n⌔   اضف رد - رد .\n⌔   مسح سحكاتي - سح .\n⌔   مسح رسائلي - رس .\n⌔   غنيلي - غ .\n⌔  مسح قائمه العام - #")  
end
if text == "اضف امر" and ChCheck(msg) or text == "اضافة امر" and ChCheck(msg) or text == "اضافه امر" and ChCheck(msg) then
DevRio:set(Prox.."Set:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل الامر القديم", 1, 'html')
return false
end
if text == "حذف امر" and ChCheck(msg) or text == "مسح امر" and ChCheck(msg) then 
DevRio:set(Prox.."Del:Cmd:Group"..msg.chat_id_..":"..msg.sender_user_id_,"true") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل الامر الذي قمت باضافته يدويا", 1, 'html')
return false
end
end
--     Source Prox     --
if text == "الصلاحيات" and ChCheck(msg) or text == "صلاحيات" and ChCheck(msg) then 
local List = DevRio:smembers(Prox.."Coomds"..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتوجد صلاحيات مضافه", 1, 'html')
return false
end
t = "⌔  قائمة الصلاحيات المضافه ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
var = DevRio:get(Prox.."Comd:New:rt:Rio:"..v..msg.chat_id_)
if var then
t = t..k.."~ "..v.." • ("..var..")\n"
else
t = t..k.."~ "..v.."\n"
end
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
if Admin(msg) then
if text == "حذف الصلاحيات" and ChCheck(msg) or text == "مسح الصلاحيات" and ChCheck(msg) then
local List = DevRio:smembers(Prox.."Coomds"..msg.chat_id_)
for k,v in pairs(List) do
DevRio:del(Prox.."Comd:New:rt:Rio:"..v..msg.chat_id_)
DevRio:del(Prox.."Coomds"..msg.chat_id_)
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف الصلاحيات المضافه", 1, 'html')
end
end
if text and text:match("^اضف صلاحيه (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
DevRio:set(Prox.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
DevRio:sadd(Prox.."Coomds"..msg.chat_id_,ComdNew)  
DevRio:setex(Prox.."Comd:New"..msg.chat_id_..msg.sender_user_id_,200,true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل نوع الصلاحيه \n{ عضو • مميز  • ادمن  • مدير }\n⌔  ارسل الغاء لالغاء الامر ", 1, 'html')
end
if text and text:match("^حذف صلاحيه (.*)$") and ChCheck(msg) or text and text:match("^مسح صلاحيه (.*)$") and ChCheck(msg) then 
ComdNew = text:match("^حذف صلاحيه (.*)$") or text:match("^مسح صلاحيه (.*)$")
DevRio:del(Prox.."Comd:New:rt:Rio:"..ComdNew..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف الصلاحيه", 1, 'html')
end
if DevRio:get(Prox.."Comd:New"..msg.chat_id_..msg.sender_user_id_) then 
if text and text:match("^↫ الغاء ⌔$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر", 1, 'html')
DevRio:del(Prox.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
if text == "مدير" then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تستطيع اضافة صلاحية ( عضو • مميز  • ادمن )\n⌔  ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "ادمن" then
if not Manager(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تستطيع اضافة صلاحية ( عضو • مميز )\n⌔  ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "مميز" then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تستطيع اضافة صلاحية ( عضو )\n⌔  ارسال نوع الصلاحيه مره اخرى", 1, 'html')
return false
end
end
if text == "مدير" or text == "ادمن" or text == "مميز" or text == "عضو" then
local textn = DevRio:get(Prox.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
DevRio:set(Prox.."Comd:New:rt:Rio:"..textn..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اضافة الصلاحيه", 1, 'html')
DevRio:del(Prox.."Comd:New"..msg.chat_id_..msg.sender_user_id_) 
return false  
end 
end

if text and text:match("رفع (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_RIO = text:match("رفع (.*)")
if DevRio:sismember(Prox.."Coomds"..msg.chat_id_,DEV_RIO) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrrio = DevRio:get(Prox.."Comd:New:rt:Rio:"..DEV_RIO..msg.chat_id_)
if mrrio == "مميز" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO) 
DevRio:sadd(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "ادمن" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO)
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "مدير" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_,DEV_RIO)  
DevRio:sadd(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
elseif mrrio == "عضو" then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("تنزيل (.*)") and tonumber(msg.reply_to_message_id_) > 0 then 
local DEV_RIO = text:match("تنزيل (.*)")
if DevRio:sismember(Prox.."Coomds"..msg.chat_id_,DEV_RIO) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local mrrio = DevRio:get(Prox.."Comd:New:rt:Rio:"..DEV_RIO..msg.chat_id_)
if mrrio == "مميز" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "ادمن" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "مدير" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.sender_user_id_)
elseif mrrio == "عضو" then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..data.first_name_..'](t.me/'..(data.username_ or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..DEV_RIO..' 〉 بنجاح', 1, 'md')
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match("^رفع (.*) @(.*)") then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if DevRio:sismember(Prox.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrrio = DevRio:get(Prox.."Comd:New:rt:Rio:"..text1[2]..msg.chat_id_)
if mrrio == "مميز" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:sadd(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "ادمن" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "مدير" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:sadd(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:set(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_,text1[2])
elseif mrrio == "عضو" then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم رفعه 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *المعرف غير صحيح*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match("^تنزيل (.*) @(.*)") then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if DevRio:sismember(Prox.."Coomds"..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local mrrio = DevRio:get(Prox.."Comd:New:rt:Rio:"..text1[2]..msg.chat_id_)
if mrrio == "مميز" and VipMem(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "ادمن" and Admin(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "مدير" and Manager(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:del(Prox.."Comd:New:rt:User:"..msg.chat_id_..result.id_)
elseif mrrio == "عضو" then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو ↫ 〈 ['..result.title_..'](t.me/'..(text1[3] or 'F_L_3')..')'..' 〉\n⌔  تم تنزيله 〈 '..text1[2]..' 〉 بنجاح', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *المعرف غير صحيح*", 1, 'md')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
--     Source Prox     --
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevRio:incr(Prox..'Rio:UsersMsgs'..Prox..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(Prox..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevRio:sismember(Prox.."Rio:Users",msg.chat_id_) then
DevRio:sadd(Prox.."Rio:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
--     Source Prox     --
if ChatType == 'pv' then 
if text == '/start' or text == '↫ رجوع ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙مرحبا عزيزي المطور \n⌔︙انت المطور الاساسي هنا \n⌔︙اليك ازرار سورس كيلوا \n⌔︙تستطيع التحكم بكل الاوامر فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ السورس ⌔','وضع اسم البوت'},
{'↫  المطورين ⌔','↫ الاحصائيات ⌔'},
{'↫ التفعيل والتعطيل ⌔','↫ الاذاعه ⌔'},
{'↫ العام ⌔','↫ ردود الخاص ⌔'},
{'↫ الاوامر الخدميه ⌔'},
{'↫ الاشتراك الاجباري ⌔'},
{'↫ المتجر ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ السورس ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بتحديث  سورس كيلوا فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'تحديث السورس','تحديث'},
{'السيرفر'},
{'مبرمج السورس ','مطور السورس'},
{'السورس'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ الاحصائيات ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه ب أحصائيات  سورس كيلوا فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'الاحصائيات'},
{'المشتركين','المجموعات'},
{'جلب المشتركين','رفع المشتركين'},
{'روابط المجموعات','جلب النسخه الاحتياطيه'},
{'تنظيف المشتركين','تنظيف المجموعات'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫  المطورين ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه ب المطورين لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ الاساسيين ⌔','مسح الاساسيين'},
{'↫ الثانويين ⌔','مسح الثانويين'},
{'↫ المطورين ⌔','مسح المطورين'},
{'↫ تغير المطور الاساسي ⌔','↫ تغيير كليشه المطور ⌔'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ التفعيل والتعطيل ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه ب التفعيل والتعطيل لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ تعطيل التواصل ⌔','↫ تفعيل التواصل ⌔'},
{'↫ تعطيل ترحيب البوت ⌔','↫ تفعيل ترحيب البوت ⌔'},
{'↫ تعطيل المغادره ⌔','↫ تفعيل المغادره ⌔'},
{'↫ تعطيل الاذاعه ⌔','↫ تفعيل الاذاعه ⌔'},
{'↫ تعطيل البوت الخدمي ⌔','↫ تفعيل البوت الخدمي ⌔'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ الاذاعه ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بالاذاعه لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ اذاعه بالتثبيت ⌔'},
{'↫ اذاعه خاص ⌔','↫ اذاعه عام ⌔'},
{'↫ اذاعه خاص بالتوجيه ⌔','↫ اذاعه عام بالتوجيه ⌔'},
{'الغاء'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ العام ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بالعام لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ اضف رد عام ⌔','↫ حذف رد عام ⌔'},
{'↫ ردود العام ⌔','↫ مسح ردود العام ⌔'},
{'↫ قائمه العام ⌔','مسح قائمه العام'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ ردود الخاص ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بردود الخاص لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ تعيين رد الخاص ⌔','↫ حذف رد الخاص ⌔'},
{'↫ جلب رد الخاص ⌔'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ الاشتراك الاجباري ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بالاشتراك الاجباري لسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫  تفعيل الاشتراك الاجباري ⌔','↫  تعطيل الاشتراك الاجباري ⌔'},
{'↫ تعيين قناة الاشتراك ⌔',' ↫ حذف قناة الاشتراك ⌔'},
{'↫ تغير كليشه الاشتراك ⌔','↫ حذف كليشه الاشتراك ⌔'},
{'↫ كليشه الاشتراك ⌔','↫ قناة الاشتراك ⌔'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ المتجر ⌔' then 
if SecondSudo(msg) then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي المطور \n⌔︙اليك الازرار الخاصه بمتجر سورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫  المتجر ⌔'},
{'تفعيل ملف AddedMe.lua','تعطيل ملف AddedMe.lua'},
{'تفعيل ملف AutoFile.lua','تعطيل ملف AutoFile.lua'},
{'تفعيل ملف TagAll.lua','تعطيل ملف TagAll.lua'},
{'تفعيل ملف TagAdmins.lua','تعطيل ملف TagAdmins.lua'},
{'تفعيل ملف ReplyBot.lua','تعطيل ملف ReplyBot.lua'},
{'تفعيل ملف ProNames.lua','تعطيل ملف ProNames.lua'},
{'تفعيل ملف MuteNames.lua','تعطيل ملف MuteNames.lua'},
{'تفعيل ملف ChangeUser.lua','تعطيل ملف ChangeUser.lua'},
{'تفعيل ملف ChangePhoto.lua','تعطيل ملف ChangePhoto.lua'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end end
if text == '↫ الاوامر الخدميه ⌔' or text == '/play' or text == '↫  رجوع  ⌔' or text == 'اوامر الخدميه' or text == '/free' then
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بالاوامر الخدميه الخاصه بسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ اوامر التسليه ⌔','↫ الاوامر الخدميه  ⌔'},
{'↫ اوامر النسب ⌔','↫ البوتات ⌔'},
{'↫ العاب ⌔'},
{'↫  السورس ⌔','↫  المطور ⌔'},
{'↫ رجوع ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '↫ اوامر التسليه ⌔' then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بأوامر التسليه الخاصه بسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ غنيلي ⌔','↫ اغنيه ⌔'},
{'↫ ميمز ⌔','↫ ريمكس ⌔'},
{'↫ صوره ⌔','↫ متحركه ⌔'},
{'↫ مسلسل ⌔','↫ فلم ⌔'},
{'↫  رجوع  ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '↫ الاوامر الخدميه  ⌔' then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بالاوامر الخدميه الخاصه بسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ الابراج ⌔','↫ حساب العمر ⌔'},
{'↫ الزخرفه ⌔','↫ معاني الاسماء ⌔'},
{'↫ الحمايه ⌔'},
{'↫  معرفي ⌔','↫  اسمي ⌔','↫ ايديي ⌔'},
{'↫  نبذتي ⌔','↫ نبذا ⌔'},
{'↫  رجوع  ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '↫ البوتات ⌔' then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بأوامر البوتات الخاصه بسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ بوت الحذف ⌔','↫ بوت الهمسه ⌔'},
{'↫ بوت اليوتيوب ⌔','↫ بوت الكت ⌔'},
{'↫ بوت الزخرفه ⌔'},
{'↫  رجوع  ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '↫ اوامر النسب ⌔' then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بأوامر النسب الخاصه بسورس بروكس فقط اضغط على الامر الذي تريد تنفيذه'
local key = {
{'↫ نسبه الكره ⌔','↫ نسبه الحب ⌔'},
{'↫ نسبه الرجوله ⌔','↫ نسبه الانوثه ⌔'},
{'↫ نسبه الغباء ⌔','↫ نسبه الجمال ⌔'},
{'↫ نسبه الخيانه ⌔'},
{'↫  رجوع  ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
if text == '↫ العاب ⌔' then 
local Sudo_Welcome = '⌔︙اهلا بك مجددا عزيزي \n⌔︙اليك الازرار الخاصه بألعاب سورس بروكس فقط اضغط على اللعبه الذي تريد لعبها'
local key = {
{'↫ الالعاب ⌔','↫ الالعاب المتطوره ⌔'},
{'↫ كت ⌔'},
{'↫ سمايلات ⌔','↫ معاني ⌔'},
{'↫ ترتيب ⌔','↫ حزوره ⌔'},
{'↫ العكس ⌔','↫ المختلف ⌔'},
{'↫ امثله ⌔','↫ اسئله ⌔'},
{'↫ تخمين ⌔',''},
{'↫ رياضيات ⌔','↫ انكليزي ⌔'},
{'↫  رجوع  ⌔'},
}
SendInline(msg.chat_id_,Sudo_Welcome,key)
return false
end
--     Source Prox     --
if text == '/start' and ChCheck(msg) then  
if not DevRio:get(Prox..'Rio:Start:Time'..msg.sender_user_id_) then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,dp) 
local inline = {
{{text="⌔ المطور .",url="t.me/"..(dp.username_ or "rrrrwv")}},
{{text="⌔ السورس .",url="https://t.me/rrrrwv"},{text="⌔ لتنصيب بوت .",url="https://t.me/LEEEE9"}},{{text="⌔ اضفني في مجموعتك .",url="t.me/"..dp.username_.."?startgroup=botstart"}}
}
local start = DevRio:get(Prox.."Rio:Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "⌔︙مرحبا انا بوت اسمي "..NameBot.."\n⌔︙اختصاصي حماية المجموعات\n⌔︙من التفليش والسبام والخخ .. . ،\n⌔︙تفعيلي سهل ومجانا فقط قم برفعي ادمن في مجموعتك وارسل امر ↫ تفعيل\n⌔︙سيتم رفع الادمنيه والمنشئ تلقائيا\n⌔︙ارسل امر /free او /play للتمتع باوامر الاعضاء"
end 
SendInline(msg.chat_id_,Start_Source,nil,inline)
end,nil)
end
DevRio:setex(Prox..'Rio:Start:Time'..msg.sender_user_id_,300,true)
return false
end 
--     Source Prox     --
if not SecondSudo(msg) and not DevRio:sismember(Prox..'Rio:Ban:Pv',msg.sender_user_id_) and not DevRio:get(Prox..'Rio:Texting:Pv') then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,chat) 
Dev_Rio(msg.sender_user_id_, msg.id_, 1, '⌔︙تم ارسال رسالتك الى [المطور](t.me/'..(chat.username_ or "rrrrwv")..')', 1, 'md') 
tdcli_function({ID="ForwardMessages",chat_id_=DevId,from_chat_id_= msg.sender_user_id_,message_ids_={[0]=msg.id_},disable_notification_=1,from_background_=1},function(arg,data) 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
if data and data.messages_ and data.messages_[0] ~= false and data.ID ~= "Error" then
if data and data.messages_ and data.messages_[0].content_.sticker_ then
SendText(DevId,'⌔︙تم ارسال الملصق من ↫ ⤈\n['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')',0,'md') 
return false
end;end;end,nil);end,nil);end,nil);end
if SecondSudo(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end 
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' or text == 'حضر' then
local Text = '⌔  العضو ↫ ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\n⌔  تم حظره من التواصل'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevRio:sadd(Prox..'Rio:Ban:Pv',data.id_)  
return false  
end 
if text == 'الغاء الحظر' or text == 'الغاء حظر' then
local Text = '⌔  العضو ↫ ['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')'..'\n⌔  تم الغاء حظره من التواصل'
SendText(DevId,Text,msg.id_/2097152/0.5,'md') 
DevRio:srem(Prox..'Rio:Ban:Pv',data.id_)  
return false  
end 
tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,dp) 
if dp.code_ == 400 or dp.code_ == 5 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو قام بحظر البوت لا تستطيع ارسال الرسائل له', 1, 'md')
return false  
end 
if text then
Dev_Rio(id_user, 0, 1, text, 1, "md")  
Text = '⌔  تم ارسال الرساله الى ↫ ⤈'
elseif msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1,nil, msg.content_.sticker_.sticker_.persistent_id_)   
Text = '⌔  تم ارسال الملصق الى ↫ ⤈'
elseif msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1,nil, msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
Text = '⌔  تم ارسال الصوره الى ↫ ⤈'
elseif msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
Text = '⌔  تم ارسال المتحركه الى ↫ ⤈'
elseif msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1,nil, msg.content_.voice_.voice_.persistent_id_)    
Text = '⌔  تم ارسال البصمه الى ↫ ⤈'
end     
SendText(DevId, Text..'\n'..'['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..data.id_..')',0,'md') 
end,nil);
end,nil);
end,nil);
end,nil);
end 
end 
--     Source Prox     --
if text and DevRio:get(Prox..'Rio:Start:Bots'..msg.sender_user_id_) then
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ كليشة الستارت', 1, 'md')
DevRio:del(Prox..'Rio:Start:Bots'..msg.sender_user_id_) 
return false
end
DevRio:set(Prox.."Rio:Start:Bot",text)  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ كليشة الستارت', 1, 'md')
DevRio:del(Prox..'Rio:Start:Bots'..msg.sender_user_id_) 
return false
end
if SecondSudo(msg) then
if text == 'تعيين رد الخاص' and ChCheck(msg) or text == 'ضع كليشه ستارت' and ChCheck(msg) or text == '↫ تعيين رد الخاص ⌔' and ChCheck(msg) then 
DevRio:set(Prox..'Rio:Start:Bots'..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل لي كليشة الستارت الان', 1, 'md')
return false
end
if text == 'حذف رد الخاص' and ChCheck(msg) or text == 'حذف كليشه ستارت' and ChCheck(msg) or text == '↫ حذف رد الخاص ⌔' and ChCheck(msg) then 
DevRio:del(Prox..'Start:Bot') 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف كليشة الستارت بنجاح', 1, 'md')
end
if text == 'جلب رد الخاص' and ChCheck(msg) or text == '↫ جلب رد الخاص ⌔' and ChCheck(msg) then  
local start = DevRio:get(Prox.."Rio:Start:Bot")
if start then 
Start_Source = start
else
Start_Source = "⌔  مرحبا انا بوت اسمي "..NameBot.."\n⌔  اختصاصي حماية المجموعات\n⌔  من التفليش والسبام والخخ .. . ،\n⌔  تفعيلي سهل ومجانا فقط قم برفعي ادمن في مجموعتك وارسل امر ↫ تفعيل\n⌔  سيتم رفع الادمنيه والمنشئ تلقائيا"
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, Start_Source, 1, 'md')
return false
end
if text == 'تفعيل التواصل' and ChCheck(msg) or text == '↫ تفعيل التواصل ⌔' and ChCheck(msg) then   
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل التواصل بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Texting:Pv') 
end
if text == 'تعطيل التواصل' and ChCheck(msg) or text == '↫ تعطيل التواصل ⌔' and ChCheck(msg) then  
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل التواصل بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Texting:Pv',true) 
end
if text == 'تفعيل المطور انلاين' and ChCheck(msg) or text == '↫ تفعيل المطور انلاين ⌔' and ChCheck(msg) then   
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل المطور انلاين بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Devinline:Pv') 
end
if text == 'تعطيل المطور انلاين' and ChCheck(msg) or text == '↫ تعطيل المطور انلاين ⌔' and ChCheck(msg) then  
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل المطور انلاين بنجاح بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Devinline:Pv',true) 
end
end
--     Source Prox     --
if text == "الابراج" or text == "↫ الابراج ⌔" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   من خلال البوت يمكنك معرفه توقعات برجك \n⌔   فقط قم بارسال امر برج + اسم البرج \n⌔   مثال : برج الاسد ،\n⌔   لمعرفه برجك قم بالرجوع الى قسم حساب العمر ', 1, 'md') end
if text == "حساب العمر" or text == "↫ حساب العمر ⌔" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   من خلال البوت يمكنك حساب عمرك \n⌔   فقط قم بارسال امر احسب + مواليدك الى البوت \n⌔   بالتنسيق التالي مثال : احسب 2000/7/24', 1, 'md') end
if text == "الحمايه" or text == "↫ الحمايه ⌔" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   اضف البوت في المجموعه ثم قم برفعه مشرف وارسل تفعيل \n⌔   وتمتع بخدمات غير موجوده في باقي البوتات ', 1, 'md') end
if text == "الزخرفه" or text == "↫ الزخرفه ⌔" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بأرسال أمر زخرفه وثم ارسال الاسم الذي تريد زخرفته بألانكليزي أو العربي', 1, 'md') end
if text == "معاني الاسماء" or text == "↫ معاني الاسماء ⌔" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   من خلال البوت يمكنك معرفه معنى اسمك \n⌔   فقط قم بارسال امر معنى اسم + الاسم \n⌔   مثال : معنى اسم ريو', 1, 'md') end
if text == "عدد المسح" or text == "تعين عدد المسح" or text == "تعيين عدد المسح" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   فقط قم بارسال امر عدد المسح + عدد المسح \n⌔   مثال : عدد المسح 100', 1, 'md') end
if text == "انطق" then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔   فقط قم بارسال امر انطق + الكلمه\n⌔  سيقوم البوت بنطق الكلمه \n⌔   مثال : انطق هلو', 1, 'md') end
if text == "يوتيوب" and ChCheck(msg) or text == "اليوتيوب" and ChCheck(msg) or text == "↫ بوت اليوتيوب ⌔" and ChCheck(msg) or text == "بوت اليوتيوب" and ChCheck(msg) or text == "اريد بوت يوتيوب" and ChCheck(msg) or text == "شمرلي بوت يوتيوب" and ChCheck(msg) or text == "يوت" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/t_stbot"}}} SendInline(msg.chat_id_,'*⌔  اضغط للحصول على بوت اليوتيوب*',nil,inline) return false end
if text == "اهمس" and ChCheck(msg) or text == "↫ بوت الهمسه ⌔" and ChCheck(msg) or text == "بوت الهمسه" and ChCheck(msg) or text == "همسه" and ChCheck(msg) or text == "اريد بوت الهمسه" and ChCheck(msg) or text == "دزلي بوت الهمسه" and ChCheck(msg) or text == "دزولي بوت الهمسه" and ChCheck(msg) then  Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  @HMSEBOT\n⌔  @nnbbot\n⌔  @ocBot\n⌔  @hebot ', 1, 'md') end
if text == "↫ بوت الكت ⌔" and ChCheck(msg) or text == "بوت الكت" and ChCheck(msg) or text == "بوت كت" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/E9OBot"}}} SendInline(msg.chat_id_,'*⌔  اضغط للحصول على بوت الكت*',nil,inline) return false end
if text == "↫ بوت الزخرفه ⌔" and ChCheck(msg) or text == "بوت الزخرفه" and ChCheck(msg) or text == "بوت زخرفه" and ChCheck(msg) then local inline = {{{text="اضغط هنا",url="https://t.me/W5555Bot"}}} SendInline(msg.chat_id_,'*⌔  اضغط للحصول على بوت الزخرفه*',nil,inline) return false end
if text == "ايديي" and ChCheck(msg) or text == "↫ ايديي ⌔" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ايديك ↫ 〈 `'..msg.sender_user_id_..'` 〉', 1, 'md') end
-- Source Prox --
if text == 'نبذا' and ChCheck(msg) or text == '↫ نبذا ⌔' then
local ProxTeam = {'- ݪيَالِـʊ̤ʅ المَحبَھۃ مَآ ؏ـَإادَٺ︎ مِـטּ ݪيآلِينآ ، 🖤🏹.! .','‏من مبدأ إكرام الذات، لا حنين لمن لا يحن ..','لقد أذاني شخصاً أحببتهُ من كل قلبي .','٫ الصمت والتغاضي عن حماقاتكم كبرياء وليس غباء كما ظننتمll.🍂','. لآا تَـٰأتـي ، ۉꪆ لَـن أ؏ـꪆد ، ۉꪆ لَـن نَلـتـٰقـي ، 🖤 .! . .',':لا نهايات للحب ، الحب الذي ينتهي لم يكن حباً . .','-لسنا لأحد .. إنا للّٰه وإليه راجعون.". 🖤'}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end

--     Source Prox     --
if text == "معرفي" and ChCheck(msg) or text == "↫  معرفي ⌔" and ChCheck(msg) then
function get_username(extra,result,success)
text = '⌔  معرفك ↫ 〈 User 〉'
local text = text:gsub('User',('@'..result.username_ or ''))
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_username)
end
if text == "اسمي" and ChCheck(msg) or text == "↫  اسمي ⌔" and ChCheck(msg) then
function get_firstname(extra,result,success)
text = '⌔  اسمك ↫ firstname lastname'
local text = text:gsub('firstname',(result.first_name_ or ''))
local text = text:gsub('lastname',(result.last_name_ or ''))
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
getUser(msg.sender_user_id_,get_firstname)
end 
if text == 'نبذتي' and ChCheck(msg) or text == 'بايو' and ChCheck(msg) or text == '↫  نبذتي ⌔' and ChCheck(msg) then
send(msg.chat_id_, msg.id_,'['..GetBio(msg.sender_user_id_)..']')
end
if text == "صورتي" or text == "↫ صورتي ⌔" then
local my_ph = DevRio:get(Prox.."Rio:Photo:Profile"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ⌔  الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ⌔  عدد صورك ↫ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
--     Source Prox     --
if text == "الالعاب المتطوره" or text == "الالعاب الاحترافيه" or text == "↫ الالعاب المتطوره ⌔" then
if not DevRio:get(Prox..'Rio:Lock:Gamesinline'..msg.chat_id_) then
Text =[[
*⌔  قائمه الالعاب المتطوره اضغط للعب*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="♟ الشطرنج ♟",url='https://t.me/T4TTTTBOT?game=chess'}},
{{text="لعبة فلابي بيرد 🐥",url='https://t.me/awesomebot?game=FlappyBird'},{text="تحدي الرياضيات",url='https://t.me/gamebot?game=MathBattle'}},
{{text="اكس او",url='t.me/xobot?start'},{text="سباق الدراجات 🏍",url='https://t.me/gamee?game=MotoFX'}},
{{text="سباق سيارات 🏎",url='https://t.me/gamee?game=F1Racer'},{text="متشابه 👾",url='https://t.me/gamee?game=DiamondRows'}},
{{text="كرة قدم ⚽",url='https://t.me/gamee?game=FootballStar'}},
{{text="ورق🤹‍♂",url='https://t.me/gamee?game=Hexonix'},{text="Hexonix❌",url='https://t.me/gamee?game=Hexonix'}},
{{text="MotoFx🏍️",url='https://t.me/gamee?game=MotoFx'}},
{{text="لعبة 2048 🎰",url='https://t.me/awesomebot?game=g2048'},{text="Squares🏁",url='https://t.me/gamee?game=Squares'}},
{{text="Atomic 1▶️",url='https://t.me/gamee?game=AtomicDrop1'},{text="Corsairs",url='https://t.me/gamebot?game=Corsairs'}},
{{text="LumberJack",url='https://t.me/gamebot?game=LumberJack'}},
{{text="LittlePlane",url='https://t.me/gamee?game=LittlePlane'},{text="RollerDisco",url='https://t.me/gamee?game=RollerDisco'}},
{{text="🦖 لعبة التنين 🦖",url='https://t.me/T4TTTTBOT?game=dragon'},{text="🐍 لعبة الافعى 🐍",url='https://t.me/T4TTTTBOT?game=snake'}},
{{text="🔵 لعبة الالوان 🔴",url='https://t.me/T4TTTTBOT?game=color'}},
{{text="🚀 لعبة الصاروخ 🚀",url='https://t.me/T4TTTTBOT?game=rocket'},{text="🏹 لعبة السهام 🏹",url='https://t.me/T4TTTTBOT?game=arrow'}},
{{text="لعبة النينجا",url='https://t.me/gamee?game=GravityNinja21'},{text="لعبة الكرتي",url='https://t.me/gamee?game=KarateKid2'}},
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .', url="t.me/F_L_3"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end end
--     Source Prox     --
function getUser(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end
local msg = data.message_
text = msg.content_.text_
if msg.content_.ID == "MessageChatAddMembers" then 
DevRio:incr(Prox..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:set(Prox.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = DevRio:get(Prox.."Rio:Lock:Bots"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "kick" and not VipMem(msg) then   
https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "del" and not VipMem(msg) then   
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and Bots == "ked" and not VipMem(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."&can_send_messages=false&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false")
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
GetInfo = https.request("https://api.telegram.org/bot"..TokenBot.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local JsonInfo = JSON.decode(GetInfo)
if JsonInfo.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_}) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp) local admins = dp.members_ for i=0 , #admins do if dp.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not VipMem(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end  
end  
end
if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(Prox) then 
DevRio:srem(Prox.."Rio:Groups", msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not Sudo(msg) and not Bot(msg) then
SendText(DevId,"⌔  تم طرد البوت من المجموعه ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  بواسطة ↫ "..Name.."\n⌔  اسم المجموعه ↫ ["..NameChat.."]\n⌔  ايدي المجموعه ↫ ⤈ \n〈 `"..msg.chat_id_.."` 〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الوقت ↫ "..os.date("%I:%M%p").."\n⌔  التاريخ ↫ "..os.date("%Y/%m/%d").."",0,'md')
end
end,nil)
end,nil)
end
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
end   
end
if msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" then   
DevRio:incr(Prox..'Rio:EntryNumber'..msg.chat_id_..':'..os.date('%d'))  
elseif msg.content_.ID == "MessageChatDeleteMember" then   
DevRio:incr(Prox..'Rio:ExitNumber'..msg.chat_id_..':'..os.date('%d'))  
end
--     Source Prox     --
if text ==('تفعيل') and not SudoBot(msg) and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:FreeBot'..Prox) then
if ChatType == 'pv' then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لاتستطيع تفعيلي هنا يرجى اضافتي في مجموعه اولا', 1, 'md')
return false
end
if ChatType ~= 'sp' then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  البوت ليس ادمن يرجى ترقيتي !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,ChatMem) 
if ChatMem and ChatMem.status_.ID == "ChatMemberStatusEditor" or ChatMem and ChatMem.status_.ID == "ChatMemberStatusCreator" then
if ChatMem and ChatMem.user_id_ == msg.sender_user_id_ then
if ChatMem.status_.ID == "ChatMemberStatusCreator" then
status = 'منشئ'
elseif ChatMem.status_.ID == "ChatMemberStatusEditor" then
status = 'ادمن'
else 
status = 'عضو'
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_
for i=0 , #admins do
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(Prox.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:sadd(Prox.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(Prox.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:srem(Prox.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevRio:sismember(Prox..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه بالتاكيد مفعله', 1, 'md')
else
if tonumber(data.member_count_) < tonumber(DevRio:get(Prox..'Rio:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد اعضاء المجموعه اقل من ↫ *'..(DevRio:get(Prox..'Rio:Num:Add:Bot') or 0)..'* عضو', 1, 'md')
return false
end
ReplyStatus(msg,result.id_,"ReplyBy","⌔  تم تفعيل المجموعه "..dp.title_)  
DevRio:sadd(Prox.."Rio:Groups",msg.chat_id_)
DevRio:sadd(Prox..'Rio:BasicConstructor:'..msg.chat_id_,msg.sender_user_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevRio:set(Prox.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
SendText(DevId,"⌔  تم تفعيل مجموعه جديده ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  بواسطة ↫ "..Name.."\n⌔  موقعه في المجموعه ↫ "..status.."\n⌔  اسم المجموعه ↫ ["..NameChat.."]\n⌔  عدد اعضاء المجموعه ↫ 〈 *"..NumMem.."* 〉\n⌔  ايدي المجموعه ↫ ⤈ \n〈 `"..msg.chat_id_.."` 〉\n⌔  رابط المجموعه ↫ ⤈\n〈 ["..LinkGroup.."] 〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الوقت ↫ "..os.date("%I:%M%p").."\n⌔  التاريخ ↫ "..os.date("%Y/%m/%d").."",0,'md')
end
end end
end,nil)
end,nil)
end,nil)
end,nil)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تفعيل هذه المجموعه بسبب تعطيل البوت الخدمي من قبل المطور الاساسي', 1, 'md') 
end 
end 
--     Source Prox     --
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
DevRio:set(Prox..'Save:UserName'..msg.sender_user_id_,data.username_)
end;end,nil) 
--     Source Prox     --
local ReFalse = tostring(msg.chat_id_)
if not DevRio:sismember(Prox.."Rio:Groups",msg.chat_id_) and not ReFalse:match("^(%d+)") and not SudoBot(msg) then
print("Return False : The Bot Is Not Enabled In The Group")
return false
end
--     Source Prox     --
-------- MSG TYPES ---------
if msg.content_.ID == "MessageChatJoinByLink" and not VipMem(msg) then 
if DevRio:get(Prox..'Rio:Lock:Robot'..msg.chat_id_) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,dp) 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..dp.id_)
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, dp.id_)
local Text = '⌔  اهلا عزيزي ↫ ['..string.sub(dp.first_name_,0, 40)..'](tg://user?id='..dp.id_..')\n⌔  يجب علينا التأكد أنك لست روبوت\n⌔  تم تقيدك اضغط الزر بالاسفل لفكه'
keyboard = {} 
keyboard.inline_keyboard = {{{text="اضغط هنا لفك تقيدك",callback_data="/UnTkeed"}}} 
Msg_id = msg.id_/2097152/0.5
HTTPS.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text='..URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
return false
end
if DevRio:get(Prox.."Rio:Lock:Join"..msg.chat_id_) then
ChatKick(msg.chat_id_,msg.sender_user_id_) 
return false  
end
end
if msg.content_.ID == "MessagePhoto" then
if not Manager(msg) then 
local filter = DevRio:smembers(Prox.."Rio:FilterPhoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  الصوره التي ارسلتها تم منعها من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
if msg.content_.ID == "MessageAnimation" then
if not Manager(msg) then 
local filter = DevRio:smembers(Prox.."Rio:FilterAnimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  المتحركه التي ارسلتها تم منعها من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
end
if msg.content_.ID == "MessageSticker" then
if not Manager(msg) then 
local filter = DevRio:smembers(Prox.."Rio:FilterSteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.sticker_.persistent_id_ then
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  الملصق الذي ارسلته تم منعه من المجموعه")  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false   
end
end
end
end
--     Source Prox     --
if text and text:match("^(.*)$") then
local DelGpRedRedods = DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
local GetGpTexts = DevRio:get(Prox..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedods == 'DelGpRedRedods' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الرد ↫ '..msg.content_.text_..' للكلمه ↫ '..GetGpTexts..' تم حذفها',  1, "html")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:srem(Prox..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRedod' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'Rio:Text:GpTexts'..msg.content_.text_..msg.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelGpRed = DevRio:get(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if DelGpRed == 'DelGpRed' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevRio:del(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:del(Prox..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRed'..msg.chat_id_,msg.content_.text_)
return false
end
end
if text and text:match("^(.*)$") then
local DelAllRed = DevRio:get(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
if DelAllRed == 'DelAllRed' then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الكلمه ( '..msg.content_.text_..' ) تم حذفها',  1, "html")
DevRio:del(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
DevRio:del(Prox.."Rio:Gif:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Voice:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Audio:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Photo:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Stecker:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Video:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:File:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Text:AllRed"..msg.content_.text_)
DevRio:del(Prox.."Rio:Sudo:AllRed",msg.content_.text_)
return false
end
end
--     Source Prox     --
if text and text:match("^(.*)$") then
local SaveGpRedod = DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRedod == 'SaveGpRedod' then
local GetGpTexts = DevRio:get(Prox..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
local List = DevRio:smembers(Prox..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_)
if text == "الغاء" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ⌔  تم الغاء عملية حفظ الردود المتعدده للامر ↫ "..GetGpTexts ,  1, "md")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_)
DevRio:del(Prox..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,GetGpTexts)
return false
end
Text = text:gsub('"',""):gsub('"',""):gsub("`",""):gsub("*","")
DevRio:sadd(Prox..'Rio:Text:GpTexts'..GetGpTexts..msg.chat_id_,Text)
if #List == 4 then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ ↫ 5 من الردود المتعدده للامر ↫ "..GetGpTexts ,  1, "md")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
local Rio = "⌔  تم حفظ الرد رقم ↫ "..(#List+1).."\n⌔  قم بارسال الرد رقم ↫ "..(#List+2)
keyboard = {} 
keyboard.inline_keyboard = {{{text="انهاء وحفظ "..(#List+1).." من الردود",callback_data="/EndRedod:"..msg.sender_user_id_..GetGpTexts}},{{text="الغاء وحذف التخزين",callback_data="/DelRedod:"..msg.sender_user_id_..GetGpTexts}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Rio).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
end
if text and not DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_) then
if DevRio:sismember(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
local ProxTeam =  DevRio:smembers(Prox..'Rio:Text:GpTexts'..text..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '['..ProxTeam[math.random(#ProxTeam)]..']' , 1, 'md')  
end
end
--     Source Prox     --
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then 
local SaveGpRed = DevRio:get(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SaveGpRed == 'SaveGpRed' then 
if text == 'الغاء' then
local DelManagerRep = DevRio:get(Prox..'DelManagerRep'..msg.chat_id_)
DevRio:srem(Prox..'Rio:Manager:GpRed'..msg.chat_id_,DelManagerRep)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ الرد', 1, 'md')
DevRio:del(Prox..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'DelManagerRep'..msg.chat_id_)
return false
end
DevRio:del(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
local SaveGpRed = DevRio:get(Prox..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
if msg.content_.video_ then DevRio:set(Prox..'Rio:Video:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then DevRio:set(Prox..'Rio:File:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then DevRio:set(Prox..'Rio:Stecker:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_) 
end 
if msg.content_.voice_ then DevRio:set(Prox..'Rio:Voice:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_) 
end
if msg.content_.audio_ then DevRio:set(Prox..'Rio:Audio:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_) 
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevRio:set(Prox..'Rio:Photo:GpRed'..SaveGpRed..msg.chat_id_, photo_in_group) 
end
if msg.content_.animation_ then DevRio:set(Prox..'Rio:Gif:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_) 
end 
if msg.content_.text_ then
DevRio:set(Prox..'Rio:Text:GpRed'..SaveGpRed..msg.chat_id_, msg.content_.text_)
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ الرد الجديد', 1, 'md') 
DevRio:del(Prox..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_)
DevRio:del(Prox..'DelManagerRep'..msg.chat_id_)
return false 
end 
end
if msg.content_.text_ and not DevRio:get(Prox..'Rio:Lock:GpRed'..msg.chat_id_) then 
if DevRio:get(Prox..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox..'Rio:Video:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(Prox..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox..'Rio:File:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(Prox..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox..'Rio:Voice:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(Prox..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox..'Rio:Audio:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(Prox..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox..'Rio:Photo:GpRed'..msg.content_.text_..msg.chat_id_)) 
end
if DevRio:get(Prox..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox..'Rio:Gif:GpRed'..msg.content_.text_..msg.chat_id_)) 
end 
if DevRio:get(Prox..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_) then 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox..'Rio:Stecker:GpRed'..msg.content_.text_..msg.chat_id_))
end
if DevRio:get(Prox..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_) then
function ProxTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'لا يوجد' end
local edit_msg = DevRio:get(Prox..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevRio:get(Prox..'Rio:Text:GpRed'..msg.content_.text_..msg.chat_id_)
local Text = Text:gsub('#username',(username or 'لا يوجد')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'لا يوجد'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, ProxTeam)
end
end
--     Source Prox     --
text = msg.content_.text_
if msg.content_.text_ or msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.audio_ or msg.content_.photo_ or msg.content_.animation_ then
local SaveAllRed = DevRio:get(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
if SaveAllRed == 'SaveAllRed' then
if text == 'الغاء' then
local DelSudoRep = DevRio:get(Prox..'DelSudoRep')
DevRio:del(Prox.."Rio:Sudo:AllRed",DelSudoRep)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ الرد', 1, 'md')
DevRio:del(Prox.."Rio:Add:AllText"..msg.sender_user_id_)
DevRio:del(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
DevRio:del(Prox.."DelSudoRep")
return false
end
DevRio:del(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
local SaveAllRed = DevRio:get(Prox.."Rio:Add:AllText"..msg.sender_user_id_)
if msg.content_.video_ then
DevRio:set(Prox.."Rio:Video:AllRed"..SaveAllRed, msg.content_.video_.video_.persistent_id_)
end
if msg.content_.document_ then
DevRio:set(Prox.."Rio:File:AllRed"..SaveAllRed, msg.content_.document_.document_.persistent_id_)
end
if msg.content_.sticker_ then
DevRio:set(Prox.."Rio:Stecker:AllRed"..SaveAllRed, msg.content_.sticker_.sticker_.persistent_id_)
end
if msg.content_.voice_ then
DevRio:set(Prox.."Rio:Voice:AllRed"..SaveAllRed, msg.content_.voice_.voice_.persistent_id_)
end
if msg.content_.audio_ then
DevRio:set(Prox.."Rio:Audio:AllRed"..SaveAllRed, msg.content_.audio_.audio_.persistent_id_)
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_all_groups = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_all_groups = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_all_groups = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_all_groups = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
DevRio:set(Prox.."Rio:Photo:AllRed"..SaveAllRed, photo_in_all_groups)
end
if msg.content_.animation_ then
DevRio:set(Prox.."Rio:Gif:AllRed"..SaveAllRed, msg.content_.animation_.animation_.persistent_id_)
end
if msg.content_.text_ then
DevRio:set(Prox.."Rio:Text:AllRed"..SaveAllRed, msg.content_.text_)
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ الرد الجديد', 1, 'md') 
DevRio:del(Prox.."Rio:Add:AllText"..msg.sender_user_id_)
DevRio:del(Prox..'DelSudoRep')
return false end end
if msg.content_.text_ and not DevRio:get(Prox..'Rio:Lock:AllRed'..msg.chat_id_) then
if DevRio:get(Prox.."Rio:Video:AllRed"..msg.content_.text_) then
sendVideo(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox.."Rio:Video:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:File:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox.."Rio:File:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:Voice:AllRed"..msg.content_.text_)  then
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox.."Rio:Voice:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:Audio:AllRed"..msg.content_.text_)  then
sendAudio(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox.."Rio:Audio:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:Photo:AllRed"..msg.content_.text_)  then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox.."Rio:Photo:AllRed"..msg.content_.text_))
end
if  DevRio:get(Prox.."Rio:Gif:AllRed"..msg.content_.text_) then
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, DevRio:get(Prox.."Rio:Gif:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:Stecker:AllRed"..msg.content_.text_) then
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, DevRio:get(Prox.."Rio:Stecker:AllRed"..msg.content_.text_))
end
if DevRio:get(Prox.."Rio:Text:AllRed"..msg.content_.text_) then
function ProxTeam(extra,result,success)
if result.username_ then username = '[@'..result.username_..']' else username = 'لا يوجد' end
local edit_msg = DevRio:get(Prox..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local Text = DevRio:get(Prox.."Rio:Text:AllRed"..msg.content_.text_)
local Text = Text:gsub('#username',(username or 'لا يوجد')) 
local Text = Text:gsub('#name','['..result.first_name_..']')
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit_msg)
local Text = Text:gsub('#msgs',(user_msgs or 'لا يوجد'))
local Text = Text:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
send(msg.chat_id_,msg.id_,Text)
end
getUser(msg.sender_user_id_, ProxTeam)
end
end 
--     Source Prox     --
--       Spam Send        --
function NotSpam(msg,Type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,dp) 
local GetName = '['..dp.first_name_..'](tg://user?id='..dp.id_..')'
if Type == "kick" then 
ChatKick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⌔  العضو ↫ '..GetName..' \n⌔  قام بالتكرار المحدد تم طرده '
SendText(msg.chat_id_,Text,0,'md')
return false  
end 
if Type == "del" then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false  
end 
if Type == "keed" and not DevRio:sismember(Prox..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_) then
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_.."") 
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⌔  العضو ↫ '..GetName..' \n⌔  قام بالتكرار المحدد تم تقيده '
SendText(msg.chat_id_,Text,0,'md')
return false  
end  
if Type == "mute" and not DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, msg.sender_user_id_) then
DevRio:sadd(Prox..'Rio:Muted:'..msg.chat_id_,msg.sender_user_id_)
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '⌔  العضو ↫ '..GetName..' \n⌔  قام بالتكرار المحدد تم كتمه '
SendText(msg.chat_id_,Text,0,'md')
return false  
end
end,nil)
end  
--  end functions Prox --
--     Source Prox     --
--       Spam Check       --
if not VipMem(msg) and msg.content_.ID ~= "MessageChatAddMembers" and DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") then 
if msg.sender_user_id_ ~= Prox then
floods = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") or "nil"
Num_Msg_Max = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
Time_Spam = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 5
local post_count = tonumber(DevRio:get(Prox.."Rio:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_) or 0)
if post_count > tonumber(DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5) then 
local ch = msg.chat_id_
local type = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") 
NotSpam(msg,type)  
end
DevRio:setex(Prox.."Rio:Spam:Cont"..msg.sender_user_id_..":"..msg.chat_id_, tonumber(DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") or 3), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") then
Num_Msg_Max = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") 
end
if DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") then
Time_Spam = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam:Time") 
end 
end
end 
--     Source Prox     --
----- START MSG CHECKS -----
if msg.sender_user_id_ and Ban(msg.sender_user_id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and BanAll(msg.sender_user_id_) then
ChatKick(msg.chat_id_, msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and Muted(msg.sender_user_id_, msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.sender_user_id_ and MuteAll(msg.sender_user_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return false
end
if msg.content_.ID == "MessagePinMessage" then
if Constructor(msg) or tonumber(msg.sender_user_id_) == tonumber(Prox) then
DevRio:set(Prox..'Rio:PinnedMsg'..msg.chat_id_,msg.content_.message_id_)
else
local pin_id = DevRio:get(Prox..'Rio:PinnedMsg'..msg.chat_id_)
if pin_id and DevRio:get(Prox..'Rio:Lock:Pin'..msg.chat_id_) then
pinmsg(msg.chat_id_,pin_id,0)
end
end
end
if DevRio:get(Prox..'Rio:viewget'..msg.sender_user_id_) then
if not msg.forward_info_ then
DevRio:del(Prox..'Rio:viewget'..msg.sender_user_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد مشاهدات المنشور هي ↫ ('..msg.views_..')', 1, 'md')
DevRio:del(Prox..'Rio:viewget'..msg.sender_user_id_)
end
end
--     Source Prox     --
--         Photo          --
if msg.content_.ID == "MessagePhoto" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Photo'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--        Markdown        --
elseif not msg.reply_markup_ and msg.via_bot_user_id_ ~= 0 then
if DevRio:get(Prox..'Rio:Lock:Markdown'..msg.chat_id_) then
if not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Prox     --
--        Document        --
elseif msg.content_.ID == "MessageDocument" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Document'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--         Inline         --
elseif msg.reply_markup_ and msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" and msg.via_bot_user_id_ ~= 0 then
if not VipMem(msg) then
if DevRio:get(Prox..'Rio:Lock:Inline'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Prox     --
--        Sticker         --
elseif msg.content_.ID == "MessageSticker" then
if not VipMem(msg) then
if DevRio:get(Prox..'Rio:Lock:Stickers'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
elseif msg.content_.ID == "MessageChatJoinByLink" then
if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
function get_welcome(extra,result,success)
if DevRio:get(Prox..'Rio:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevRio:get(Prox..'Rio:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = '• نورت حبي \n• firstname \n• username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..result.first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..result.username_..']' or '[@F_L_3]'))
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end 
if DevRio:get(Prox.."Rio:Lock:Welcome"..msg.chat_id_) then
getUser(msg.sender_user_id_,get_welcome)
end
--     Source Prox     --
--      New User Add      --
elseif msg.content_.ID == "MessageChatAddMembers" then
if not DevRio:get(Prox..'Rio:Lock:BotWelcome') then 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = Prox,offset_ = 0,limit_ = 1},function(extra,rio,success) 
for i=0,#msg.content_.members_ do    
BotWelcome = msg.content_.members_[i].id_    
if BotWelcome and BotWelcome == tonumber(Prox) then 
if DevRio:sismember(Prox..'Rio:Groups',msg.chat_id_) then BotText = "مفعله في السابق\n⌔  ارسل ↫ الاوامر واستمتع بالمميزيات" else BotText = "معطله يجب رفعي مشرف\n⌔  بعد ذلك يرجى ارسال امر ↫ تفعيل\n⌔  سيتم رفع الادمنيه والمنشئ تلقائيا" end 
if DevRio:get(Prox.."Rio:Text:BotWelcome") then RioText = DevRio:get(Prox.."Rio:Text:BotWelcome") else RioText = "⌔  مرحبا انا بوت اسمي "..NameBot.."\n⌔  حالة المجموعه ↫ "..BotText.."\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈" end 
if DevRio:get(Prox.."Rio:Photo:BotWelcome") then RioPhoto = DevRio:get(Prox.."Rio:Photo:BotWelcome") elseif rio.photos_[0] then RioPhoto = rio.photos_[0].sizes_[1].photo_.persistent_id_ else RioPhoto = nil end 
if RioPhoto ~= nil then
sendPhoto(msg.chat_id_,msg.id_,0,1,nil,RioPhoto,RioText)
else 
send(msg.chat_id_,msg.id_,RioText)
end 
end   
end
end,nil)
end
if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban(msg.content_.members_[0].id_, msg.chat_id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and BanAll(msg.content_.members_[0].id_) then
ChatKick(msg.chat_id_, msg.content_.members_[0].id_)
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
if DevRio:get(Prox.."Rio:Lock:Welcome"..msg.chat_id_) then
if DevRio:get(Prox..'Rio:Groups:Welcomes'..msg.chat_id_) then
Welcomes = DevRio:get(Prox..'Rio:Groups:Welcomes'..msg.chat_id_)
else
Welcomes = '• نورت حبي \n• firstname \n• username'
end
local Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
local Welcomes = Welcomes:gsub('firstname',('['..msg.content_.members_[0].first_name_..']' or ''))
local Welcomes = Welcomes:gsub('username',('[@'..msg.content_.members_[0].username_..']' or '[@F_L_3]'))
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
end
--     Source Prox     --
--        Contact         --
elseif msg.content_.ID == "MessageContact" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Contact'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
--     Source Prox     --
--         Audio          --
elseif msg.content_.ID == "MessageAudio" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Music'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--         Voice          --
elseif msg.content_.ID == "MessageVoice" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Voice'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--        Location        --
elseif msg.content_.ID == "MessageLocation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Location'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
return
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--         Video          --
elseif msg.content_.ID == "MessageVideo" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Videos'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or msg.content_.caption_:match("[Tt].[Mm][Ee]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--          Gif           --
elseif msg.content_.ID == "MessageAnimation" then
if not VipMem(msg) then
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if DevRio:get(Prox..'Rio:Lock:Gifs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.caption_ then
Filters(msg, msg.content_.caption_)
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
if msg.content_.caption_:match("@") then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match(".[Ii][Rr]") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match(".[Oo][Rr][Gg]") or msg.content_.caption_:match(".[Ii][Nn][Ff][Oo]") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Xx][Yy][Zz]") or msg.content_.caption_:match(".[Tt][Kk]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.caption_:match("[A-Z]") or msg.content_.caption_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
end
--     Source Prox     --
--         Text           --
elseif msg.content_.ID == "MessageText" then
if not VipMem(msg) then
Filters(msg,text)
if msg.forward_info_ then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
if msg.forward_info_.ID == "MessageForwardedFromUser" or msg.forward_info_.ID == "MessageForwardedPost" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") then
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if DevRio:get(Prox..'Rio:Lock:Text'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if msg.content_.text_:match("@") then
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("#") then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Ii][Rr]") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match(".[Ii][Nn][Ff][Oo]") or text:match("[Ww][Ww][Ww].") or text:match(".[Tt][Kk]") or text:match(".[Xx][Yy][Zz]") or msg.content_.ID == "MessageEntityTextUrl" or msg.content_.ID == "MessageEntityUrl" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[\216-\219][\128-\191]") then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_ then
local _nl, ctrl_chars = string.gsub(text, '%c', '')
local _nl, real_digits = string.gsub(text, '%d', '')
if not DevRio:get(Prox..'Rio:Spam:Text'..msg.chat_id_) then
sens = 400
else
sens = tonumber(DevRio:get(Prox..'Rio:Spam:Text'..msg.chat_id_))
end
if DevRio:get(Prox..'Rio:Lock:Spam'..msg.chat_id_) and string.len(msg.content_.text_) > (sens) or ctrl_chars > (sens) or real_digits > (sens) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
if msg.content_.text_:match("[A-Z]") or msg.content_.text_:match("[a-z]") then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
end
end
--     Source Prox     --
if DevRio:get(Prox.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) then
if text == "الغاء" then
send(msg.chat_id_,msg.id_,"⌔  تم الغاء حفظ الرابط")       
DevRio:del(Prox.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false
end
if msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)") then
local Link = msg.content_.text_:match("(https://telegram.me/joinchat/%S+)") or msg.content_.text_:match("(https://t.me/joinchat/%S+)")
DevRio:set(Prox.."Rio:Groups:Links"..msg.chat_id_,Link)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ الرابط بنجاح', 1, 'md')
DevRio:del(Prox.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_) 
return false 
end
end
--     Source Prox     --
local msg = data.message_
text = msg.content_.text_
if text and Constructor(msg) then 
if DevRio:get('ProxTeam:'..Prox.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
DevRio:del('ProxTeam:'..Prox..'id:user'..msg.chat_id_)  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء الامر', 1, 'md')
DevRio:del('ProxTeam:'..Prox.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del('ProxTeam:'..Prox.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevRio:get('ProxTeam:'..Prox..'id:user'..msg.chat_id_)  
DevRio:incrby(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..iduserr,numadded)
Dev_Rio(msg.chat_id_, msg.id_,  1, "⌔  تم اضافة "..numadded..' رساله', 1, 'md')
DevRio:del('ProxTeam:'..Prox..'id:user'..msg.chat_id_) 
end
end
if text and Constructor(msg) then 
if DevRio:get('ProxTeam:'..Prox.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
DevRio:del('ProxTeam:'..Prox..'ids:user'..msg.chat_id_)  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء الامر', 1, 'md')
DevRio:del('ProxTeam:'..Prox.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del('ProxTeam:'..Prox.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = DevRio:get('ProxTeam:'..Prox..'ids:user'..msg.chat_id_)  
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..iduserr,numadded)  
Dev_Rio(msg.chat_id_, msg.id_,  1, "⌔  تم اضافة "..numadded..' نقطه', 1, 'md')
DevRio:del('ProxTeam:'..Prox..'ids:user'..msg.chat_id_)  
end
end
--     Source Prox     --
if text and (text:match("طيز") or text:match("ديس") or text:match("انيج") or text:match("نيج") or text:match("ديوس") or text:match("عير") or text:match("كسختك") or text:match("كسمك") or text:match("كسربك") or text:match("بلاع") or text:match("ابو العيوره") or text:match("منيوج") or text:match("كحبه") or text:match("كحاب") or text:match("الكحبه") or text:match("كسك") or text:match("طيزك") or text:match("كس امك") or text:match("صرم") or text:match("كس اختك")) then
if not DevRio:get(Prox.."Rio:Lock:Fshar"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  ممنوع الفشار في المجموعه")  
end end
if text and (text:match("ڬ") or text:match("ٺ") or text:match("چ") or text:match("ڇ") or text:match("ڿ") or text:match("ڀ") or text:match("ڎ") or text:match("ݫ") or text:match("ژ") or text:match("ڟ") or text:match("ݜ") or text:match("ڸ") or text:match("پ") or text:match("۴") or text:match("مک") or text:match("زدن") or text:match("دخترا") or text:match("دیوث") or text:match("کلیپشن") or text:match("خوششون") or text:match("میدا") or text:match("که") or text:match("بدانیم") or text:match("باید") or text:match("زناشویی") or text:match("آموزش") or text:match("راحتی") or text:match("خسته") or text:match("بیام") or text:match("بپوشم") or text:match("كرمه")) then
if DevRio:get(Prox.."Rio:Lock:Farsi"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  ممنوع التكلم بالغه الفارسيه هنا")  
end end
if text and (text:match("ڬ") or text:match("ٺ") or text:match("چ") or text:match("ڇ") or text:match("ڿ") or text:match("ڀ") or text:match("ڎ") or text:match("ݫ") or text:match("ژ") or text:match("ڟ") or text:match("ݜ") or text:match("ڸ") or text:match("پ") or text:match("۴") or text:match("مک") or text:match("زدن") or text:match("دخترا") or text:match("دیوث") or text:match("کلیپشن") or text:match("خوششون") or text:match("میدا") or text:match("که") or text:match("بدانیم") or text:match("باید") or text:match("زناشویی") or text:match("آموزش") or text:match("راحتی") or text:match("خسته") or text:match("بیام") or text:match("بپوشم") or text:match("كرمه")) then
if DevRio:get(Prox.."Rio:Lock:FarsiBan"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ChatKick(msg.chat_id_, msg.sender_user_id_)
end end 
if text and (text:match("خره بالله") or text:match("خبربك") or text:match("كسدينربك") or text:match("خرب بالله") or text:match("خرب الله") or text:match("خره بربك") or text:match("الله الكواد") or text:match("خره بمحمد") or text:match("كسم الله") or text:match("كسم ربك") or text:match("كسربك") or text:match("كسختالله") or text:match("كسخت الله") or text:match("خره بدينك") or text:match("خرهبدينك") or text:match("كسالله") or text:match("خربالله")) then
if not DevRio:get(Prox.."Rio:Lock:Kfr"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  ممنوع الكفر في المجموعه") 
end end
if text and (text:match("سني نكس") or text:match("شيعه") or text:match("الشيعه") or text:match("السنه") or text:match("طائفتكم") or text:match("شيعي") or text:match("انا سني") or text:match("مسيحي") or text:match("يهودي") or text:match("صابئي") or text:match("ملحد") or text:match("بالسنه") or text:match("شيعة")) then
if not DevRio:get(Prox.."Rio:Lock:Taf"..msg.chat_id_) and not VipMem(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
ReplyStatus(msg,msg.sender_user_id_,"WrongWay","⌔  ممنوع التكلم بالطائفيه هنا") 
end end
--     Source Prox     --
if SecondSudo(msg) then
if text == 'جلب نسخه الكروبات' and ChCheck(msg) or text == 'جلب نسخه احتياطيه' and ChCheck(msg) or text == 'جلب النسخه الاحتياطيه' and ChCheck(msg) or text == '↫ جلب نسخه احتياطيه ⌔' and ChCheck(msg) then
local List = DevRio:smembers(Prox..'Rio:Groups') 
local BotName = (DevRio:get(Prox.."Rio:NameBot") or 'كيلوا')
local GetJson = '{"BotId": '..Prox..',"BotName": "'..BotName..'","GroupsList":{'  
for k,v in pairs(List) do 
LinkGroups = DevRio:get(Prox.."Rio:Groups:Links"..v)
Welcomes = DevRio:get(Prox..'Rio:Groups:Welcomes'..v) or ''
Welcomes = Welcomes:gsub('"',"") Welcomes = Welcomes:gsub("'","") Welcomes = Welcomes:gsub(",","") Welcomes = Welcomes:gsub("*","") Welcomes = Welcomes:gsub(";","") Welcomes = Welcomes:gsub("`","") Welcomes = Welcomes:gsub("{","") Welcomes = Welcomes:gsub("}","") 
RioConstructors = DevRio:smembers(Prox..'Rio:RioConstructor:'..v)
Constructors = DevRio:smembers(Prox..'Rio:BasicConstructor:'..v)
BasicConstructors = DevRio:smembers(Prox..'Rio:Constructor:'..v)
Managers = DevRio:smembers(Prox..'Rio:Managers:'..v)
Admis = DevRio:smembers(Prox..'Rio:Admins:'..v)
Vips = DevRio:smembers(Prox..'Rio:VipMem:'..v)
if k == 1 then
GetJson = GetJson..'"'..v..'":{'
else
GetJson = GetJson..',"'..v..'":{'
end
if #Vips ~= 0 then 
GetJson = GetJson..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Admis ~= 0 then
GetJson = GetJson..'"Admis":['
for k,v in pairs(Admis) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Managers ~= 0 then
GetJson = GetJson..'"Managers":['
for k,v in pairs(Managers) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #Constructors ~= 0 then
GetJson = GetJson..'"Constructors":['
for k,v in pairs(Constructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #BasicConstructors ~= 0 then
GetJson = GetJson..'"BasicConstructors":['
for k,v in pairs(BasicConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if #RioConstructors ~= 0 then
GetJson = GetJson..'"RioConstructors":['
for k,v in pairs(RioConstructors) do
if k == 1 then
GetJson =  GetJson..'"'..v..'"'
else
GetJson =  GetJson..',"'..v..'"'
end
end   
GetJson = GetJson..'],'
end
if LinkGroups then
GetJson = GetJson..'"LinkGroups":"'..LinkGroups..'",'
end
GetJson = GetJson..'"Welcomes":"'..Welcomes..'"}'
end
GetJson = GetJson..'}}'
local File = io.open('./'..Prox..'.json', "w")
File:write(GetJson)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './'..Prox..'.json', '⌔  يحتوي الملف على ↫ '..#List..' مجموعه',dl_cb, nil)
io.popen('rm -rf ./'..Prox..'.json')
end
if text and (text == 'رفع النسخه' or text == 'رفع النسخه الاحتياطيه' or text == 'رفع نسخه الاحتياطيه') and tonumber(msg.reply_to_message_id_) > 0 then   
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
--     Source Prox     --
if DevRio:get(Prox.."SET:GAME"..msg.chat_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
Dev_Rio( msg.chat_id_, msg.id_, 1,"⌔  يوجد فقط ( 6 ) اختيارات\n⌔  ارسل اختيارك مره اخرى", 1, "md")    
return false  end 
local GETNUM = DevRio:get(Prox.."GAMES"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevRio:del(Prox.."SET:GAME"..msg.chat_id_)   
Dev_Rio( msg.chat_id_, msg.id_, 1,'⌔  *المحيبس باليد رقم* ↫ '..NUM..'\n⌔  *مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*', 1, "md") 
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevRio:del(Prox.."SET:GAME"..msg.chat_id_)   
Dev_Rio( msg.chat_id_, msg.id_, 1,'⌔  *المحيبس باليد رقم* ↫ '..GETNUM..'\n⌔  *للاسف لقد خسرت حاول مره اخرى للعثور على المحيبس*', 1, "md")
end
end
end
if DevRio:get(Prox..'DevRio4'..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "⌔  تم الغاء الامر")
DevRio:del(Prox..'DevRio4'..msg.sender_user_id_)
return false  end 
DevRio:del(Prox..'DevRio4'..msg.sender_user_id_)
local username = string.match(text, "@[%a%d_]+") 
tdcli_function({ID = "SearchPublicChat",username_ = username},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '⌔  المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '⌔  عذرا لا يمكنك وضع معرف حسابات في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_, '⌔  عذرا لا يمكنك وضع معرف مجموعه في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'⌔  البوت ادمن في القناة \n⌔  تم تفعيل الاشتراك الاجباري \n⌔  ايدي القناة ↫ '..data.id_..'\n⌔  معرف القناة ↫ [@'..data.type_.channel_.username_..']')
DevRio:set(Prox..'Rio:ChId',data.id_)
else
send(msg.chat_id_, msg.id_,'⌔  عذرا البوت ليس ادمن في القناة')
end
return false  
end
end,nil)
end
--     Source Prox     --
if DevRio:get(Prox.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
DevRio:del(Prox.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء الامر', 1, 'md')
return false 
end 
DevRio:del(Prox.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_)
local DevText = msg.content_.text_:match("(.*)")
DevRio:set(Prox.."DevText", DevText)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ كليشة المطور", 1, "md")
end
if DevRio:get(Prox..'Rio:NameBot'..msg.sender_user_id_) == 'msg' then
if text and text:match("^الغاء$") then 
DevRio:del(Prox..'Rio:NameBot'..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء الامر', 1, 'md')
return false 
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ اسم البوت ', 1, 'html')
DevRio:del(Prox..'Rio:NameBot'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:NameBot', text)
return false 
end
--     Source Prox     --
if text == "الرابط" then
if not DevRio:get(Prox..'Rio:Lock:GpLinks'..msg.chat_id_) then 
if DevRio:get(Prox.."Rio:Groups:Links"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  Group Link ↬ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"..DevRio:get(Prox.."Rio:Groups:Links"..msg.chat_id_), 1, "html")
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لايوجد رابط ارسل ↫ ضع رابط او ارسل ↫ انشاء رابط للانشاء', 1, 'md')
end
else
end
end
--     Source Prox     --
if text == "الرابط" then
if not DevRio:get(Prox.."Rio:Lock:GpLinksinline"..msg.chat_id_) then 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_)) or DevRio:get(Prox.."Private:Group:Link"..msg.chat_id_) 
if linkgpp.ok == true then 
local Text = '⌔  𝖫𝗂𝗇𝗄 𝖦𝗋𝗈𝗎𝗉 ↬ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n['..ta.title_..']('..linkgpp.result..')'
local inline = {{{text = ta.title_, url=linkgpp.result}},
} 
SendInline(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5) 
else 
end 
end,nil) 
end
end
--     Source Prox     --
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
DevRio:incr(Prox..'Rio:UsersMsgs'..Prox..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:incr(Prox..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d'))  
ChatType = 'sp' 
elseif id:match("^(%d+)") then
if not DevRio:sismember(Prox.."Rio:Users",msg.chat_id_) then
DevRio:sadd(Prox.."Rio:Users",msg.chat_id_)
end
ChatType = 'pv' 
else
ChatType = 'gp' 
end
end 
--     Source Prox     --
if ChatType == 'sp' or ChatType == 'gp' or ChatType == 'pv' then
if text == 'بوت' or text == 'بوتت' then 
NameBot = (DevRio:get(Prox..'Rio:NameBot') or 'كيلوا')
local ProxTeam = {' كول حبيبي ؟ اني '..NameBot..' ',' وياك القميل '..NameBot..' ',' اسمي القميل '..NameBot..' '}
DevRio2 = math.random(#ProxTeam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam[DevRio2] , 1, 'html') 
return false
end
if text == 'اسم البوت' or text == 'البوت شنو اسمه' or text == 'شسمه البوت' or text == 'البوت شسمه' then
NameBot = (DevRio:get(Prox..'Rio:NameBot') or 'كيلوا') 
local ProxTeam = {"اسمي القميل "..NameBot.." "} 
DevRio2 = math.random(#ProxTeam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam[DevRio2] , 1, 'html') 
return false
end
if text and text == (DevRio:get(Prox..'Rio:NameBot') or 'كيلوا') then 
NameBot = (DevRio:get(Prox..'Rio:NameBot') or 'كيلوا')
local namebot = {'كول حبيبي ؟ اني '..NameBot..' ',' وياك القميل '..NameBot..' '} 
name = math.random(#namebot) 
Dev_Rio(msg.chat_id_, msg.id_, 1, namebot[name] , 1, 'html') 
return false 
end
if text =='نقاطي' and ChCheck(msg) then 
if tonumber((DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لم تربح اي نقطه\n⌔  ارسل ↫ الالعاب للعب', 1, 'md')
else 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  عدد النقاط التي ربحتها ↫ '..(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_)), 1, 'md')
end
end
if text ==  'حذف رسائلي' and ChCheck(msg) or text ==  'مسح رسائلي' and ChCheck(msg) then DevRio:del(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف جميع رسائلك', 1, 'md') end
if text ==  'حذف نقاطي' and ChCheck(msg) or text ==  'مسح نقاطي' and ChCheck(msg) then DevRio:del(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف جميع نقاطك', 1, 'md') end
--     Source Prox     --
if text == 'سمايلات' and ChCheck(msg) or text == 'السمايلات' and ChCheck(msg) or text == '↫ سمايلات ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'🍏','🍎','🍐','🍊','🍋','🍌','🍉','🍇','🍓','🍈','🍒','🍑','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','🍠','🥐','🍞','🥖','🥨','🧀','🥚','🍳','🥞','🥓','🥩','🍗','🍖','🌭','🍔','🍟','🍕','🥪','🥙','🍼','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🏆','🎻','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🛎','📤','🎗','🏵','🎖','🏆','🥌','🛷','🚕','🚗','🚙','🚌','🚎','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔️','🛡','🔮','🌡','💣','⏱','🛢','📓','📗','📂','📅','📪','📫','📬','📭','⏰','📺','🎚','☎️','📡'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'🍞','🍞')
name = string.gsub(name,'🥖','🥖')
name = string.gsub(name,'🥨','🥨')
name = string.gsub(name,'🧀','🧀')
name = string.gsub(name,'🥚','🥚')
name = string.gsub(name,'🍳','🍳')
name = string.gsub(name,'🥞','🥞')
name = string.gsub(name,'🥓','🥓')
name = string.gsub(name,'🥩','🥩')
name = string.gsub(name,'🍗','🍗')
name = string.gsub(name,'🍖','🍖')
name = string.gsub(name,'🌭','🌭')
name = string.gsub(name,'🍔','🍔')
name = string.gsub(name,'🍟','🍟')
name = string.gsub(name,'🍕','🍕')
name = string.gsub(name,'🥪','🥪')
name = string.gsub(name,'🥙','🥙')
name = string.gsub(name,'🍼','🍼')
name = string.gsub(name,'☕️','☕️')
name = string.gsub(name,'🍵','🍵')
name = string.gsub(name,'🥤','🥤')
name = string.gsub(name,'🍶','🍶')
name = string.gsub(name,'🍺','🍺')
name = string.gsub(name,'🍏','??')
name = string.gsub(name,'🍎','🍎')
name = string.gsub(name,'🍐','🍐')
name = string.gsub(name,'🍊','🍊')
name = string.gsub(name,'🍋','🍋')
name = string.gsub(name,'🍌','🍌')
name = string.gsub(name,'🍉','🍉')
name = string.gsub(name,'🍇','🍇')
name = string.gsub(name,'🍓','🍓')
name = string.gsub(name,'🍈','🍈')
name = string.gsub(name,'🍒','🍒')
name = string.gsub(name,'🍑','🍑')
name = string.gsub(name,'🍍','🍍')
name = string.gsub(name,'🥥','🥥')
name = string.gsub(name,'🥝','🥝')
name = string.gsub(name,'🍅','🍅')
name = string.gsub(name,'🍆','🍆')
name = string.gsub(name,'🥑','🥑')
name = string.gsub(name,'🥦','🥦')
name = string.gsub(name,'🥒','🥒')
name = string.gsub(name,'🌶','🌶')
name = string.gsub(name,'🌽','🌽')
name = string.gsub(name,'🥕','🥕')
name = string.gsub(name,'🥔','🥔')
name = string.gsub(name,'🍠','🍠')
name = string.gsub(name,'🥐','🥐')
name = string.gsub(name,'🍻','🍻')
name = string.gsub(name,'🏀','🏀')
name = string.gsub(name,'⚽️','⚽️')
name = string.gsub(name,'🏈','🏈')
name = string.gsub(name,'⚾️','⚾️')
name = string.gsub(name,'🎾','🎾')
name = string.gsub(name,'🏐','🏐')
name = string.gsub(name,'🏉','🏉')
name = string.gsub(name,'🎱','🎱')
name = string.gsub(name,'🏓','🏓')
name = string.gsub(name,'🏸','🏸')
name = string.gsub(name,'🥅','🥅')
name = string.gsub(name,'🎰','🎰')
name = string.gsub(name,'🎮','🎮')
name = string.gsub(name,'🎳','🎳')
name = string.gsub(name,'🎯','🎯')
name = string.gsub(name,'🏆','🏆')
name = string.gsub(name,'🎻','🎻')
name = string.gsub(name,'🎸','🎸')
name = string.gsub(name,'🎺','🎺')
name = string.gsub(name,'🥁','🥁')
name = string.gsub(name,'🎹','🎹')
name = string.gsub(name,'🎼','🎼')
name = string.gsub(name,'🎧','🎧')
name = string.gsub(name,'🎤','🎤')
name = string.gsub(name,'🎬','🎬')
name = string.gsub(name,'🎨','🎨')
name = string.gsub(name,'🎭','🎭')
name = string.gsub(name,'🎪','🎪')
name = string.gsub(name,'🛎','🛎')
name = string.gsub(name,'📤','📤')
name = string.gsub(name,'🎗','🎗')
name = string.gsub(name,'🏵','🏵')
name = string.gsub(name,'🎖','🎖')
name = string.gsub(name,'🏆','🏆')
name = string.gsub(name,'🥌','🥌')
name = string.gsub(name,'🛷','🛷')
name = string.gsub(name,'🚕','🚕')
name = string.gsub(name,'🚗','🚗')
name = string.gsub(name,'🚙','🚙')
name = string.gsub(name,'🚌','🚌')
name = string.gsub(name,'🚎','🚎')
name = string.gsub(name,'🏎','🏎')
name = string.gsub(name,'🚓','🚓')
name = string.gsub(name,'🚑','🚑')
name = string.gsub(name,'🚚','🚚')
name = string.gsub(name,'🚛','🚛')
name = string.gsub(name,'🚜','🚜')
name = string.gsub(name,'🇮🇶','🇮🇶')
name = string.gsub(name,'⚔️','⚔️')
name = string.gsub(name,'🛡','🛡')
name = string.gsub(name,'🔮','🔮')
name = string.gsub(name,'🌡','🌡')
name = string.gsub(name,'💣','💣')
name = string.gsub(name,'⏱','⏱')
name = string.gsub(name,'🛢','🛢')
name = string.gsub(name,'📒','📒')
name = string.gsub(name,'📗','📗')
name = string.gsub(name,'📅','📆')
name = string.gsub(name,'📪','📪')
name = string.gsub(name,'📫','📫')
name = string.gsub(name,'📬','📬')
name = string.gsub(name,'📭','📭')
name = string.gsub(name,'⏰','⏰')
name = string.gsub(name,'📺','📺')
name = string.gsub(name,'🎚','🎚')
name = string.gsub(name,'☎️','☎️')
ProxTeam = '⌔  اول واحد يدز هذا السمايل يربح ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ سمايلات للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end
if text == 'ترتيب' and ChCheck(msg) or text == 'الترتيب' and ChCheck(msg) or text == '↫ ترتيب ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
ProxTeam = '⌔  اول واحد يرتبها يربح ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ ترتيب للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end
if text == 'محيبس' and ChCheck(msg) or text == 'بات' and ChCheck(msg) or text == 'المحيبس' and ChCheck(msg) or text == '↫ محيبس ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
Num = math.random(1,6)
DevRio:set(Prox.."GAMES"..msg.chat_id_,Num) 
TEST = [[
➀     ➁     ➂     ➃     ➄     ➅
↓     ↓     ↓     ↓     ↓     ↓
👊 ‹› 👊🏻 ‹› 👊🏼 ‹› 👊🏽 ‹› 👊🏾 ‹› 👊🏿
⌔  اختر رقم لاستخراج المحيبس
⌔  الفائز يحصل على (5) نقاط
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, TEST, 1, "md") 
DevRio:setex(Prox.."SET:GAME"..msg.chat_id_, 100, true)  
return false  
end end
if text == 'حزوره' and ChCheck(msg) or text == 'الحزوره' and ChCheck(msg) or text == '↫ حزوره ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','غلط','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'غلط','ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
ProxTeam = '⌔  اول واحد يحلها يربح ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ حزوره للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'المعاني' and ChCheck(msg) or text == 'معاني' and ChCheck(msg) or text == '↫ معاني ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum2'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','??')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
ProxTeam = '⌔  ما معنى هذا السمايل :؟ ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum2'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ المعاني للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'العكس' and ChCheck(msg) or text == 'عكس' and ChCheck(msg) or text == '↫ العكس ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum3'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'محلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'حي','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
ProxTeam = '⌔  ما هو عكس كلمة ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum3'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ العكس للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end 
if text == 'المختلف' and ChCheck(msg) or text == 'مختلف' and ChCheck(msg) or text == '↫ المختلف ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','📥','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','🧚‍♂️','🧝‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕓','🕤','⌛️','📅','👩‍⚖️','👨‍🎨'};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum4'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'😸','😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠️','💀💀💀☠️💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻👻👻👻👻🐼')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟⭐️🌟')
name = string.gsub(name,'📥','💫💫💫📥💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃️☃️☃️☃️⛄️☃️☃️☃️☃️')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻👩‍💻??‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'👩‍🍳','👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀️','🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♂️🧚‍♀️🧚‍♂️🧚‍♂️')
name = string.gsub(name,'🧚‍♂️','🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♀️🧚‍♂️🧚‍♀️🧚‍♀️')
name = string.gsub(name,'🧝‍♂️','🧝‍♀️🧝‍♀️🧝‍♀️🧝‍♂️🧝‍♀️🧝‍♀️🧝‍♀️🧝‍♀️')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕓','🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆📅📆📆')
name = string.gsub(name,'👩‍⚖️','👨‍⚖️👨‍⚖️👨‍⚖️👨‍⚖️👨‍⚖️👩‍⚖️👨‍⚖️👨‍⚖️')
name = string.gsub(name,'👨‍🎨','👩‍🎨👩‍🎨👨‍🎨👩‍🎨👩‍🎨👩‍🎨👩‍🎨👩‍🎨')
ProxTeam = '⌔  اول واحد يطلع المختلف يربح\n{'..name..'} '
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum4'..msg.chat_id_) and not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ المختلف للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'امثله' and ChCheck(msg) or text == 'الامثله' and ChCheck(msg) or text == '↫ امثله ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {
'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',
};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum5'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي ___ للماعنده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل ___ ')
name = string.gsub(name,'بيدك','اكل ___ محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من ___ نعال')
name = string.gsub(name,'شقره','مع الخيل يا ___ ')
name = string.gsub(name,'النخله','الطول طول ___ والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر ___ ')
name = string.gsub(name,'الخيل','من قلة ___ شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني ___ ')
name = string.gsub(name,'المبلل',' ___ ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة ___ ')
name = string.gsub(name,'يركص','المايعرف ___ يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح ___ يكول حامض')
name = string.gsub(name,'العمه','___ إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي ___ للخباز حتى لو ياكل نصه')
name = string.gsub(name,'بالحصاد','اسمة ___ ومنجله مكسور')
name = string.gsub(name,'شهر','امشي ___ ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن ___ يا من على الحاضر لكة')
name = string.gsub(name,'القرد',' ___ بعين امه غزال')
name = string.gsub(name,'يكحله','اجه ___ عماها')
ProxTeam = '⌔  اكمل المثال التالي ↫ ['..name..']'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum5'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(Prox..'Rio:GameNum5'..msg.chat_id_)
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ امثله للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'رياضيات' and ChCheck(msg) or text == 'الرياضيات' and ChCheck(msg) or text == '↫ رياضيات ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'9','46','2','9','5','4','25','10','17','15','39','5','16',};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum6'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'9','7 + 2 = ?')
name = string.gsub(name,'46','41 + 5 = ?')
name = string.gsub(name,'2','5 - 3 = ?')
name = string.gsub(name,'9','5 + 2 + 2 = ?')
name = string.gsub(name,'5','8 - 3 = ?')
name = string.gsub(name,'4','40 ÷ 10 = ?')
name = string.gsub(name,'25','30 - 5 = ?')
name = string.gsub(name,'10','100 ÷ 10 = ?')
name = string.gsub(name,'17','10 + 5 + 2 = ?')
name = string.gsub(name,'15','25 - 10 = ?')
name = string.gsub(name,'39','44 - 5 = ?')
name = string.gsub(name,'5','12 + 1 - 8 = ?')
name = string.gsub(name,'16','16 + 16 - 16 = ?')
ProxTeam = '⌔  اكمل المعادله التاليه ↫ ⤈\n{'..name..'} '
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum6'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(Prox..'Rio:GameNum6'..msg.chat_id_)
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ رياضيات للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end  
if text == 'الانكليزي' and ChCheck(msg) or text == 'الانجليزيه' and ChCheck(msg) or text == 'انكليزيه' and ChCheck(msg) or text == '↫ انكليزي ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','سدني','نقود','اعلم','ذئب','تمساح','ذكي','شاطئ','غبي',};
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum7'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'شاطئ','Beach')
name = string.gsub(name,'غبي','Stupid')
name = string.gsub(name,'صداقه','Friendchip')
ProxTeam = '⌔  ما معنى كلمة ↫ '..name
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum7'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(Prox..'Rio:GameNum7'..msg.chat_id_)
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ انكليزيه للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end  
--     Source Prox     --
if text == 'اسئله' and ChCheck(msg) or text == 'اختيارات' and ChCheck(msg) or text == 'الاسئله' and ChCheck(msg) or text == 'اساله' and ChCheck(msg) or text == '↫ اسئله ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio2 = {'النيل','14','الفم','11','30','بوتين','ستيف جوبر','باريس','10','النمل','حرف الواو','الشعر','سحاب','الاسم','ذهب','حرف الام','العزائم','انسات','المنجنيق','اسيا','6','الاسد','مهر','الدولفين','اوروبا','الزئبق','لندن','الانسان','طوكيو','خديجه',}
name = DevRio2[math.random(#DevRio2)]
DevRio:set(Prox..'Rio:GameNum8'..msg.chat_id_,name)
DevRio:del(Prox..'Rio:Games:Ids'..msg.chat_id_)
name = string.gsub(name,'النيل','⌔  ماهو اطول نهر في العالم ؟\n1- النيل\n2- الفرات\n3- نهر الكونغو')
name = string.gsub(name,'14','⌔  ماعدد عظام الوجه ؟\n1- 15\n2- 13\n3- 14')
name = string.gsub(name,'الفم','⌔  كراسي بيضاء وجدران ورديه اذا اغلقته اصبح ظلام  فمن اكون ؟\n1- الفم\n2- الاذن\n3- الثلاجه')
name = string.gsub(name,'11','⌔  كم جزء يحتوي مسلسل وادي الذئاب ؟\n1- 7\n2- 15\n3- 11')
name = string.gsub(name,'30','⌔  كم جزء يحتوي القران الكريم ؟\n1- 60\n2- 70\n3- 30')
name = string.gsub(name,'بوتين','⌔  من هوه اغنى رئيس في العالم ؟\n1- ترامب\n2- اوباما\n3- بوتين')
name = string.gsub(name,'ستيف جوبر','⌔  من هوه مؤسس شركه ابل العالميه  ؟\n1- لاري بايج\n2- بيل جيتس\n3- ستيف جوبر')
name = string.gsub(name,'باريس','ماهي عاصمه فرنسا ؟\n1- باريس\n2- لوين\n3- موسكو')
name = string.gsub(name,'10','⌔  ماعدد دول العربيه التي توجد في افريقيا ؟\n1- 10\n2- 17\n3- 9')
name = string.gsub(name,'النمل','⌔  ماهو الحيوان الذي يحمل 50 فوق وزنه ؟\n1- الفيل\n2- النمل\n3- الثور')
name = string.gsub(name,'حرف الواو','⌔  ماذا يوجد بيني وبينك ؟\n1- الضل\n2- الاخلاق\n3- حرف الواو')
name = string.gsub(name,'الشعر','⌔  ماهو الشيء النبات ينبت للانسان بلا بذر ؟\n1- الاضافر\n2- الاسنان\n3- الشعر')
name = string.gsub(name,'سحاب','⌔  ما هو الشّيء الذي يستطيع المشي بدون أرجل والبكاء بدون أعين ؟\n1- سحاب\n2- بئر\n3- نهر')
name = string.gsub(name,'الاسم','⌔  ما الشيء الذي نمتلكه , لكنّ غيرنا يستعمله أكثر منّا ؟\n1- العمر\n2- ساعه\n3- الاسم')
name = string.gsub(name,'ذهب','⌔  اصفر اللون سارق عقول اهل الكون وحارمهم لذيذ النوم ؟\n1- نحاس\n2- الماس\n3- ذهب')
name = string.gsub(name,'حرف الام','⌔  في الليل ثلاثة لكنه في النهار واحده فما هو ؟\n1- حرف الباء\n2- حرف الام\n3- حرف الراء')
name = string.gsub(name,'العزائم','⌔  على قدر اصل العزم تأتي ؟\n1- العزائم\n2- المكارم\n3- المبائب')
name = string.gsub(name,'انسات','⌔  ماهي جمع كلمه انسه ؟\n1- سيدات\n2- انسات\n3- قوانص')
name = string.gsub(name,'المنجنيق','⌔  اله اتسعلمت قديما في الحروب ؟\n1- الصاروخ\n2- المسدس\n3- المنجنيق')
name = string.gsub(name,'اسيا','⌔  تقع لبنان في قاره ؟\n1- افريقيا\n2- اسيا\n3- امركيا الشماليه')
name = string.gsub(name,'6','⌔  كم صفرا للمليون ؟\n1- 4\n2- 3\n3- 6')
name = string.gsub(name,'الاسد','⌔  ماهو الحيوان الذي يلقب بملك الغابه ؟\n1- الفيل\n2- الاسد\n3- النمر')
name = string.gsub(name,'مهر','⌔  ما اسم صغير الحصان ؟\n1- مهر\n2- جرو\n3- عجل')
name = string.gsub(name,'الدولفين','⌔  ما الحيوان الذي ينام واحدى عينه مفتوحه ؟\n1- القرش\n2- الدولفين\n3- الثعلب\n')
name = string.gsub(name,'اوروبا','⌔  ماهي القاره التي تلقب بالقاره العجوز ؟\n1- اوروبا\n2- امريكا الشماليه\n3- افريقيا')
name = string.gsub(name,'الزئبق','⌔  ما اسم المعدن الموجود فيي الحاله السائله ؟\n1- النحاس\n2- الحديد\n3- الزئبق')
name = string.gsub(name,'لندن','⌔  ماهي عاصمه انجلترا ؟\n1- لندن\n2- لفرسول\n3- تركيا')
name = string.gsub(name,'الانسان','⌔  ماهو الشئ الذي برأسه سبع فتحات ؟\n1- الهاتف\n2- التلفاز\n3- الانسان')
name = string.gsub(name,'طوكيو','⌔  ماهي عاصمه اليابان ؟\n1- بانكول\n2- نيو دلهي\n3- طوكيو')
name = string.gsub(name,'خديجه','⌔  من هي زوجه الرسول الاكبر منه سنآ ؟\n1- حفضه\n2- زينب\n3- خديجه')
ProxTeam = name..'\n⌔  ارسل الجواب الصحيح فقط'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
return false
end end
if text == DevRio:get(Prox..'Rio:GameNum8'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Games:Ids'..msg.chat_id_) then 
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_, 1)  
DevRio:del(Prox..'Rio:GameNum8'..msg.chat_id_)
ProxTeam = '⌔  مبروك لقد ربحت في اللعبه \n⌔  ارسل ↫ الاسئله للعب مره اخرى'
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md')
end
DevRio:set(Prox..'Rio:Games:Ids'..msg.chat_id_,true)
end  
--     Source Prox     --
if DevRio:get(Prox.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
Dev_Rio(msg.chat_id_, msg.id_, 1,"⌔  عذرا لا يمكنك تخمين عدد اكبر من الـ20 خمن رقم ما بين الـ1 والـ20", 1, 'md')
return false  end 
local GETNUM = DevRio:get(Prox.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
DevRio:del(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevRio:del(Prox.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_,5)  
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  *التخمين الصحيح هو* ↫ '..NUM..'\n⌔  *مبروك لقد ربحت وحصلت على 5 نقاط يمكنك استبدالها بالرسائل*', 1, 'md')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
DevRio:incrby(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(DevRio:get(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
DevRio:del(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_)
DevRio:del(Prox.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_)   
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  *التخمين الصحيح هو* ↫ '..GETNUM..'\n⌔  *للاسف لقد خسرت حاول مره اخرى لتخمين الرقم الصحيح*', 1, 'md')
else
if tonumber(DevRio:get(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 1 then
SetNum = 'محاولتان فقط'
elseif tonumber(DevRio:get(Prox..'Set:Num'..msg.chat_id_..msg.sender_user_id_)) == 2 then
SetNum = 'محاوله واحده فقط'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لقد خمنت الرقم الخطا وتبقى لديك '..SetNum..' ارسل رقم تخمنه مره اخرى للفوز', 1, 'md')
end
end
end
end
if text == 'خمن' and ChCheck(msg) or text == 'تخمين' and ChCheck(msg) or text == '↫ تخمين ⌔' and ChCheck(msg) then   
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
DevRio:set(Prox.."GAMES:NUM"..msg.chat_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  اهلا بك عزيزي في لعبة التخمين ↫ ⤈\n ──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  سيتم تخمين عدد ما بين الـ1 والـ20 اذا تعتقد انك تستطيع الفوز جرب واللعب الان .\n⌔  ملاحظه لديك ثلاث محاولات فقط فكر قبل ارسال تخمينك !', 1, 'md')
DevRio:setex(Prox.."GAME:TKMEN"..msg.chat_id_.."" .. msg.sender_user_id_, 100, true)  
return false  
end
end
--     Source Prox     --
if text == 'روليت' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
DevRio:del(Prox.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevRio:del(Prox..'Rio:ListRolet'..msg.chat_id_)  
DevRio:setex(Prox.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_,3600,true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  حسنا لنلعب , ارسل عدد اللاعبين للروليت .', 1, 'md')
return false  
end
end
if text and text:match("^(%d+)$") and DevRio:get(Prox.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_) then
if text == "1" then
Text = "⌔  لا استطيع بدء اللعبه بلاعب واحد فقط"
else
DevRio:set(Prox.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_,text)  
Text = '⌔  تم بدء تسجيل اللسته يرجى ارسال المعرفات \n⌔  الفائز يحصل على 5 نقاط عدد المطلوبين ↫ '..text..' لاعب'
end
DevRio:del(Prox.."Rio:StartRolet"..msg.chat_id_..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,Text)
return false
end
if text and text:match('^(@[%a%d_]+)$') and DevRio:get(Prox.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) then 
if DevRio:sismember(Prox..'Rio:ListRolet'..msg.chat_id_,text) then
send(msg.chat_id_,msg.id_,'⌔  المعرف ↫ ['..text..'] موجود اساسا')
return false
end
tdcli_function ({ID = "SearchPublicChat",username_ = text},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  المعرف غير صحيح يرجى ارسال معرف صحيح', 1, 'md')
return false 
end
DevRio:sadd(Prox..'Rio:ListRolet'..msg.chat_id_,text)
local CountAdd = DevRio:get(Prox.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_)
local CountAll = DevRio:scard(Prox..'Rio:ListRolet'..msg.chat_id_)
local CountUser = CountAdd - CountAll
if tonumber(CountAll) == tonumber(CountAdd) then 
DevRio:del(Prox.."Rio:NumRolet"..msg.chat_id_..msg.sender_user_id_) 
DevRio:setex(Prox.."Rio:WittingStartRolet"..msg.chat_id_..msg.sender_user_id_,1400,true) 
local Text = "⌔  تم ادخال المعرف ↫ ["..text.."]\n⌔  وتم اكتمال العدد الكلي هل انت مستعد ؟"
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/YesRolet"},{text="لا",callback_data="/NoRolet"}},{{text="اللاعبين",callback_data="/ListRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end 
local Text = "⌔  تم ادخال المعرف ↫ ["..text.."] وتبقى ↫ "..CountUser.." لاعبين ليكتمل العدد ارسل المعرف الاخر"
keyboard = {} 
keyboard.inline_keyboard = {{{text="الغاء",callback_data="/NoRolet"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil) 
end
--     Source Prox     --

if text == 'الالعاب' then
local Text = [[
🎮 اهلا بك في قسم الالعاب ..↑↓
 اختر العبه الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
❲[Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠](t.me/Source_Queen)❳ 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'العاب السورس💌', callback_data="/game2"},{text = 'مميزات🎪', callback_data="/game3"},
},
{
{text = 'العاب متطوره🎮', callback_data="/game1"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--     Source Prox     --
if text == 'بيع نقاطي' and ChCheck(msg) then
if tonumber((DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لم تربح اي نقطه\n⌔  ارسل ↫ الالعاب للعب', 1, 'md')
else
DevRio0 = (DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) * 50)
DevRio:incrby(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_,DevRio0)
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  تم بيع '..(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_))..' من نقاطك\n⌔  كل نقطه تساوي 50 رساله', 'md')
DevRio:del(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_)
end
end
--     Source Prox     --
if text == 'رفع المشرفين' and ChCheck(msg) or text == 'رفع الادمنيه' and ChCheck(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 200},function(arg,rio) 
local num = 0
local admins = rio.members_  
for i=0 , #admins do   
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
num = num + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,dp) 
if dp.first_name_ == false then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
end
end,nil)   
else
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)   
end 
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then  
Manager_id = admins[i].user_id_  
DevRio:sadd(Prox..'Rio:BasicConstructor:'..msg.chat_id_,Manager_id)  
DevRio:sadd(Prox..'Rio:RioConstructor:'..msg.chat_id_,Manager_id)   
end  
end  
if num == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا يوجد ادمنيه ليتم رفعهم\n⌔  تم رفع مالك المجموعه", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم رفع '..num..' من الادمنيه \n⌔  تم رفع مالك المجموعه', 1, 'md')
end
end,nil) 
end
--     Source Prox     --
if text == 'غادر' and SudoBot(msg) and ChCheck(msg) then
if DevRio:get(Prox.."Rio:Left:Bot"..Prox) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "⌔  المغادره معطله من قبل المطور الاساسي", 1, 'md')
return false  
end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم مغادرة المجموعه \n⌔  تم حذف جميع بياناتها ', 1, 'md')
ChatLeave(msg.chat_id_, Prox)
DevRio:srem(Prox.."Rio:Groups",msg.chat_id_)
end
--     Source Prox     --
if text ==('موقعي') and ChCheck(msg) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da.status_.ID == "ChatMemberStatusCreator" then
rtpa = 'المنشئ'
elseif da.status_.ID == "ChatMemberStatusEditor" then
rtpa = 'الادمن'
elseif da.status_.ID == "ChatMemberStatusMember" then
rtpa = 'عضو'
end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  موقعك ↫ '..rtpa, 1, 'md')
end,nil)
end
--     Source Prox     --
if text == "معلوماتي" and ChCheck(msg) then
function get_me(extra,result,success)
local msguser = tonumber(DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local cont = (tonumber(DevRio:get(Prox..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local user_nkt = tonumber(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
if result.username_ then username = '@'..result.username_ else username = 'لا يوجد' end
if result.last_name_ then lastname = result.last_name_ else lastname = '' end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  اسمك ↫ 〈 ['..result.first_name_..'] 〉\n⌔  معرفك ↫ 〈 ['..username..'] 〉\n⌔  ايديك ↫ 〈 `'..result.id_..'` 〉\n⌔  نقاطك ↫ 〈 '..user_nkt..' 〉\n⌔  رسائلك ↫ 〈 '..user_msgs..' 〉\n⌔  جهاتك ↫ 〈 '..cont..' 〉\n⌔  تفاعلك ↫ '..formsgs(msguser)..'\n⌔  رتبتك ↫ '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'md')
end
getUser(msg.sender_user_id_,get_me)
end
end
--     Source Prox     --
if text == "تعيين قناة الاشتراك" or text == "تغيير قناة الاشتراك" or text == "تعيين الاشتراك الاجباري" or text == "وضع قناة الاشتراك" or text == "↫ تعيين قناة الاشتراك ⌔" then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
DevRio:setex(Prox..'DevRio4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_, '⌔  ارسل لي معرف قناة الاشتراك الان')
end
return false  
end
if text == "تفعيل الاشتراك الاجباري" or text == "↫  تفعيل الاشتراك الاجباري ⌔" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
if DevRio:get(Prox..'Rio:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(Prox.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_,"⌔  الاشتراك الاجباري مفعل \n⌔  على القناة ↫ [@"..GetInfo.result.username.."]")
else
DevRio:setex(Prox..'DevRio4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_,"⌔  لاتوجد قناة لتفعيل الاشتراك\n⌔  ارسل لي معرف قناة الاشتراك الان")
end
end
return false  
end
if text == "تعطيل الاشتراك الاجباري" or text == "↫  تعطيل الاشتراك الاجباري ⌔" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
DevRio:del(Prox..'Rio:ChId')
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الاشتراك الاجباري'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
return false  
end
if text == "حذف قناة الاشتراك" or text == "حذف قناه الاشتراك" or text == "↫ حذف قناة الاشتراك ⌔" then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
DevRio:del(Prox..'Rio:ChId')
Dev_Rio(msg.chat_id_, msg.id_, 1,"⌔  تم حذف قناة الاشتراك الاجباري", 1, 'md') 
end
end
if Sudo(msg) then
if text == 'جلب قناة الاشتراك' or text == 'قناة الاشتراك' or text == 'الاشتراك الاجباري' or text == 'قناة الاشتراك الاجباري' or text == '↫ قناة الاشتراك ⌔' then
if DevRio:get(Prox..'Rio:ChId') then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(Prox.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_, "⌔  قناة الاشتراك ↫ [@"..GetInfo.result.username.."]")
else
send(msg.chat_id_, msg.id_, "⌔  لاتوجد قناة في الاشتراك الاجباري")
end
return false  
end end
--     Source Prox     --
if SudoBot(msg) then
if text == 'اذاعه للكل بالتوجيه' and tonumber(msg.reply_to_message_id_) > 0 then
function ProxTeam(extra,result,success)
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
local GpList = DevRio:smembers(Prox.."Rio:Groups")
for k,v in pairs(GpList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
local PvList = DevRio:smembers(Prox.."Rio:Users")
for k,v in pairs(PvList) do
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = result.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم اذاعة رسالتك بالتوجيه \n⌔  ‏في ↫ 〈 '..#GpList..' 〉 مجموعه \n⌔  والى ↫ 〈 '..#PvList..' 〉 مشترك \n ✓', 1, 'md')
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ProxTeam)
end
end
--     Source Prox     --
if text == "مشاهده المنشور" and ChCheck(msg) or text == "مشاهدات المنشور" and ChCheck(msg) or text == "عدد المشاهدات" and ChCheck(msg) then
DevRio:set(Prox..'Rio:viewget'..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  حسنا قم باعادة توجيه للمنشور الذي تريدني حساب مشاهداته', 1, 'md')
end
--     Source Prox     --
--     Source keloa     --
if text == 'السورس' or text == 'سورس' or text == 'ياسورس' or text == "يا سورس" then
local Text =[[

╭ ─ ─ ─ ─ ─ ─ ─ 🚨 . 
╰➛ ⌯ 𝗪𝗲𝗹𝗰𝗼𝗺𝗲 𝗧𝗼 𝗦𝗼𝘂𝗿𝗰𝗲 𝗸𝗲𝗹𝗼𝗮 ⌯
╭ ─ ─ ─ ─ ─ ─ ─  🤍. 
╰➛ ⌯ 𝗧𝗵𝗲 𝗕𝗲𝘀𝘁 𝗦𝗼𝘂𝗿𝗰𝗲 𝗜𝗻 𝗧𝗲𝗹𝘆 ⌯
╭ ─ ─ ─ ─ ─ ─ ─ 🫀. 
╰➛ ⌯ 𝗦𝗽𝗲𝗲𝗱 , 𝗔𝗰𝗰𝘂𝗥𝗮𝗰𝘆 , 𝗦𝗮𝗙𝗲𝗧𝘆 ⌯

]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⌯ 𝗖𝗵𝗮𝗻𝗻𝗲𝗹 𝗸𝗲𝗹𝗼𝗮 ⌯ ',url="t.me/F_L_3"}},
{{text = '⌯ 𝗛𝗶𝗮𝘃𝗲𝗲𝗻 ⌯',url="t.me/I_4_J"},{text = '⌯ 𝙢𝙖𝙜𝙞𝙙 ⌯',url="t.me/MAGID_ALI_10"}},
{{text = '⌯ 𝗖𝗵𝗮𝗻𝗻𝗲𝗹 𝗩𝗜𝗣 ⌯',url="t.me/source_Laren"}},
{{text = '⌯ 𝙀𝙭𝙥 𝙠𝙚𝙡𝙤𝙖 ⌯ ',url="t.me/Y_2_I"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendvideo?chat_id=' .. msg.chat_id_ .. '&video=https://t.me/F_L_3/84&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

if text == 'نكت' and ChCheck(msg) or text == 'نكته' and ChCheck(msg) or text == 'ضحكني' and ChCheck(msg) or text == '↫ ضحكه⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
" مرة واحد مصري دخل سوبر ماركت في الكويت عشان يشتري ولاعة..    راح عشان يحاسب بيقوله الولاعة ديه بكام؟   قاله دينار..  قاله منا عارف ان هي نار بس بكام 🤓😂", 
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 🤓😂 ", 
"واحد بيشتكي لصاحبه بيقوله أنا مافيش حد بيحبني ولا يفتكرني أبدًا، ومش عارف أعمل إيه.. قاله سهلة.. استلف من الناس فلوس هيسألوا عليك كل يوم! 🤓😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه. 🤓😂",
"واحده ست سايقه على الجي بي اس..  قالها انحرفي قليلًا..   قلعت الطرحة. 🤓😂 ",
"مرة واحد غبي معاه عربية قديمة جدًا وبيحاول يبيعها وماحدش راضي يشتريها.. راح لصاحبه حكاله المشكلة.. صاحبه قاله عندي لك فكرة جهنمية هاتخليها تتباع الصبح.. أنت تجيب علامة مرسيدس وتحطها عليها. بعد أسبوعين صاحبه شافه صدفة قاله بعت العربية ولا لاء؟ قاله انت  مجنون؟ حد يبيع مرسيدس؟ 🤓😂",
"مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه. 🤓😂",
"واحدة عملت حساب وهمي ودخلت تكلم جوزها منه.. ومبسوطة أوي وبتضحك.. سألوها بتضحكي على إيه؟ قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا. 🤓😂",
"بنت حبت تشتغل مع رئيس عصابة..   شغلها في غسيل الأموال 🤓😂",
"مره واحد اشترى فراخ..   علشان يربيها فى قفص صدره.🤓😂",
"مرة واحد من الفيوم مات..   أهله صوصوا عليه.🤓😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟    ﻗﺎﻟﻬﺎ اﻫﻮه..   ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ..   ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه.🤓😂",
"مره واحد شاط كرة فى المقص..   اتخرمت. 🤓😂",
"مرة واحد رايح لواحد صاحبه.. فا البواب وقفه بيقول له انت طالع لمين.. قاله طالع أسمر شوية لبابايا.. قاله يا أستاذ طالع لمين في العماره 🤓😂",
} 
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end
--     Source keloa     --
if text == 'كت تويت' and ChCheck(msg) or text == 'كت' and ChCheck(msg) or text == 'تويت' and ChCheck(msg) or text == '↫ كت ⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" آخر مره ضربت عشره كانت متى ؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"آخر مره ضربت عشره كانت متى ؟", 
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
  "تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "هل انت حرامي تويت بتعت باندا؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغيرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغيره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end

if text == 'حروف' and ChCheck(msg) or text == 'ححرووف' and ChCheck(msg) or text == 'تحح2ت' and ChCheck(msg) or text == '↫ ك2⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
" جماد بحرف ⇦ر  ", 
" مدينة بحرف ⇦ع  ",
" حيوان ونبات بحرف ⇦خ  ", 
" اسم بحرف ⇦ح  ", 
" اسم ونبات بحرف ⇦م  ", 
" دولة عربية بحرف ⇦ق  ", 
" جماد بحرف ⇦ي  ", 
" نبات بحرف ⇦ج  ", 
" اسم بنت بحرف ⇦ع  ", 
" اسم ولد بحرف ⇦ع  ", 
" اسم بنت وولد بحرف ⇦ث  ", 
" جماد بحرف ⇦ج  ",
" حيوان بحرف ⇦ص  ",
" دولة بحرف ⇦س  ",
" نبات بحرف ⇦ج  ",
" مدينة بحرف ⇦ب  ",
" نبات بحرف ⇦ر  ",
" اسم بحرف ⇦ك  ",
" حيوان بحرف ⇦ظ  ",
" جماد بحرف ⇦ذ  ",
" مدينة بحرف ⇦و  ",
" اسم بحرف ⇦م  ",
" اسم بنت بحرف ⇦خ  ",
" اسم و نبات بحرف ⇦ر  ",
" نبات بحرف ⇦و  ",
" حيوان بحرف ⇦س  ",
" مدينة بحرف ⇦ك  ",
" اسم بنت بحرف ⇦ص  ",
" اسم ولد بحرف ⇦ق  ",
" نبات بحرف ⇦ز  ",
"  جماد بحرف ⇦ز  ",
"  مدينة بحرف ⇦ط  ",
"  جماد بحرف ⇦ن  ",
"  مدينة بحرف ⇦ف  ",
"  حيوان بحرف ⇦ض  ",
"  اسم بحرف ⇦ك  ",
"  نبات و حيوان و مدينة بحرف ⇦س  ", 
"  اسم بنت بحرف ⇦ج  ", 
"  مدينة بحرف ⇦ت  ", 
"  جماد بحرف ⇦ه  ", 
"  اسم بنت بحرف ⇦ر  ", 
" اسم ولد بحرف ⇦خ  ", 
" جماد بحرف ⇦ع  ",
" حيوان بحرف ⇦ح  ",
" نبات بحرف ⇦ف  ",
" اسم بنت بحرف ⇦غ  ",
" اسم ولد بحرف ⇦و  ",
" نبات بحرف ⇦ل  ",
"مدينة بحرف ⇦ع  ",
"دولة واسم بحرف ⇦ب  ",
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end

if text == 'بوستات' and ChCheck(msg) or text == 'بوست' and ChCheck(msg) or text == 'تحح2ت' and ChCheck(msg) or text == '↫ ك2⌔' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
"الجمال يلفت الأنظار لكن الطيبه تلفت القلوب🙂 .!",
"لا تحقرون صغيره إن الجبال من الحصي 💖",
"لا تمد عينك في يد غيرك 💕",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ. 🌚.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك. 🤫 .!",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨ ",
"‏أَكَان عَلَيَّ أَنْ أغْرَس ان.بي فِي قَلْبِك لتشعر بِي ؟. 😁",
"‏ إن الأمر ينتهي بِنا إلى أعت.د أي شيء. 😎",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ. 😃",
"لا تظلم حتى لا تتظلم 😊",
"لا ح.ه للإنسان بلا نبات ☺️",
"لا تقف قصاد الريح ولا تمشي معها.... ❤️",
" لا تملح الا لمن يستحقاها ويحافظ عليها😛",
"لا يدخل الجنه من لايأمن من جازه بوائقه 😿.",
"لا دين لمن لا عهد له 💞 ",
"لا تظلم حتى لا تتظلم 🌚.",
"عامل الناس بأخلاقك ولا بأخلاقهم 💞⛷️",
"لا تقف قصاد الريح ولا تمشي معها.... 💚 ",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟ 🙂 .!",
"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار. »💛",
"‏ ‏كل العالم يهون بس الدن. بينا تصفي 💙 ",
"‏ إن الأمر ينتهي بِنا إلى أعت.د أي شيء. 😚 ",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار. 💝",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ 🙂 .!",
"‏من علامات جمال المرأة .. بختها المايل ! ❤️",
"‏ علينا إح.ء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة.💜 ",
"‏ : كُلما أتبع قلبي يدلني إليك . 😜",
"‏ انك الجميع و كل من احتل قلبي🫀🤍 ",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖 ",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️ ",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ 💕",
" ‏ ‏تبدأ ح.تك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.💖",
"الجمال يلفت الأنظار لكن الطيبه تلفت القلوب 😁",
"كما تدين تدان 😊",
"عامل الناس بأخلاقك ولا بأخلاقهم 🙂",
"يسروا ولا تعسروا... ويشورا ولا تنفروا 💕",
" لا يدخل الجنه من لايأمن من جازه بوائقه💓",
" كل كتير عادي ميهمكش😂❤️",
"لا تملح الا لمن يستحقاها ويحافظ عليها 💞 ",
" الجمال يلفت الأنظار لكن الطيبه تلفت القلوب💞 ",
" خليك طبيعي مش نورم😇❤️ ",
" الدن. حلوه متزعلش علي ناس ماتستاهلش🌝🏃‍♂️",
" العقل السليم ف البعد عن الحريم😇❤️",
"عيش الح.ه يوم واحد 🙂 .! ",
"امشي كتير عشان تخس 🧐 .! ",
" اشرب ميه كتير 😎.",
"كُنْ لحوحاً فِي الدّعاءِ،فقدْ أوشكَ السّهمُ أنْ يُصيبَ. 💗",
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end

if text == 'كتبات' and ChCheck(msg) or text == 'كتابه' and ChCheck(msg) or text == 'كتباتي' and ChCheck(msg) or text == 'حكمه' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ",
"‏من علامات جمال المرأة .. بختها المايل ! ",
"‏ انك الجميع و كل من احتل قلبي🫀🤍",
"‏لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️",
"‏‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة.🦇💜",
"‏ يجي اي الصاروخ الصيني ده جمب الصاروخ المصري لما بيلبس العبايه السوده.🤩♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.",
"‏ كُلما أتبع قلبي يدلني إليك .",
"‏  أيا ليت من تَهواه العينُ تلقاهُ .",
"‏ ‏رغبتي في مُعانقتك عميقة جداً .🥥",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨",
"‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. 🦇 ",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ.",
"‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.",
"‏ ‏هَتفضل توآسيهُم وآحد ورآ التآني لكن أنتَ هتتنسي ومحدِش هَيوآسيك.",
"‏ جَبَرَ الله قلوبِكُم ، وقَلبِي .🍫",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖",
"‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤",
"‏ أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ",
"‏ وانتهت صداقة الخمس سنوات بموقف.",
"‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.",
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end

if text == 'باد' and ChCheck(msg) or text == 'xx' and ChCheck(msg) or text == 'سكس' and ChCheck(msg) or text == 'بتسكسك' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Games'..msg.chat_id_) then
local ProxTeam = {
" اول مره سكسكتي امتا🥵",
" جبتيهم قبل كدا كام مرا ?🥵",
" لو قربت منك ومسكت بزك هتيجي ?🥵",
" مين الممثله اللي نفسك تعمل معاها احيه ???",
" لو جاتلك فرصه تمارسي الجنس المخفف راح توافقي او لا ?🥵",
"اخر مرهه غفلت حد وعملت معاه الجولاشه امته ?🥵 ",
" اي اكتر حاجه بتشدك لجسم الجنس الاخر ?🥵",
" بعتي نودز لكام ولد ?🥵",
" عمرك سكسكتي مع ولد ?🥵",
" بتسكسك مع كام بنت ?🥵",
"قبلتي صديقك قبل كدا ?🥵 ",
" عمرك مارست الجنس ?🥵",
" ما رأيك في اللون الاسود حينما ترتديه فتاه بيضاء ?🥵",
" اخر مره قبلت بنت ?🥵",
"اخر مره قبلتي ولد ?🥵 ",
" مشتهي شي ?🥵",
"اخر مره قمت بزياره المواقع الايباحيه ?🥵 ",
"بدك تمارسي العاده السريه من الامام ام الخلف ? 🥵",
"ما المكان المفضل لك في ممارسه الجنس ?🥵 ",
" متي قمت بممارسه العاده السريه اخر مره ?🥵",
" ما لون ملابسك الداخليه المفضل ???",
"ما مقاس البرا التي ترتديها الان ?🥵 ",
" كم مرا نكت بنت ؟🥵",
"اخر مرا دخلت الحمام ؟🥵 ",
"فشخت كام بنت🥵  ",
" بلغت ولا لا 🥵",
" عايز تنيك ولا لا 🥵",
"حابه تفتحي تيزيك🥵  ",
"اخر مره سكستي امته 🥵 ",
"حبه تتناكي من مين🥵 ",
}  
Dev_Rio(msg.chat_id_, msg.id_, 1, ''..ProxTeam[math.random(#ProxTeam)]..'' , 1, 'md')  
return false
end
end

--     Source DevProx     --
if text == 'المطور' or text == 'مطور' or text == '↫ المطور ⌔' then
tdcli_function({ID="GetUser",user_id_=DevId},function(arg,result)
local msg_id = msg.id_/2097152/0.5
Text = "*⋆ Dev Name ⤌ * ["..result.first_name_.."](T.me/"..result.username_..")\n*⋆ Dev User ⤌* [@"..result.username_.."]"
keyboard = {}
keyboard.inline_keyboard = {{{text = ''..result.first_name_..' ',url="t.me/"..result.username_ or F_L_3}}}
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/'..result.username_..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end

-----------------------------------------------------------------------------
--     Source Prox     --
if ChatType == 'sp' or ChatType == 'gp'  then
if text == "اطردني" and ChCheck(msg) or text == "ادفرني" and ChCheck(msg) then
if DevRio:get(Prox.."Rio:Kick:Me"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عذرا هذه الخاصيه معطله ', 1, 'md')
return false
end
DevRio:set(Prox..'yes'..msg.sender_user_id_, 'delyes')
DevRio:set(Prox..'no'..msg.sender_user_id_, 'delno')
local Text = '⌔  هل انت متأكد من المغادره'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/delyes"},{text="لا",callback_data="/delno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--     Source Prox     --
if text == 'تعطيل اطردني' and Manager(msg) and ChCheck(msg) then
DevRio:set(Prox.."Rio:Kick:Me"..msg.chat_id_, true)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل امر اطردني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
if text == 'تفعيل اطردني' and Manager(msg) and ChCheck(msg) then
DevRio:del(Prox.."Rio:Kick:Me"..msg.chat_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل امر اطردني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
--     Source Prox     --
if text == "نزلني" and ChCheck(msg) then
if DevRio:get(Prox.."Rio:Del:Me"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عذرا هذه الخاصيه معطله ', 1, 'md')
return false
end
DevRio:set(Prox..'yesdel'..msg.sender_user_id_, 'delyes')
DevRio:set(Prox..'nodel'..msg.sender_user_id_, 'delno')
local Text = '⌔  هل انت متأكد من تنزيلك'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/yesdel"},{text="لا",callback_data="/nodel"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
--     Source Prox     --
if text == 'تعطيل نزلني' and BasicConstructor(msg) and ChCheck(msg) then
DevRio:set(Prox.."Rio:Del:Me"..msg.chat_id_, true)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل امر نزلني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
if text == 'تفعيل نزلني' and BasicConstructor(msg) and ChCheck(msg) then
DevRio:del(Prox.."Rio:Del:Me"..msg.chat_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل امر نزلني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
--     Source Prox     --
if text and (text == 'تفعيل التاك' or text == 'تفعيل التاك للكل' or text == 'تفعيل تاك للكل') and Admin(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل امر تاك للكل'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:TagAll'..msg.chat_id_)
end
if text and (text == 'تعطيل التاك' or text == 'تعطيل التاك للكل' or text == 'تعطيل تاك للكل') and Admin(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل امر تاك للكل'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:TagAll'..msg.chat_id_,true)
end
if Admin(msg) then
if text == "تاك للكل" and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "⌔  وينكم يالربع \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevRio:get(Prox..'Save:UserName'..v.user_id_) then
text = text..i.."~ : [@"..DevRio:get(Prox..'Save:UserName'..v.user_id_).."]\n"
else
text = text..i.."~ : "..v.user_id_.."\n"
end
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
--     Source Prox     --
if text and text:match("^كللهم (.*)$") and ChCheck(msg) then
local txt = {string.match(text, "^(كللهم) (.*)$")}
if not DevRio:get(Prox..'Rio:Lock:TagAll'..msg.chat_id_) then
function TagAll(dp1,dp2)
local text = "⌔  "..txt[2].." \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
i = 0
for k, v in pairs(dp2.members_) do
i = i + 1
if DevRio:get(Prox..'Save:UserName'..v.user_id_) then
text = text..i.."~ : [@"..DevRio:get(Prox..'Save:UserName'..v.user_id_).."]\n"
else
text = text..i.."~ : "..v.user_id_.."\n"
end
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID, offset_ = 0,limit_ = 200000},TagAll,nil)
end
end
end
--     Source Prox     --
if text == "رسائلي" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عدد رسائلك هنا ↫ *〈 "..user_msgs.." 〉*", 1, 'md')
end
if text == "التفاعل" and ChCheck(msg) then
local EntryNumber = (DevRio:get(Prox..'Rio:EntryNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local ExitNumber = (DevRio:get(Prox..'Rio:ExitNumber'..msg.chat_id_..':'..os.date('%d')) or 0)
local MsgNumberDay = (DevRio:get(Prox..'Rio:MsgNumberDay'..msg.chat_id_..':'..os.date('%d')) or 0)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  انضمام الاعضاء اليوم ↫ *"..EntryNumber.."*\n⌔  مغادرة الاعضاء اليوم ↫ *"..ExitNumber.."*\n⌔  عدد الرسائل اليوم ↫ *"..MsgNumberDay.."*\n⌔  نسبة التفاعل اليوم ↫ *"..math.random(40,100).."%*", 1, 'md')
end
--     Source Prox     --
if text == "تعطيل تفاعلي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل تفاعلي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:msg:Rio'..msg.chat_id_) 
end
if text == "تفعيل تفاعلي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل تفاعلي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:msg:Rio'..msg.chat_id_,true)  
end
if DevRio:get(Prox.."Rio:msg:Rio"..msg.chat_id_) then
if msg.content_.ID then
get_msg = DevRio:get(Prox.."Rio:msg:Rio"..msg.sender_user_id_..":"..msg.chat_id_) or 0
gms = get_msg + 1
DevRio:setex(Prox..'Rio:msg:Rio'..msg.sender_user_id_..":"..msg.chat_id_,86400,gms)
end
if text == "تفاعلي" and tonumber(msg.reply_to_message_id_) == 0 then    
get_msg = DevRio:get(Prox.."Rio:msg:Rio"..msg.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"⌔  عدد رسائلك الكلي هو ↬\n"..get_msg.." من الرسائل")
end  
if text == "تفاعله" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
get_msg = DevRio:get(Prox.."Rio:msg:Rio"..result.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"⌔  عدد رسائله الكلي هو ↬\n"..get_msg.." من الرسائل")
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
end
--     Source Prox     --
if text == "جهاتي" and ChCheck(msg) or text == "اضافاتي" and ChCheck(msg) then add = (tonumber(DevRio:get(Prox..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0) Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عدد جهاتك المضافه ↫ *〈 "..add.." 〉* ", 1, 'md') end
if text == "تعديلاتي" or text == "سحكاتي" and ChCheck(msg) then local edit_msg = DevRio:get(Prox..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0  Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عدد تعديلاتك ↫ *〈 "..edit_msg.." 〉* ", 1, 'md') end
if text == "رتبتي" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  رتبتك ↫ '..IdRank(msg.sender_user_id_, msg.chat_id_), 1, 'html') end
if text == "ايدي المجموعه" and ChCheck(msg) then Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ايدي المجموعه ↫ `"..msg.chat_id_.."`", 1, 'md') end
if text == 'مسح سحكاتي' or text == 'مسح تعديلاتي' or text == 'حذف سحكاتي' or text == 'حذف تعديلاتي' then DevRio:del(Prox..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف جميع تعديلاتك بنجاح' , 1, 'md') end
if text == 'مسح جهاتي' or text == 'مسح اضافاتي' or text == 'حذف جهاتي' or text == 'حذف اضافاتي' then DevRio:del(Prox..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_) Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف جميع جهاتك المضافه' , 1, 'md') end
--     Source Prox     --
if text and text:match('^هينه @(.*)') and ChCheck(msg) or text and text:match('^هينها @(.*)') and ChCheck(msg) then 
if not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^هينه @(.*)') or text:match('^هينها @(.*)') 
function ProxTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'شو تمضرط اكو واحد يهين نفسه؟🤔👌🏿', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md') 
return false  
end  
if tonumber(result.id_) == tonumber(1823672541) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md') 
return false  
end  
if DevRio:sismember(Prox.."Rio:RioConstructor:"..msg.chat_id_,result.id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
local ProxTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md') 
local ProxTeam = { "لكك جرجف @"..username.." احترم اسيادكك لا اكتلكك وازربب على كبركك،💩🖐🏿","هشش لكك فاشل @"..username.." لتضل تمسلت لا اخربط تضاريس وجهك جنه ابط عبده، 😖👌🏿","حبيبي @"..username.." راح احاول احترمكك هالمره بلكي تبطل حيونه، 🤔🔪","دمشي لك @"..username.." ينبوع الفشل مو زين ملفيك ونحجي وياك هي منبوذ 😏🖕🏿","ها الغليض التفس ابو راس المربع @"..username.." متعلملك جم حجايه وجاي تطكطكهن علينه دبطل😒🔪",}
Dev_Rio(msg.chat_id_, result.id_, 1,''..ProxTeam[math.random(#ProxTeam)], 1, 'html') 
else  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,ProxTeam)
end
end
--     Source Prox     --
if text == ("هينه") or text == ("بعد هينه") or text == ("هينه بعد") or text == ("لك هينه") or text == ("هينها") or text == ("هينهه") or text == ("رزله") or text == ("رزلهه") or text == ("رزلها") then
if not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) then
function hena(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(Prox) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'شو تمضرط اكو واحد يهين نفسه؟🤔👌🏿', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
if tonumber(result.sender_user_id_) == tonumber(1823672541) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
if DevRio:sismember(Prox.."Rio:RioConstructor:"..msg.chat_id_,result.sender_user_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, 'دي لكك تريد اهينن تاج راسكك؟😏🖕🏿', 1, 'md')
return false
end 
local ProxTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md') 
local ProxTeam = {"لكك جرجف احترم اسيادكك لا اكتلكك وازربب على كبركك،💩🖐🏿","هشش فاشل لتضل تمسلت لا اخربط تضاريس وجهك جنه ابط عبده، 😖👌🏿","دمشي لك ينبوع الفشل مو زين ملفيك ونحجي وياك هي منبوذ 😏🖕🏿","ها الغليض التفس ابو راس المربع متعلملك جم حجايه وجاي تطكطكهن علينه دبطل😒🔪","حبيبي راح احاول احترمكك هالمره بلكي تبطل حيونه، 🤔🔪"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..ProxTeam[math.random(#ProxTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),hena)   
end
end
end
if text == ("بوسه") or text == ("بعد بوسه") or text == ("ضل بوس") or text == ("بوسه بعد") or text == ("بوسها") or text == ("بعد بوسها") or text == ("ضل بوس") or text == ("بوسها بعد") or text == ("بوسهه") then
if not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) then
function bosh(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(Prox) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح ابوس نفسيي؟😶💔', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, result.id_, 1, 'مواححح احلاا بوسةة المطوريي😻🔥💗', 1, 'html')
return false
end 
local ProxTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md') 
local ProxTeam = {"مواححح افيش عافيههه😍🔥💗","امممووااهحح شهلعسل🥺🍯💘","مواححح،ءوفف اذوب🤤💗"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..ProxTeam[math.random(#ProxTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),bosh)   
end
end
end
if text == ("صيحه") or text == ("صيحها") or text == ("صيحهه") or text == ("صيح") then
if not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) then
function seha(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(Prox) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح اصيح نفسيي؟😶💔', 1, 'md') 
return false  
end  
if tonumber(result.sender_user_id_) == tonumber(DevId) then  
Dev_Rio(msg.chat_id_, result.id_, 1, 'تعال مطوريي محتاجيكك🏃🏻‍♂️♥️', 1, 'html')
return false
end 
local ProxTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md') 
local ProxTeam = {"تتعال ححب محتاجيك🙂🍭","تعال يولل استاذكك ايريدككك😒🔪","يمعوود تعاال يريدوكك🤕♥️","تعال لكك ديصيحوك😐🖤"} 
Dev_Rio(msg.chat_id_, result.id_, 1,''..ProxTeam[math.random(#ProxTeam)], 1, 'md') 
end 
if tonumber(msg.reply_to_message_id_) == 0 then
else 
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),seha)   
end
end
end
--     Source Prox     --
if text and text:match('^صيحه @(.*)') and ChCheck(msg) or text and text:match('^صيح @(.*)') and ChCheck(msg) then 
if not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) then
local username = text:match('^صيحه @(.*)') or text:match('^صيح @(.*)') 
function ProxTeam(extra,result,success)
if result.id_ then  
if tonumber(result.id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, 'فهمنيي شلوون راحح اصيح نفسيي؟😶💔', 1, 'md')  
return false 
end  
if tonumber(result.id_) == tonumber(DevId) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, 'تعال مطوريي محتاجيكك🏃🏻‍♂️♥️ @'..username, 1, 'html') 
return false  
end  
local ProxTeam = "صارر ستاذيي 🏃🏻‍♂️♥️" 
Dev_Rio(msg.chat_id_, msg.id_, 1,ProxTeam, 1, 'md') 
local ProxTeam = { "تتعال ححب @"..username.." محتاجيك🙂🍭","تعال يولل @"..username.." استاذكك ايريدككك😒🔪","يمعوود @"..username.." تعاال يريدوكك🤕♥️","تعال لكك @"..username.." ديصيحوك😐🖤",}
Dev_Rio(msg.chat_id_, result.id_, 1,''..ProxTeam[math.random(#ProxTeam)], 1, 'html') 
else  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العضو غير موجود في المجموعه', 1, 'md') 
end 
end 
resolve_username(username,ProxTeam)
end
end
end
--     Source Prox     --
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) and ChCheck(msg) then 
function promote_by_reply(extra, result, success)
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتستطيع تنزيل المطور الاساسي", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.sender_user_id_) then
riosudo = 'المطورين الاساسيين • ' else riosudo = '' end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.sender_user_id_) then
secondsudo = 'المطورين الثانويين • ' else secondsudo = '' end
if DevRio:sismember(Prox..'Rio:SudoBot:',result.sender_user_id_) then
sudobot = 'المطورين • ' else sudobot = '' end
if DevRio:sismember(Prox..'Rio:BasicConstructor:'..msg.chat_id_, result.sender_user_id_) then
basicconstructor = 'المنشئين الاساسيين • ' else basicconstructor = '' end
if DevRio:sismember(Prox..'Rio:Constructor:'..msg.chat_id_, result.sender_user_id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevRio:sismember(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_) then
manager = 'المدراء • ' else manager = '' end
if DevRio:sismember(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevRio:sismember(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevRio:sismember(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_) then
cleaner = 'المنظفين • ' else cleaner = ''
end
if RankChecking(result.sender_user_id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من ↫ ⤈\n~ ( "..riosudo..secondsudo..sudobot..basicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  لم تتم ترقيته مسبقا")  
end
if RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevRio:srem(Prox..'Rio:RioSudo:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:SecondSudo:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'riosudo' then
DevRio:srem(Prox..'Rio:SecondSudo:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevRio:srem(Prox..'Rio:SudoBot:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'rioconstructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'basicconstructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.sender_user_id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.sender_user_id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.sender_user_id_)
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) and ChCheck(msg) then
local rem = {string.match(text, "^(تنزيل الكل) @(.*)$")}
function remm(extra, result, success)
if result.id_ then
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتستطيع تنزيل المطور الاساسي", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.id_) then
Riosudo = 'المطورين الاساسيين • ' else Riosudo = '' end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.id_) then
secondsudo = 'المطورين الثانويين • ' else secondsudo = '' end
if DevRio:sismember(Prox..'Rio:SudoBot:',result.id_) then
sudobot = 'المطورين • ' else sudobot = '' end
if DevRio:sismember(Prox..'Rio:BasicConstructor:'..msg.chat_id_, result.id_) then
basicconstructor = 'المنشئين الاساسيين • ' else basicconstructor = '' end
if DevRio:sismember(Prox..'Rio:Constructor:'..msg.chat_id_, result.id_) then
constructor = 'المنشئين • ' else constructor = '' end 
if DevRio:sismember(Prox..'Rio:Managers:'..msg.chat_id_, result.id_) then
manager = 'المدراء • ' else manager = '' end
if DevRio:sismember(Prox..'Rio:Admins:'..msg.chat_id_, result.id_) then
admins = 'الادمنيه • ' else admins = '' end
if DevRio:sismember(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_) then
vipmem = 'المميزين • ' else vipmem = '' end
if DevRio:sismember(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_) then
cleaner = 'المنظفين • ' else cleaner = ''
end
if RankChecking(result.id_,msg.chat_id_) ~= false then
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من ↫ ⤈\n~ ( "..riosudo..secondsudo..sudobot..basicconstructor..constructor..manager..admins..vipmem..cleaner.." ) ~")  
else 
ReplyStatus(msg,result.id_,"Reply","⌔  لم تتم ترقيته مسبقا")  
end 
if RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudoid' then
DevRio:srem(Prox..'Rio:RioSudo:', result.id_)
DevRio:srem(Prox..'Rio:SecondSudo:', result.id_)
DevRio:srem(Prox..'Rio:SudoBot:', result.id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'riosudo' then
DevRio:srem(Prox..'Rio:SecondSudo:', result.id_)
DevRio:srem(Prox..'Rio:SudoBot:', result.id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'secondsudo' then
DevRio:srem(Prox..'Rio:SudoBot:', result.id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'sudobot' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'rioconstructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'basicconstructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'constructor' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_, result.id_)
elseif RioDelAll(msg.sender_user_id_,msg.chat_id_) == 'manager' then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, result.id_)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_, result.id_)
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المعرف غير صحيح*', 1, 'md')
end
end
resolve_username(rem[2],remm)
end
--     Source Prox     --
if text ==('اضف رتبه') or text ==('رفع رتبه') and ChCheck(msg) then
function sudo_ght(extra, result, success)
local Text = "اضغط علي الرتبه التي تريد رفع بها"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'مطور ثانوي', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/SecondSudo"},{text = 'مطور', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/Sudo"},
},
{
{text = 'منشئ اساسي', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/BasicConstructor"},{text = 'منشئ', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/Constructor"},
},
{
{text = 'مدير', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/Manager"},{text = 'ادمن', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/Admin"},
},
{
{text = 'مالك', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/AbsConstructor"},
},
{
{text = 'مميز', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/vip"},{text = 'مميز عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/VipAll"},
},
{
{text = 'ادمن عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/AdminAll"},{text = 'مدير عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.sender_user_id_.."/ManagerAll"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_ght)
end 
end
if text and (text:match('^اضف رتبه @(.*)') or text:match('^رفع رتبه @(.*)')) and ChCheck(msg) then
local username = text:match('^اضف رتبه @(.*)') or text:match('^رفع رتبه @(.*)')
function drrreply(extra,result,success)
if result.id_ then
local Text = "اضغط علي الرتبه التي تريد رفع بها"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'مطور ثانوي', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/SecondSudo"},{text = 'مطور', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/Sudo"},
},
{
{text = 'منشئ اساسي', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/BasicConstructor"},{text = 'منشئ', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/Constructor"},
},
{
{text = 'مدير', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/Manager"},{text = 'ادمن', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/Admin"},
},
{
{text = 'مالك', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/AbsConstructor"},
},
{
{text = 'مميز', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/vip"},{text = 'مميز عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/VipAll"},
},
{
{text = 'ادمن عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/AdminAll"},{text = 'مدير عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..result.id_.."/ManagerAll"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
 end
resolve_username(username,drrreply)
end
if text and (text:match('^اضف رتبه (%d+)') or text:match('^رفع رتبه (%d+)')) and ChCheck(msg) then
local user = text:match('اضف رتبه (%d+)') or text:match('رفع رتبه (%d+)')
local Text = "اضغط علي الرتبه التي تريد رفع بها"
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'مطور ثانوي', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/SecondSudo"},{text = 'مطور', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/Sudo"},
},
{
{text = 'منشئ اساسي', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/BasicConstructor"},{text = 'منشئ', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/Constructor"},
},
{
{text = 'مدير', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/Manager"},{text = 'ادمن', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/Admin"},
},
{
{text = 'مالك', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/AbsConstructor"},
},
{
{text = 'مميز', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/vip"},{text = 'مميز عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/VipAll"},
},
{
{text = 'ادمن عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/AdminAll"},{text = 'مدير عام', callback_data='amr@'..msg.sender_user_id_..'/user@'..user.."/ManagerAll"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end

--     Set RioSudo     --
if Sudo(msg) then
if text ==('اضف مطور اساسي') or text ==('رفع مطور اساسي') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(Prox..'Rio:RioSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المطورين الاساسيين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور اساسي @(.*)') or text:match('^رفع مطور اساسي @(.*)')) and ChCheck(msg) then
local username = text:match('^اضف مطور اساسي @(.*)') or text:match('^رفع مطور اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(Prox..'Rio:RioSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المطورين الاساسيين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور اساسي (%d+)') or text:match('^رفع مطور اساسي (%d+)')) and ChCheck(msg) then
local user = text:match('اضف مطور اساسي (%d+)') or text:match('رفع مطور اساسي (%d+)')
DevRio:sadd(Prox..'Rio:RioSudo:',user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المطورين الاساسيين")  
end
--     Source Prox     --
--     Rem SecondSudo     --
if text ==('حذف مطور اساسي') or text ==('تنزيل مطور اساسي') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:RioSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المطورين الاساسيين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور اساسي @(.*)') or text:match('^تنزيل مطور اساسي @(.*)')) and ChCheck(msg) then
local username = text:match('^حذف مطور اساسي @(.*)') or text:match('^تنزيل مطور اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:RioSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المطورين الاساسيين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور اساسي (%d+)') or text:match('^تنزيل مطور اساسي (%d+)')) and ChCheck(msg) then
local user = text:match('حذف مطور اساسي (%d+)') or text:match('تنزيل مطور اساسي (%d+)')
DevRio:srem(Prox..'Rio:RioSudo:',user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المطورين الاساسيين")  
end end
--     Source Prox     --
--     Set SecondSudo     --
if RioSudo(msg) then
if text ==('اضف مطور ثانوي') or text ==('رفع مطور ثانوي') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(Prox..'Rio:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المطورين الثانويين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور ثانوي @(.*)') or text:match('^رفع مطور ثانوي @(.*)')) and ChCheck(msg) then
local username = text:match('^اضف مطور ثانوي @(.*)') or text:match('^رفع مطور ثانوي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(Prox..'Rio:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المطورين الثانويين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور ثانوي (%d+)') or text:match('^رفع مطور ثانوي (%d+)')) and ChCheck(msg) then
local user = text:match('اضف مطور ثانوي (%d+)') or text:match('رفع مطور ثانوي (%d+)')
DevRio:sadd(Prox..'Rio:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المطورين الثانويين")  
end
--     Source Prox     --
--     Rem SecondSudo     --
if text ==('حذف مطور ثانوي') or text ==('تنزيل مطور ثانوي') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:SecondSudo:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المطورين الثانويين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور ثانوي @(.*)') or text:match('^تنزيل مطور ثانوي @(.*)')) and ChCheck(msg) then
local username = text:match('^حذف مطور ثانوي @(.*)') or text:match('^تنزيل مطور ثانوي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:SecondSudo:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المطورين الثانويين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور ثانوي (%d+)') or text:match('^تنزيل مطور ثانوي (%d+)')) and ChCheck(msg) then
local user = text:match('حذف مطور ثانوي (%d+)') or text:match('تنزيل مطور ثانوي (%d+)')
DevRio:srem(Prox..'Rio:SecondSudo:',user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المطورين الثانويين")  
end end
--     Source Prox     --
--       Set SudoBot      --
if SecondSudo(msg) then
if text ==('اضف مطور') or text ==('رفع مطور') and ChCheck(msg) then
function sudo_reply(extra, result, success)
DevRio:sadd(Prox..'Rio:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المطورين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),sudo_reply)
end end 
if text and (text:match('^اضف مطور @(.*)') or text:match('^رفع مطور @(.*)')) and ChCheck(msg) then
local username = text:match('^اضف مطور @(.*)') or text:match('^رفع مطور @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(Prox..'Rio:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المطورين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^اضف مطور (%d+)') or text:match('^رفع مطور (%d+)')) and ChCheck(msg) then
local user = text:match('اضف مطور (%d+)') or text:match('رفع مطور (%d+)')
DevRio:sadd(Prox..'Rio:SudoBot:',user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المطورين")  
end
--     Source Prox     --
--       Rem SudoBot      --
if text ==('حذف مطور') or text ==('تنزيل مطور') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:SudoBot:',result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المطورين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and (text:match('^حذف مطور @(.*)') or text:match('^تنزيل مطور @(.*)')) and ChCheck(msg) then
local username = text:match('^حذف مطور @(.*)') or text:match('^تنزيل مطور @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:SudoBot:',result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المطورين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and (text:match('^حذف مطور (%d+)') or text:match('^تنزيل مطور (%d+)')) and ChCheck(msg) then
local user = text:match('حذف مطور (%d+)') or text:match('تنزيل مطور (%d+)')
DevRio:srem(Prox..'Rio:SudoBot:',user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المطورين")  
end end
--     Source Prox     --
--   Set RioConstructor   --
if ChatType == 'sp' or ChatType == 'gp'  then
if SudoBot(msg) then
if text ==('رفع مالك') and ChCheck(msg) then
function raf_reply(extra, result, success)
DevRio:sadd(Prox..'Rio:RioConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه مالك")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع مالك @(.*)') and ChCheck(msg) then
local username = text:match('^رفع مالك @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:sadd(Prox..'Rio:RioConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه مالك")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع مالك (%d+)') and ChCheck(msg) then
local user = text:match('رفع مالك (%d+)')
DevRio:sadd(Prox..'Rio:RioConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه مالك")  
end
--     Source Prox     --
--   Rem RioConstructor   --
if text ==('تنزيل مالك') and ChCheck(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.sender_user_id_) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevRio:srem(Prox..'Rio:RioConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من المالكين")  
end end end
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
if text and text:match('^تنزيل مالك @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل مالك @(.*)')
function promreply(extra,result,success)
if result.id_ then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(result.id_) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevRio:srem(Prox..'Rio:RioConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من المالكين")  
end end end
end,nil)
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مالك (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل مالك (%d+)')
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
if tonumber(user) == tonumber(admins[i].user_id_) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا يمكن تنزيل المالك الاساسي', 1, 'md')
else
DevRio:srem(Prox..'Rio:RioConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من المالكين")  
end end end
end,nil)
end end
--     Source Prox     --
--  Set BasicConstructor  --
if RioConstructor(msg) then
if text ==('رفع منشئ اساسي') and ChCheck(msg) then
function raf_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه منشئ اساسي")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع منشئ اساسي @(.*)') and ChCheck(msg) then
local username = text:match('^رفع منشئ اساسي @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه منشئ اساسي")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منشئ اساسي (%d+)') and ChCheck(msg) then
local user = text:match('رفع منشئ اساسي (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:BasicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه منشئ اساسي")  
end
--     Source Prox     --
--  Rem BasicConstructor  --
if text ==('تنزيل منشئ اساسي') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله منشئ اساسي")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منشئ اساسي @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل منشئ اساسي @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله منشئ اساسي")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منشئ اساسي (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل منشئ اساسي (%d+)')
DevRio:srem(Prox..'Rio:BasicConstructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله منشئ اساسي")  
end end
if text ==('رفع منشئ اساسي') and not RioConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر للمالكين والمطورين فقط', 1, 'md')
end
--     Source Prox     --
--    Set  Constructor    --
if BasicConstructor(msg) then
if text ==('رفع منشئ') and ChCheck(msg) then
function raf_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المنشئين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),raf_reply)
end end
if text and text:match('^رفع منشئ @(.*)') and ChCheck(msg) then
local username = text:match('^رفع منشئ @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المنشئين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منشئ (%d+)') and ChCheck(msg) then
local user = text:match('رفع منشئ (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المنشئين")  
end
--     Source Prox     --
--    Rem  Constructor    --
if text ==('تنزيل منشئ') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المنشئين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منشئ @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل منشئ @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المنشئين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منشئ (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل منشئ (%d+)')
DevRio:srem(Prox..'Rio:Constructor:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المنشئين")  
end 
end
--     Source Prox     --
--      Set Manager       --
if Constructor(msg) then
if text ==('رفع مدير') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المدراء")  
end  
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع مدير @(.*)') and ChCheck(msg) then
local username = text:match('^رفع مدير @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المدراء")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end 
if text and text:match('^رفع مدير (%d+)') and ChCheck(msg) then
local user = text:match('رفع مدير (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المدراء")  
end
--     Source Prox     --
--       Rem Manager      --
if text ==('تنزيل مدير') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المدراء")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل مدير @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل مدير @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المدراء")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مدير (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل مدير (%d+)')
DevRio:srem(Prox..'Rio:Managers:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المدراء")  
end 
--     Source Prox     --
--       Set Cleaner      --
if text ==('رفع منظف') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المنظفين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع منظف @(.*)') and ChCheck(msg) then
local username = text:match('^رفع منظف @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المنظفين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع منظف (%d+)') and ChCheck(msg) then
local user = text:match('رفع منظف (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المنظفين")  
end
--     Source Prox     --
--       Rem Cleaner      --
if text ==('تنزيل منظف') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المنظفين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل منظف @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل منظف @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المنظفين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل منظف (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل منظف (%d+)')
DevRio:srem(Prox..'Rio:Cleaner:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المنظفين")  
end end
--     Source Prox     --
--       Set admin        --
if Manager(msg) then
if text ==('رفع ادمن') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة الادمنيه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع ادمن @(.*)') and ChCheck(msg) then
local username = text:match('^رفع ادمن @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة الادمنيه")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع ادمن (%d+)') and ChCheck(msg) then
local user = text:match('رفع ادمن (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة الادمنيه")  
end
--     Source Prox     --
--        Rem admin       --
if text ==('تنزيل ادمن') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة الادمنيه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل ادمن @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل ادمن @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة الادمنيه")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل ادمن (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل ادمن (%d+)')
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة الادمنيه")  
end end
--     Source Prox     --
--       Set Vipmem       --
if Admin(msg) then
if text ==('رفع مميز') and ChCheck(msg) then
function prom_reply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المميزين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^رفع مميز @(.*)') and ChCheck(msg) then
local username = text:match('^رفع مميز @(.*)')
function promreply(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
if result.id_ then
DevRio:sadd(Prox..'Rio:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفعه في قائمة المميزين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^رفع مميز (%d+)') and ChCheck(msg) then
local user = text:match('رفع مميز (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:ProSet"..msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لاتستطيع رفع احد وذالك بسبب تعطيل الرفع', 1, 'md')
return false
end
DevRio:sadd(Prox..'Rio:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم رفعه في قائمة المميزين")  
end
--     Source Prox     --
--       Rem Vipmem       --
if text ==('تنزيل مميز') and ChCheck(msg) then
function prom_reply(extra, result, success)
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_,result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المميزين")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end end
if text and text:match('^تنزيل مميز @(.*)') and ChCheck(msg) then
local username = text:match('^تنزيل مميز @(.*)')
function promreply(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_,result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تنزيله من قائمة المميزين")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,promreply)
end
if text and text:match('^تنزيل مميز (%d+)') and ChCheck(msg) then
local user = text:match('تنزيل مميز (%d+)')
DevRio:srem(Prox..'Rio:VipMem:'..msg.chat_id_,user)
ReplyStatus(msg,user,"Reply","⌔  تم تنزيله من قائمة المميزين")  
end end 
--       Set Inline       --
if text ==('رفع رتبه') and ChCheck(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
if dp.first_name_ == false then
Dev_Abs(msg.chat_id_, msg.id_, 1, "⌁︙الحساب محذوف", 1, "md")
return false  
end
local Text = '⌁︙قم باستعمال الازرار لرفع العضو ↫ ⤈\n⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'F_L_3')..')'
if Sudo(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منشئ",callback_data=msg.sender_user_id_..":SetConstructor:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_},{text="رفع منشئ اساسي",callback_data=msg.sender_user_id_..":SetBasicConstructor:"..result.sender_user_id_}},{{text="رفع مالك",callback_data=msg.sender_user_id_..":SetAbsConstructor:"..result.sender_user_id_},{text="رفع مطور",callback_data=msg.sender_user_id_..":SetSudoBot:"..result.sender_user_id_}},{{text="رفع مطور ثانوي",callback_data=msg.sender_user_id_..":SetSecondSudo:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif SecondSudo(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منشئ",callback_data=msg.sender_user_id_..":SetConstructor:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_},{text="رفع منشئ اساسي",callback_data=msg.sender_user_id_..":SetBasicConstructor:"..result.sender_user_id_}},{{text="رفع مالك",callback_data=msg.sender_user_id_..":SetAbsConstructor:"..result.sender_user_id_},{text="رفع مطور",callback_data=msg.sender_user_id_..":SetSudoBot:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif SudoBot(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منشئ",callback_data=msg.sender_user_id_..":SetConstructor:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_},{text="رفع منشئ اساسي",callback_data=msg.sender_user_id_..":SetBasicConstructor:"..result.sender_user_id_}},{{text="رفع مالك",callback_data=msg.sender_user_id_..":SetAbsConstructor:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif AbsConstructor(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منشئ",callback_data=msg.sender_user_id_..":SetConstructor:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_},{text="رفع منشئ اساسي",callback_data=msg.sender_user_id_..":SetBasicConstructor:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif BasicConstructor(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منشئ",callback_data=msg.sender_user_id_..":SetConstructor:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Constructor(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text="رفع منظف",callback_data=msg.sender_user_id_..":SetCleaner:"..result.sender_user_id_},{text="رفع مدير",callback_data=msg.sender_user_id_..":SetManager:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Manager(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_},{text="رفع ادمن",callback_data=msg.sender_user_id_..":SetAdmin:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Admin(msg) then
inline = {{{text="رفع مميز",callback_data=msg.sender_user_id_..":SetMem:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
end
SendInline(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5)
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
--     Source Lions     --
--       Rem Inline       --
if text ==('تنزيل رتبه') and ChCheck(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
if dp.first_name_ == false then
Dev_Abs(msg.chat_id_, msg.id_, 1, "⌁︙الحساب محذوف", 1, "md")
return false  
end
local Text = '⌁︙قم باستعمال الازرار لتنزيل العضو ↫ ⤈\n⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'F_L_3')..')'
if Sudo(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منشئ",callback_data=msg.sender_user_id_..":RemConstructor:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_},{text="تنزيل منشئ اساسي",callback_data=msg.sender_user_id_..":RemBasicConstructor:"..result.sender_user_id_}},{{text="تنزيل مالك",callback_data=msg.sender_user_id_..":RemAbsConstructor:"..result.sender_user_id_},{text="تنزيل مطور",callback_data=msg.sender_user_id_..":RemSudoBot:"..result.sender_user_id_}},{{text="تنزيل مطور ثانوي",callback_data=msg.sender_user_id_..":RemSecondSudo:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif SecondSudo(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منشئ",callback_data=msg.sender_user_id_..":RemConstructor:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_},{text="تنزيل منشئ اساسي",callback_data=msg.sender_user_id_..":RemBasicConstructor:"..result.sender_user_id_}},{{text="تنزيل مالك",callback_data=msg.sender_user_id_..":RemAbsConstructor:"..result.sender_user_id_},{text="تنزيل مطور",callback_data=msg.sender_user_id_..":RemSudoBot:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif SudoBot(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منشئ",callback_data=msg.sender_user_id_..":RemConstructor:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_},{text="تنزيل منشئ اساسي",callback_data=msg.sender_user_id_..":RemBasicConstructor:"..result.sender_user_id_}},{{text="تنزيل مالك",callback_data=msg.sender_user_id_..":RemAbsConstructor:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif AbsConstructor(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منشئ",callback_data=msg.sender_user_id_..":RemConstructor:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_},{text="تنزيل منشئ اساسي",callback_data=msg.sender_user_id_..":RemBasicConstructor:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif BasicConstructor(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منشئ",callback_data=msg.sender_user_id_..":RemConstructor:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Constructor(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text="تنزيل منظف",callback_data=msg.sender_user_id_..":RemCleaner:"..result.sender_user_id_},{text="تنزيل مدير",callback_data=msg.sender_user_id_..":RemManager:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Manager(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_},{text="تنزيل ادمن",callback_data=msg.sender_user_id_..":RemAdmin:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
elseif Admin(msg) then
inline = {{{text="تنزيل مميز",callback_data=msg.sender_user_id_..":RemMem:"..result.sender_user_id_}},{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}}
end
SendInline(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5)
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
--     Source Lions     --
if text ==('تحكم') and ChCheck(msg) then
function prom_reply(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
if dp.first_name_ == false then
Dev_Abs(msg.chat_id_, msg.id_, 1, "⌁︙الحساب محذوف", 1, "md")
return false  
end
local Text = '⌁︙قم باستعمال الازرار للتحكم العضو ↫ ⤈\n⌁︙العضو ↫ ['..dp.first_name_..'](t.me/'..(dp.username_ or 'F_L_3')..')'
inline = {
{{text="رفع رتبه",callback_data=msg.sender_user_id_..":SetRtba:"..result.sender_user_id_},{text="تنزيل رتبه",callback_data=msg.sender_user_id_..":RemRtba:"..result.sender_user_id_}},
{{text="كتم",callback_data=msg.sender_user_id_..":Mute:"..result.sender_user_id_},{text="الغاء كتم",callback_data=msg.sender_user_id_..":UnMute:"..result.sender_user_id_}},
{{text="حظر",callback_data=msg.sender_user_id_..":Ban:"..result.sender_user_id_},{text="الغاء حظر",callback_data=msg.sender_user_id_..":UnBan:"..result.sender_user_id_}},
{{text="تقيد",callback_data=msg.sender_user_id_..":Tked:"..result.sender_user_id_},{text="الغاء تقيد",callback_data=msg.sender_user_id_..":UnTked:"..result.sender_user_id_}},
{{text = '⌁ ⌯ 𝘁𝗲𝗲𝗺 𝗸𝗲𝗹𝗼𝗮 ⌯ .',url="t.me/F_L_3"}}
}
SendInline(msg.chat_id_,Text,nil,inline,msg.id_/2097152/0.5)
end,nil)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),prom_reply)
end 
end
--     Source Prox     --
if BasicConstructor(msg) then
if text and text:match("^رفع مشرف$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..Prox)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه مشرف في المجموعه")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and text:match("^تنزيل مشرف$") and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..Prox)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من مشرفين المجموعه")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end 
if text and (text:match("^رفع بكل الصلاحيات$") or text:match("^رفع بكل صلاحيات$")) and msg.reply_to_message_id_ then
function promote_by_reply(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..Prox)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه مشرف في جميع الصلاحيات")  
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,promote_by_reply)
end
if text and (text:match("^وضع لقب (.*)$") or text:match("^رفع مشرف (.*)$") or text:match("^ضع لقب (.*)$")) and ChCheck(msg) then
local Rio = text:match("^وضع لقب (.*)$") or text:match("^رفع مشرف (.*)$") or text:match("^ضع لقب (.*)$")
function ReplySet(extra, result, success)
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..Prox)
local GetInfo = JSON.decode(Check)
if GetInfo.result.can_promote_members == true then 
https.request("https://api.telegram.org/bot"..TokenBot.."/promoteChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم اضافة ↫ "..Rio.." كلقب له")  
https.request("https://api.telegram.org/bot"..TokenBot.."/setChatAdministratorCustomTitle?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.."&custom_title="..Rio)
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ليست لدي صلاحية اضافة مشرفين جدد يرجى التحقق من الصلاحيات', 1, 'md')
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplySet)
end
end
end
if text == 'لقبه' and ChCheck(msg) then
function ReplyGet(extra, result, success)
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'⌔  ليس لديه لقب هنا') 
else
send(msg.chat_id_, msg.id_,'⌔  لقبه ↫ '..GetCustomTitle(result.sender_user_id_,msg.chat_id_)) 
end
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ReplyGet)
end
end
if text == 'لقبي' and ChCheck(msg) then
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) == false then
send(msg.chat_id_, msg.id_,'⌔  ليس لديك لقب هنا') 
else
send(msg.chat_id_, msg.id_,'⌔  لقبك ↫ '..GetCustomTitle(msg.sender_user_id_,msg.chat_id_)) 
end
end
if text == "راسلني" and ChCheck(msg) then
ProxTeam = {"ها هلاو","انطق","كول","تفضل","احبك","عمري","لاف"};
send(msg.sender_user_id_, 0,ProxTeam[math.random(#ProxTeam)])
end
--     Source Prox     --
if text == "صلاحيتي" or text == "صلاحياتي" and ChCheck(msg) then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Validity(msg,msg.sender_user_id_)
end end
if text ==('صلاحيته') or text ==('صلاحياته') and ChCheck(msg) then
function ValidityReply(extra, result, success)
Validity(msg,result.sender_user_id_)
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ValidityReply)
end end
if text and (text:match('^صلاحيته @(.*)') or text:match('^صلاحياته @(.*)')) and ChCheck(msg) then
local username = text:match('^صلاحيته @(.*)') or text:match('^صلاحياته @(.*)')
function ValidityUser(extra,result,success)
if result.id_ then
Validity(msg,result.id_) 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,ValidityUser)
end
if text and (text:match('^صلاحيته (%d+)') or text:match('^صلاحياته (%d+)')) and ChCheck(msg) then
local ValidityId = text:match('صلاحيته (%d+)') or text:match('صلاحياته (%d+)')
Validity(msg,ValidityId)  
end
--     Source Prox     --
if Admin(msg) then
if msg.reply_to_message_id_ ~= 0 then
if text and (text:match("^مسح$") or text:match("^حذف$")) and ChCheck(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.reply_to_message_id_})
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end end end
--     Source Prox     --
if RioConstructor(msg) then
if text == "تفعيل الحظر" and ChCheck(msg) or text == "تفعيل الطرد" and ChCheck(msg) then
DevRio:del(Prox.."Rio:Lock:KickBan"..msg.chat_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الطرد والحظر'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
if text == "تعطيل الحظر" and ChCheck(msg) or text == "تعطيل الطرد" and ChCheck(msg) then
DevRio:set(Prox.."Rio:Lock:KickBan"..msg.chat_id_,"true")
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الطرد والحظر'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
if text == "تفعيل الكتم" and ChCheck(msg) or text == "تفعيل التقييد" and ChCheck(msg) then
DevRio:del(Prox.."Rio:Lock:MuteTked"..msg.chat_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الكتم والتقيد'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
if text == "تعطيل الكتم" and ChCheck(msg) or text == "تعطيل التقييد" and ChCheck(msg) then
DevRio:set(Prox.."Rio:Lock:MuteTked"..msg.chat_id_,"true")
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الكتم والتقيد'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
end
if RioConstructor(msg) then
if text == "تفعيل الرفع" and ChCheck(msg) or text == "تفعيل الترقيه" and ChCheck(msg) then
DevRio:del(Prox.."Rio:Lock:ProSet"..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تفعيل رفع ↫ المنشئ الاساسي • المنشئ • المدير • الادمن • المميز', 1, 'md')
end
if text == "تعطيل الرفع" and ChCheck(msg) or text == "تعطيل الترقيه" and ChCheck(msg) then
DevRio:set(Prox.."Rio:Lock:ProSet"..msg.chat_id_,"true")
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تعطيل رفع ↫ المنشئ الاساسي • المنشئ • المدير • الادمن • المميز', 1, 'md')
end
end
--     Source Prox     --
--          Kick          --
if Admin(msg) then
if text ==('طرد') and ChCheck(msg) then
function KickReply(extra, result, success)
if not Constructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر من قبل المنشئين')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع طرد ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم طرده من المجموعه")  
end,nil)
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),KickReply)
end end
if text and text:match('^طرد @(.*)') and ChCheck(msg) then
local username = text:match('^طرد @(.*)')
function KickUser(extra,result,success)
if not Constructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر من قبل المنشئين')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع طرد ↫ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم طرده من المجموعه")  
end,nil)
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,KickUser)
end
if text and text:match('^طرد (%d+)') and ChCheck(msg) then
local user = text:match('طرد (%d+)')
if not Constructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر من قبل المنشئين')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع طرد ↫ '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع طرد مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم طرده من المجموعه")  
end,nil)
end
end
end 
--     Source Prox     --
--          Ban           --
if Admin(msg) then
if text ==('حضر') or text ==('حظر') and ChCheck(msg) then
function BanReply(extra, result, success)
if not Constructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر من قبل المنشئين')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع حظر ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevRio:sadd(Prox..'Rio:Ban:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم حظره من المجموعه") 
end,nil) 
end 
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanReply)
end end
if text and (text:match('^حضر @(.*)') or text:match('^حظر @(.*)')) and ChCheck(msg) then
local username = text:match('^حضر @(.*)') or text:match('^حظر @(.*)')
function BanUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع حظر ↫ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=result.id_,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, result.id_)
DevRio:sadd(Prox..'Rio:Ban:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم حظره من المجموعه")  
end,nil) 
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,BanUser)
end
if text and (text:match('^حضر (%d+)') or text:match('^حظر (%d+)')) and ChCheck(msg) then
local user = text:match('حضر (%d+)') or text:match('حظر (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:KickBan"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الطرد والحظر')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع حظر ↫ '..IdRank(user, msg.chat_id_), 1, 'md')
else
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=user,status_={ID="ChatMemberStatusKicked"},},function(arg,dp) 
if (dp and dp.code_ and dp.code_ == 400 and dp.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_,msg.id_,"⌔  ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !") 
return false  
end
if dp and dp.code_ and dp.code_ == 400 and dp.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_,msg.id_,"⌔  لا استطيع حظر مشرفين المجموعه") 
return false  
end
ChatKick(msg.chat_id_, user)
DevRio:sadd(Prox..'Rio:Ban:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم حظره من المجموعه")  
end,nil) 
end
end
--     Source Prox     --
--         UnBan          --
if text ==('الغاء الحظر') or text ==('الغاء حظر') and ChCheck(msg) then
function UnBanReply(extra, result, success)
DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم الغاء حظره من المجموعه")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnBanReply)
end end
if text and (text:match('^الغاء الحظر @(.*)') or text:match('^الغاء حظر @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء الحظر @(.*)') or text:match('^الغاء حظر @(.*)')
function UnBanUser(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,result.id_,"Reply","⌔  تم الغاء حظره من المجموعه")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnBanUser)
end
if text and (text:match('^الغاء الحظر (%d+)') or text:match('^الغاء حظر (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء الحظر (%d+)') or text:match('الغاء حظر (%d+)')
DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_, user)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = user, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
ReplyStatus(msg,user,"Reply","⌔  تم الغاء حظره من المجموعه")  
end 
end 
--     Source Prox     --
--          Mute          --
if Admin(msg) then
if text ==('كتم') and ChCheck(msg) then
function MuteReply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع كتم ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  هو بالفعل مكتوم من المجموعه")  
else
DevRio:sadd(Prox..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم كتمه من المجموعه")  
end 
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteReply)
end end
if text and text:match('^كتم @(.*)') and ChCheck(msg) then
local username = text:match('^كتم @(.*)')
function MuteUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع كتم ↫ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","⌔  هو بالفعل مكتوم من المجموعه")  
else
DevRio:sadd(Prox..'Rio:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم كتمه من المجموعه")  
end
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,MuteUser)
end
if text and text:match('^كتم (%d+)') and ChCheck(msg) then
local user = text:match('كتم (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع كتم ↫ '..IdRank(user, msg.chat_id_), 1, 'md')
else
if DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","⌔  هو بالفعل مكتوم من المجموعه")  
else
DevRio:sadd(Prox..'Rio:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم كتمه من المجموعه")  
end
end
end
--     Source Prox     --
--         UnMute         --
if text ==('الغاء الكتم') or text ==('الغاء كتم') and ChCheck(msg) then
function UnMuteReply(extra, result, success)
if not DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  هو ليس مكتوم لالغاء كتمه")  
else
DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم الغاء كتمه من المجموعه")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnMuteReply)
end end
if text and (text:match('^الغاء الكتم @(.*)') or text:match('^الغاء كتم @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء الكتم @(.*)') or text:match('^الغاء كتم @(.*)')
function UnMuteUser(extra,result,success)
if result.id_ then
if not DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, result.id_) then
ReplyStatus(msg,result.id_,"Reply","⌔  هو ليس مكتوم لالغاء كتمه")  
else
DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم الغاء كتمه من المجموعه")  
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnMuteUser)
end
if text and (text:match('^الغاء الكتم (%d+)') or text:match('^الغاء كتم (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء الكتم (%d+)') or text:match('الغاء كتم (%d+)')
if not DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_, user) then
ReplyStatus(msg,user,"Reply","⌔  هو ليس مكتوم لالغاء كتمه")  
else
DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم الغاء كتمه من المجموعه")  
end
end 
end 
--     Source Prox     --
--          Tkeed           --
if Admin(msg) then
if text ==('تقييد') or text ==('تقيد') and ChCheck(msg) then
function TkeedReply(extra, result, success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(result.sender_user_id_, result.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تقيده من المجموعه")  
end
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),TkeedReply)
end end
if text and (text:match('^تقييد @(.*)') or text:match('^تقيد @(.*)')) and ChCheck(msg) then
local username = text:match('^تقييد @(.*)') or text:match('^تقيد @(.*)')
function TkeedUser(extra,result,success)
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if result.id_ then
if RankChecking(result.id_, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(result.id_, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم تقيده من المجموعه")  
end
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,TkeedUser)
end
if text and (text:match('^تقييد (%d+)') or text:match('^تقيد (%d+)')) and ChCheck(msg) then
local user = text:match('تقييد (%d+)') or text:match('تقيد (%d+)')
if not RioConstructor(msg) and DevRio:get(Prox.."Rio:Lock:MuteTked"..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'⌔  لقد تم تعطيل الكتم والتقيد')
return false
end
if RankChecking(user, msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(user, msg.chat_id_), 1, 'md')
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user)
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم تقيده من المجموعه")  
end
end
--     Source Prox     --
--         UnTkeed          --
if text ==('الغاء تقييد') or text ==('الغاء تقيد') and ChCheck(msg) then
function UnTkeedReply(extra, result, success)
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم الغاء تقيده من المجموعه")  
end
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnTkeedReply)
end end
if text and (text:match('^الغاء تقييد @(.*)') or text:match('^الغاء تقيد @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء تقييد @(.*)') or text:match('^الغاء تقيد @(.*)')
function UnTkeedUser(extra,result,success)
if result.id_ then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_, result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم الغاء تقيده من المجموعه")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnTkeedUser)
end
if text and (text:match('^الغاء تقييد (%d+)') or text:match('^الغاء تقيد (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء تقييد (%d+)') or text:match('الغاء تقيد (%d+)')
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..user.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_, user)
ReplyStatus(msg,user,"Reply","⌔  تم الغاء تقيده من المجموعه")  
end
end 
end
--     Source Prox     --
--         BanAll         --
if SecondSudo(msg) then
if text ==('حضر عام') or text ==('حظر عام') and ChCheck(msg) then
function BanAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.sender_user_id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الثانوي*", 1, 'md')
return false 
end
ChatKick(result.chat_id_, result.sender_user_id_)
DevRio:sadd(Prox..'Rio:BanAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم حظره عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),BanAllReply)
end end
if text and (text:match('^حضر عام @(.*)') or text:match('^حظر عام @(.*)')) and ChCheck(msg) then
local username = text:match('^حضر عام @(.*)') or text:match('^حظر عام @(.*)')
function BanAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الثانوي*", 1, 'md')
return false 
end
if result.id_ then
ChatKick(msg.chat_id_, result.id_)
DevRio:sadd(Prox..'Rio:BanAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم حظره عام من المجموعات")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,BanAllUser)
end
if text and (text:match('^حضر عام (%d+)') or text:match('^حظر عام (%d+)')) and ChCheck(msg) then
local user = text:match('حضر عام (%d+)') or text:match('حظر عام (%d+)')
if tonumber(user) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر البوت عام*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',user) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',user) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع حظر المطور الثانوي*", 1, 'md')
return false 
end
ChatKick(msg.chat_id_, user)
DevRio:sadd(Prox..'Rio:BanAll:', user)
ReplyStatus(msg,user,"Reply","⌔  تم حظره عام من المجموعات")  
end
--     Source Prox     --
--         MuteAll        --
if text ==('كتم عام') and ChCheck(msg) then
function MuteAllReply(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(result.sender_user_id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.sender_user_id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.sender_user_id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الثانوي*", 1, 'md')
return false 
end
DevRio:sadd(Prox..'Rio:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم كتمه عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) == 0 then
else
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),MuteAllReply)
end end
if text and text:match('^كتم عام @(.*)') and ChCheck(msg) then
local username = text:match('^كتم عام @(.*)')
function MuteAllUser(extra,result,success)
if tonumber(result.id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(result.id_) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',result.id_) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',result.id_) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الثانوي*", 1, 'md')
return false 
end
if result.id_ then
DevRio:sadd(Prox..'Rio:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم كتمه عام من المجموعات")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,MuteAllUser)
end
if text and text:match('^كتم عام (%d+)') and ChCheck(msg) then
local user = text:match('كتم عام (%d+)')
if tonumber(user) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم البوت عام*", 1, 'md')
return false 
end
if SudoId(tonumber(user)) == true then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:RioSudo:',user) and not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الاساسي*", 1, 'md')
return false 
end
if DevRio:sismember(Prox..'Rio:SecondSudo:',user) and not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتستطيع كتم المطور الثانوي*", 1, 'md')
return false 
end
DevRio:sadd(Prox..'Rio:MuteAll:', user)
ReplyStatus(msg,user,"Reply","⌔  تم كتمه عام من المجموعات")  
end
--     Source Prox     --
--         UnAll          --
if text ==('الغاء عام') or text ==('الغاء العام') and ChCheck(msg) then
function UnAllReply(extra, result, success)
DevRio:srem(Prox..'Rio:BanAll:', result.sender_user_id_)
DevRio:srem(Prox..'Rio:MuteAll:', result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم الغاء (الحظر • الكتم) عام من المجموعات")  
end 
if tonumber(tonumber(msg.reply_to_message_id_)) > 0 then
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),UnAllReply)
end end
if text and (text:match('^الغاء عام @(.*)') or text:match('^الغاء العام @(.*)')) and ChCheck(msg) then
local username = text:match('^الغاء عام @(.*)') or text:match('^الغاء العام @(.*)')
function UnAllUser(extra,result,success)
if result.id_ then
DevRio:srem(Prox..'Rio:BanAll:', result.id_)
DevRio:srem(Prox..'Rio:MuteAll:', result.id_)
ReplyStatus(msg,result.id_,"Reply","⌔  تم الغاء (الحظر • الكتم) عام من المجموعات")  
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')
end end 
resolve_username(username,UnAllUser)
end
if text and (text:match('^الغاء عام (%d+)') or text:match('^الغاء العام (%d+)')) and ChCheck(msg) then
local user = text:match('الغاء عام (%d+)') or text:match('الغاء العام (%d+)')
DevRio:srem(Prox..'Rio:BanAll:', user)
DevRio:srem(Prox..'Rio:MuteAll:', user)
ReplyStatus(msg,user,"Reply","⌔  تم الغاء (الحظر • الكتم) عام من المجموعات")  
end
end
end
--     Source Prox     --
if (text == "تغير المطور الاساسي" or text == "نقل ملكيه البوت" or text == "تغيير المطور الاساسي" or text == "↫ تغير المطور الاساسي ⌔") and msg.reply_to_message_id_ == 0 and Sudo(msg) and ChCheck(msg) then 
send(msg.chat_id_, msg.id_,'⌔  يجب التاكد ان المطور الجديد ارسل start لخاص البوت بعد ذلك يمكنك ارسال ايدي المطور')
DevRio:setex(Prox.."Rio:EditDev"..msg.sender_user_id_,300,true)
end
if DevRio:get(Prox.."Rio:EditDev"..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,'⌔  تم الغاء امر تغير المطور الاساسي')
DevRio:del(Prox.."Rio:EditDev"..msg.sender_user_id_)
return false
end
if text and text:match("^(%d+)$") then 
tdcli_function ({ID = "GetUser",user_id_ = text},function(arg,dp) 
if dp.first_name_ ~= false then
DevRio:del(Prox.."Rio:EditDev"..msg.sender_user_id_)
DevRio:set(Prox.."Rio:NewDev"..msg.sender_user_id_,dp.id_)
if dp.username_ ~= false then DevUser = '\n⌔  المعرف ↫ [@'..dp.username_..']' else DevUser = '' end
local Text = '⌔  الايدي ↫ '..dp.id_..DevUser..'\n⌔  الاسم ↫ ['..dp.first_name_..'](tg://user?id='..dp.id_..')\n⌔  تم حفظ المعلومات بنجاح\n⌔  استخدم الازرار للتاكيد ↫ ⤈'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/setyes"},{text="لا",callback_data="/setno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"⌔  المعلومات خاطئه قم بالتاكد واعد المحاوله")
DevRio:del(Prox.."Rio:EditDev"..msg.sender_user_id_)
end
end,nil)
return false
end
end
--     Source Prox     --
if msg.reply_to_message_id_ ~= 0 then
if text and text:match("^رفع مطي$") and not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) and ChCheck(msg) then
function donky_by_reply(extra, result, success)
if DevRio:sismember(Prox..'User:Donky:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  هو مطي شرفع منه بعد😹💔") 
else
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفعه في قائمة المطايه") 
DevRio:sadd(Prox..'User:Donky:'..msg.chat_id_, result.sender_user_id_)
end end
getMessage(msg.chat_id_, msg.reply_to_message_id_,donky_by_reply)
end end
--     Source Prox     --
if msg.reply_to_message_id_ ~= 0  then
if text and text:match("^تنزيل مطي$") and not DevRio:get(Prox..'Rio:Lock:Stupid'..msg.chat_id_) and ChCheck(msg) then
function donky_by_reply(extra, result, success)
if not DevRio:sismember(Prox..'User:Donky:'..msg.chat_id_, result.sender_user_id_) then
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  هو ليس مطي ليتم تنزيله") 
else
DevRio:srem(Prox..'User:Donky:'..msg.chat_id_, result.sender_user_id_)
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تنزيله من قائمة المطايه") 
end end
getMessage(msg.chat_id_, msg.reply_to_message_id_,donky_by_reply)
end end
--     Source Prox     --
if Admin(msg) then
if text and (text:match('^تقييد دقيقه (%d+)$') or text:match('^كتم دقيقه (%d+)$') or text:match('^تقيد دقيقه (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد دقيقه (%d+)$') or text:match('^كتم دقيقه (%d+)$') or text:match('^تقيد دقيقه (%d+)$')
local Minutes = string.gsub(mutept, 'm', '')
local num1 = tonumber(Minutes) * 60 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تقيده لمدة ↫ "..mutept.." د") 
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end 
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end
if text and (text:match('^تقييد ساعه (%d+)$') or text:match('^كتم ساعه (%d+)$') or text:match('^تقيد ساعه (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد ساعه (%d+)$') or text:match('^كتم ساعه (%d+)$') or text:match('^تقيد ساعه (%d+)$')
local hour = string.gsub(mutept, 'h', '')
local num1 = tonumber(hour) * 3600 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تقيده لمدة ↫ "..mutept.." س") 
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
if text and (text:match('^تقييد يوم (%d+)$') or text:match('^كتم يوم (%d+)$') or text:match('^تقيد يوم (%d+)$')) and ChCheck(msg) then 
local function mut_time(extra, result,success)
local mutept = text:match('^تقييد يوم (%d+)$') or text:match('^كتم يوم (%d+)$') or text:match('^تقيد يوم (%d+)$')
local day = string.gsub(mutept, 'd', '')
local num1 = tonumber(day) * 86400 
if RankChecking(result.sender_user_id_, msg.chat_id_) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا تستطيع تقيد ↫ '..IdRank(result.sender_user_id_, msg.chat_id_), 1, 'md') 
else 
https.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+num1))
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم تقيده لمدة ↫ "..mutept.." ي") 
DevRio:sadd(Prox..'Rio:Tkeed:'..msg.chat_id_, result.sender_user_id_)
end end
if tonumber(msg.reply_to_message_id_) == 0 then else
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, mut_time,nil) end 
end 
end 
--     Source Prox     --
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^اضف رسائل (%d+)$")
DevRio:set('ProxTeam:'..Prox..'id:user'..msg.chat_id_,TXT)  
DevRio:setex('ProxTeam:'..Prox.."numadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل عدد الرسائل الان \n⌔  ارسل الغاء لالغاء الامر ", 1, "md")
Dev_Rio(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر للمنشئين فقط', 1, 'md') 
end 
end 
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function Reply(extra, result, success)
DevRio:del(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_) 
DevRio:incrby(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..result.sender_user_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اضافة "..Num..' رساله', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and ChCheck(msg) then  
if Constructor(msg) then
TXT = text:match("^اضف نقاط (%d+)$")
DevRio:set('ProxTeam:'..Prox..'ids:user'..msg.chat_id_,TXT)  
DevRio:setex('ProxTeam:'..Prox.."nmadd:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل عدد النقاط الان \n⌔  ارسل الغاء لالغاء الامر ", 1, "md")
Dev_Rio(msg.chat_id_, msg.id_, 1,numd, 1, 'md') 
else 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر للمنشئين فقط', 1, 'md') 
end 
end 
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function Reply(extra, result, success)
DevRio:incrby(Prox..'Rio:GamesNumber'..msg.chat_id_..result.sender_user_id_,Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اضافة "..Num..' نقطه', 1, 'md') 
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},Reply, nil)
return false
end
if DevRio:get(Prox..'Rio:Lock:Clean'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevRio:sadd(Prox.."Rio:cleaner"..msg.chat_id_, msg.id_) else DevRio:sadd(Prox.."Rio:cleaner"..msg.chat_id_, msg.id_) end end end
if DevRio:get(Prox..'Rio:Lock:CleanNum'..msg.chat_id_) then if msg.content_.video_ or msg.content_.document_ or msg.content_.sticker_ or msg.content_.photo_ or msg.content_.animation_ or msg.content_.animated_ then if msg.reply_to_message_id_ ~= 0 then DevRio:sadd(Prox.."Rio:cleanernum"..msg.chat_id_, msg.id_) else DevRio:sadd(Prox.."Rio:cleanernum"..msg.chat_id_, msg.id_) end end end
if Manager(msg) and msg.reply_to_message_id_ ~= 0 then
if text and text:match("^تثبيت$") and ChCheck(msg) then 
if DevRio:sismember(Prox.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "⌔  التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100",""),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
DevRio:set(Prox..'Rio:PinnedMsg'..msg.chat_id_,msg.reply_to_message_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تثبيت الرساله بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false  
end
if data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  البوت ليس ادمن هنا !', 1, 'md')
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات', 1, 'md')
return false  
end
end,nil)
end 
end
--     Source Prox     --
if Admin(msg) then
if text == "المميزين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:VipMem:'..msg.chat_id_)
text = "⌔  قائمة المميزين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد مميزين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Prox     --
if Manager(msg) then
if text == "الادمنيه" and ChCheck(msg) or text == "الادمنية" and ChCheck(msg) then 
local rio =  'Rio:Admins:'..msg.chat_id_
local List = DevRio:smembers(Prox..rio)
text = "⌔  قائمة الادمنيه ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⌔  *لا يوجد ادمنيه*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end
--     Source Prox     -- 
if Constructor(msg) then
if text == "المدراء" and ChCheck(msg) or text == "مدراء" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Managers:'..msg.chat_id_)
text = "⌔  قائمة المدراء ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد مدراء*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "المنظفين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Cleaner:'..msg.chat_id_)
text = "⌔  قائمة المنظفين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد منظفين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Prox     --
if BasicConstructor(msg) then
if text == "المنشئين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Constructor:'..msg.chat_id_)
text = "⌔  قائمة المنشئين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد منشئين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end end 
--     Source Prox     --
if RioConstructor(msg) then
if text == "المالكين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:RioConstructor:'..msg.chat_id_)
text = "⌔  قائمة المالكين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد مالكين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "المنشئين الاساسيين" and ChCheck(msg) or text == "منشئين اساسيين" and ChCheck(msg) or text == "المنشئين الاساسين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:BasicConstructor:'..msg.chat_id_)
text = "⌔  قائمة المنشئين الاساسيين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد منشئين اساسيين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
end 
if text ==("المنشئ") and ChCheck(msg) or text ==("المالك") and ChCheck(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌁︙حساب المنشئ محذوف", 1, "md")
return false  
end
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = dp.id_,offset_ = 0,limit_ = 1},function(extra,abbas,success) 
if abbas.photos_[0] then
keyboard = {} 
keyboard.inline_keyboard = {{{text=dp.first_name_,url=("t.me/"..dp.username_ or "t.me/ZzZlZzZ")}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id='..msg.chat_id_..'&photo='..abbas.photos_[0].sizes_[1].photo_.persistent_id_..'&caption=' .. URL.escape("⌁︙مالك المجموعه ↫ ⤈").."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
SendText(msg.chat_id_,"⌁︙مالك المجموعه ↫ ["..dp.first_name_.."](tg://user?id="..dp.id_..")",msg.id_/2097152/0.5,'md')
end
end,nil)  
end,nil)   
end
end
end,nil)   
end
--     Source Prox     --
if Admin(msg) then
if text == "المكتومين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Muted:'..msg.chat_id_)
text = "⌔  قائمة المكتومين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد مكتومين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Prox     --
if text == "المقيدين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Tkeed:'..msg.chat_id_)
text = "⌔  قائمة المقيدين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⌔  *لا يوجد مقيدين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Prox     --
if text == "المحظورين" and ChCheck(msg) or text == "المحضورين" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:Ban:'..msg.chat_id_)
text = "⌔  قائمة المحظورين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then 
text = "⌔  *لا يوجد محظورين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
if text == "قائمه المنع" and ChCheck(msg) then
local List = DevRio:hkeys(Prox..'Rio:Filters:'..msg.chat_id_)
text = "⌔  قائمة المنع ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k, v in pairs(List) do
text = text..k..'~ 〈 '..v..' 〉\n'
end
if #List == 0 then
text = "⌔  لا توجد كلمات ممنوعه"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, 'md')
end
end 
--     Source Prox     --
if text == "المطايه" and ChCheck(msg) or text == "المطاية" and ChCheck(msg) then
local List = DevRio:smembers(Prox..'User:Donky:'..msg.chat_id_)
text = "⌔  قائمة مطاية المجموعه ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⌔  *لا يوجد مطايه كلها اوادم*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
--     Source Prox     --
if text == "المطورين الاساسيين" and ChCheck(msg) and RioSudo(msg) or text == "الاساسيين" and RioSudo(msg) and ChCheck(msg) or text == "↫ الاساسيين ⌔" and RioSudo(msg) and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:RioSudo:')
text = "⌔  قائمة المطورين الاساسيين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..""..k.."~ : [@"..username.."]\n"
else
text = text..""..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⌔  *عذرا لم يتم رفع اي مطورين اساسيين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Prox     --
if text == "المطورين الثانويين" and SecondSudo(msg) and ChCheck(msg) or text == "الثانويين" and SecondSudo(msg) and ChCheck(msg) or text == "↫ الثانويين ⌔" and SecondSudo(msg) and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:SecondSudo:')
text = "⌔  قائمة المطورين الثانويين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
if #List == 0 then
text = "⌔  *عذرا لم يتم رفع اي مطورين ثانويين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Prox     --
if SudoBot(msg) then
if text == "قائمه العام" and ChCheck(msg) or text == "المحظورين عام" and ChCheck(msg) or text == "المكتومين عام" and ChCheck(msg) or text == "↫ قائمه العام ⌔" and ChCheck(msg) or text == "↫ قائمه العام ⌔" and ChCheck(msg) then 
local BanAll = DevRio:smembers(Prox..'Rio:BanAll:')
local MuteAll = DevRio:smembers(Prox..'Rio:MuteAll:')
if #BanAll ~= 0 then 
text = "⌔  قائمة المحظورين عام ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(BanAll) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = ""
end
if #MuteAll ~= 0 then 
text = text.."⌔  قائمة المكتومين عام ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(MuteAll) do
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."]\n"
else
text = text..k.."~ : `"..v.."`\n"
end end
else
text = text
end
if #BanAll ~= 0 or #MuteAll ~= 0 then 
text = text
else
text = "⌔  *لم يتم حظر او كتم اي عضو*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end 
--     Source Prox     --
if text == "المطورين" and ChCheck(msg) or text == "↫ المطورين ⌔" and ChCheck(msg) then 
local List = DevRio:smembers(Prox..'Rio:SudoBot:')
text = "⌔  قائمة المطورين ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local sudouser = DevRio:get(Prox..'Rio:Sudos'..v) 
local username = DevRio:get(Prox..'Save:UserName'..v)
if username then
text = text..k.."~ : [@"..username.."] ↬ Gps : "..(sudouser or 0).."\n"
else
text = text..k.."~ : `"..v.."` ↬ Gps : "..(sudouser or 0).."\n"
end end
if #List == 0 then
text = "⌔  *عذرا لم يتم رفع اي مطورين*"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, text, 1, "md")
end
--     Source Prox     --
if text ==("رفع المنشئ") and ChCheck(msg) or text ==("رفع المالك") and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
end
end
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حساب المنشئ محذوف", 1, "md")
return false  
end
local UserName = (dp.username_ or "F_L_3")
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم رفع مالك المجموعه ↫ ["..dp.first_name_.."](T.me/"..UserName..")", 1, "md") 
DevRio:sadd(Prox.."Rio:RioConstructor:"..msg.chat_id_,dp.id_)
end,nil)   
end,nil)   
end
end 
--     Source Prox     --
if Manager(msg) then
if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then 
function filter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevRio:sadd(Prox.."Rio:FilterSteckr"..msg.chat_id_,idsticker)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم منع الملصق بنجاح لن يتم ارساله مجددا', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevRio:sadd(Prox.."Rio:FilterPhoto"..msg.chat_id_,photo)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم منع الصوره بنجاح لن يتم ارسالها مجددا', 1, 'md')
return false
end
if result.content_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevRio:sadd(Prox.."Rio:FilterAnimation"..msg.chat_id_,idanimation)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم منع المتحركه بنجاح لن يتم ارسالها مجددا', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,filter_by_reply) 
end
--     Source Prox     --
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and ChCheck(msg) then     
function unfilter_by_reply(extra, result, success) 
if result.content_.sticker_ then
local idsticker = result.content_.sticker_.sticker_.persistent_id_
DevRio:srem(Prox.."Rio:FilterSteckr"..msg.chat_id_,idsticker)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء منع الملصق يمكنهم ارساله الان', 1, 'md')
return false
end
if result.content_.ID == "MessagePhoto" then
local photo = result.content_.photo_.id_
DevRio:srem(Prox.."Rio:FilterPhoto"..msg.chat_id_,photo)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء منع الصوره يمكنهم ارسالها الان', 1, 'md')
return false
end
if result.content_.animation_.animation_ then
local idanimation = result.content_.animation_.animation_.persistent_id_
DevRio:srem(Prox.."Rio:FilterAnimation"..msg.chat_id_,idanimation)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء منع المتحركه يمكنهم ارسالها الان', 1, 'md')
return false
end
end
getMessage(msg.chat_id_, msg.reply_to_message_id_,unfilter_by_reply) 
end
end
--     Source Prox     --
if text and (text == "تفعيل تحويل الصيغ" or text == "تفعيل التحويل") and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل تحويل الصيغ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Thwel:Rio'..msg.chat_id_) 
end
if text and (text == "تعطيل تحويل الصيغ" or text == "تعطيل التحويل") and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل تحويل الصيغ'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Thwel:Rio'..msg.chat_id_,true)  
end
if text == 'تحويل' and not DevRio:get(Prox..'Rio:Thwel:Rio'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then 
function ThwelByReply(extra, result, success)
if result.content_.photo_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.photo_.sizes_[1].photo_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.png') 
sendSticker(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.png')
os.execute('rm -rf ./'..msg.sender_user_id_..'.png') 
end   
if result.content_.sticker_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.sticker_.sticker_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.jpg') 
sendPhoto(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.jpg','⌔  تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
if result.content_.audio_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.audio_.audio_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.ogg') 
sendVoice(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.ogg',"⌔  تم تحويل الـMp3 الى بصمه")
os.execute('rm -rf ./'..msg.sender_user_id_..'.ogg') 
end   
if result.content_.voice_ then 
local Rio = json:decode(https.request('https://api.telegram.org/bot'.. TokenBot..'/getfile?file_id='..result.content_.voice_.voice_.persistent_id_)) 
download_to_file('https://api.telegram.org/file/bot'..TokenBot..'/'..Rio.result.file_path,msg.sender_user_id_..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..msg.sender_user_id_..'.mp3')  
os.execute('rm -rf ./'..msg.sender_user_id_..'.mp3') 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),ThwelByReply) 
end
end
--     Source Prox     --
if text ==("كشف") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) or text ==("ايدي") and msg.reply_to_message_id_ ~= 0 and ChCheck(msg) then 
function id_by_reply(extra, result, success) 
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..data.id_) or 0
local user_nkt = tonumber(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..data.id_) or 0)
if DevRio:sismember(Prox..'Rio:BanAll:',result.sender_user_id_) then
Tkeed = 'محظور عام'
elseif DevRio:sismember(Prox..'Rio:MuteAll:',result.sender_user_id_) then
Tkeed = 'مكتوم عام'
elseif DevRio:sismember(Prox..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'محظور'
elseif DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'مكتوم'
elseif DevRio:sismember(Prox..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⌔  القيود ↫ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(Prox..'Rio:SudoBot:',result.sender_user_id_) and SudoBot(msg) then
sudobot = '\n⌔  عدد الكروبات ↫ '..(DevRio:get(Prox..'Rio:Sudos'..result.sender_user_id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(result.sender_user_id_,msg.chat_id_) ~= false then
CustomTitle = '\n⌔  لقبه ↫ '..GetCustomTitle(result.sender_user_id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الحساب محذوف', 1, 'md')
return false  end
if data.username_ == false then
Text = '⌔  اسمه ↫ ['..data.first_name_..'](tg://user?id='..result.sender_user_id_..')\n⌔  ايديه ↫ 〈 `'..result.sender_user_id_..'` 〉\n⌔  رتبته ↫ '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\n⌔  رسائله ↫ 〈 '..user_msgs..' 〉\n⌔  تفاعله ↫ '..formsgs(user_msgs)..CustomTitle..'\n⌔  نقاطه ↫ 〈 '..user_nkt..' 〉'..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  معرفه ↫ [@'..data.username_..']\n⌔  ايديه ↫ 〈 `'..result.sender_user_id_..'` 〉\n⌔  رتبته ↫ '..IdRank(result.sender_user_id_, msg.chat_id_)..sudobot..'\n⌔  رسائله ↫ 〈 '..user_msgs..' 〉\n⌔  تفاعله ↫ '..formsgs(user_msgs)..CustomTitle..'\n⌔  نقاطه ↫ 〈 '..user_nkt..' 〉'..Tked, 1, 'md')
end
end,nil)
end 
getMessage(msg.chat_id_, msg.reply_to_message_id_,id_by_reply) 
end
if text and text:match('^كشف @(.*)') and ChCheck(msg) or text and text:match('^ايدي @(.*)') and ChCheck(msg) then 
local username = text:match('^كشف @(.*)') or text:match('^ايدي @(.*)')
tdcli_function ({ID = "SearchPublicChat",username_ = username},function(extra, res, success) 
if res and res.message_ and res.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  *المعرف غير صحيح*', 1, 'md')
return false  end
if res.type_.ID == "ChannelChatInfo" then 
if res.type_.channel_.is_supergroup_ == false then
local ch = 'قناة'
local chn = '⌔  نوع الحساب ↫ 〈 '..ch..' 〉\n⌔  الايدي ↫ 〈 `'..res.id_..'` 〉\n⌔  المعرف ↫ 〈 [@'..username..'] 〉\n⌔  الاسم ↫ 〈 ['..res.title_..'] 〉'
Dev_Rio(msg.chat_id_, msg.id_, 1,chn, 1, 'md')
else
local gr = 'مجموعه'
local grr = '⌔  نوع الحساب ↫ 〈 '..gr..' 〉\n⌔  الايدي ↫ 〈 '..res.id_..' 〉\n⌔  المعرف ↫ 〈 [@'..username..'] 〉\n⌔  الاسم ↫ 〈 ['..res.title_..'] 〉'
Dev_Rio(msg.chat_id_, msg.id_, 1,grr, 1, 'md')
end
return false  end
if res.id_ then  
tdcli_function ({ID = "GetUser",user_id_ = res.id_},function(arg,data) 
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..res.id_) or 0
local user_nkt = tonumber(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..res.id_) or 0)
if DevRio:sismember(Prox..'Rio:BanAll:',res.id_) then
Tkeed = 'محظور عام'
elseif DevRio:sismember(Prox..'Rio:MuteAll:',res.id_) then
Tkeed = 'مكتوم عام'
elseif DevRio:sismember(Prox..'Rio:Ban:'..msg.chat_id_,res.id_) then
Tkeed = 'محظور'
elseif DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_,res.id_) then
Tkeed = 'مكتوم'
elseif DevRio:sismember(Prox..'Rio:Tkeed:'..msg.chat_id_,res.id_) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⌔  القيود ↫ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(Prox..'Rio:SudoBot:',res.id_) and SudoBot(msg) then
sudobot = '\n⌔  عدد الكروبات ↫ '..(DevRio:get(Prox..'Rio:Sudos'..res.id_) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(res.id_,msg.chat_id_) ~= false then
CustomTitle = '\n⌔  لقبه ↫ '..GetCustomTitle(res.id_,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الحساب محذوف', 1, 'md')
return false  end
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  معرفه ↫ [@'..data.username_..']\n⌔  ايديه ↫ 〈 `'..res.id_..'` 〉\n⌔  رتبته ↫ '..IdRank(res.id_, msg.chat_id_)..sudobot..'\n⌔  رسائله ↫ 〈 '..user_msgs..' 〉\n⌔  تفاعله ↫ '..formsgs(user_msgs)..CustomTitle..'\n⌔  نقاطه ↫ 〈 '..user_nkt..' 〉'..Tked, 1, 'md')
end,nil)
end 
end,nil)
return false 
end
if text and text:match('كشف (%d+)') and ChCheck(msg) or text and text:match('ايدي (%d+)') and ChCheck(msg) then 
local iduser = text:match('كشف (%d+)') or text:match('ايدي (%d+)')  
tdcli_function ({ID = "GetUser",user_id_ = iduser},function(arg,data) 
if data.message_ == "User not found" then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  لم يتم التعرف على الحساب', 1, 'md')
return false  
end
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..iduser) or 0
local user_nkt = tonumber(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..iduser) or 0)
if DevRio:sismember(Prox..'Rio:BanAll:',iduser) then
Tkeed = 'محظور عام'
elseif DevRio:sismember(Prox..'Rio:MuteAll:',iduser) then
Tkeed = 'مكتوم عام'
elseif DevRio:sismember(Prox..'Rio:Ban:'..msg.chat_id_,iduser) then
Tkeed = 'محظور'
elseif DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_,iduser) then
Tkeed = 'مكتوم'
elseif DevRio:sismember(Prox..'Rio:Tkeed:'..msg.chat_id_,iduser) then
Tkeed = 'مقيد'
else
Tkeed = false
end
if Tkeed ~= false then
Tked = '\n⌔  القيود ↫ '..Tkeed
else 
Tked = '' 
end
if DevRio:sismember(Prox..'Rio:SudoBot:',iduser) and SudoBot(msg) then
sudobot = '\n⌔  عدد الكروبات ↫ '..(DevRio:get(Prox..'Rio:Sudos'..iduser) or 0)..'' 
else 
sudobot = '' 
end
if GetCustomTitle(iduser,msg.chat_id_) ~= false then
CustomTitle = '\n⌔  لقبه ↫ '..GetCustomTitle(iduser,msg.chat_id_)
else 
CustomTitle = '' 
end
if data.first_name_ == false then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  الحساب محذوف', 1, 'md')
return false  end
if data.username_ == false then
Text = '⌔  اسمه ↫ ['..data.first_name_..'](tg://user?id='..iduser..')\n⌔  ايديه ↫ 〈 `'..iduser..'` 〉\n⌔  رتبته ↫ '..IdRank(data.id_, msg.chat_id_)..sudobot..'\n⌔  رسائله ↫ 〈 '..user_msgs..' 〉\n⌔  تفاعله ↫ '..formsgs(user_msgs)..CustomTitle..'\n⌔  نقاطه ↫ 〈 '..user_nkt..' 〉'..Tked
SendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  معرفه ↫ [@'..data.username_..']\n⌔  ايديه ↫ 〈 `'..iduser..'` 〉\n⌔  رتبته ↫ '..IdRank(data.id_, msg.chat_id_)..sudobot..'\n⌔  رسائله ↫ 〈 '..user_msgs..' 〉\n⌔  تفاعله ↫ '..formsgs(user_msgs)..CustomTitle..'\n⌔  نقاطه ↫ 〈 '..user_nkt..' 〉'..Tked, 1, 'md')
end
end,nil)
return false 
end 
--     Source Prox     --
if text == 'كشف القيود' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function kshf_by_reply(extra, result, success)
if DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) then muted = 'مكتوم' else muted = 'غير مكتوم' end
if DevRio:sismember(Prox..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) then banned = 'محظور' else banned = 'غير محظور' end
if DevRio:sismember(Prox..'Rio:BanAll:',result.sender_user_id_) then banall = 'محظور عام' else banall = 'غير محظور عام' end
if DevRio:sismember(Prox..'Rio:MuteAll:',result.sender_user_id_) then muteall = 'مكتوم عام' else muteall = 'غير مكتوم عام' end
if DevRio:sismember(Prox..'Rio:Tkeed:',result.sender_user_id_) then tkeed = 'مقيد' else tkeed = 'غير مقيد' end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الحظر العام ↫ '..banall..'\n⌔  الكتم العام ↫ '..muteall..'\n⌔  الحظر ↫ '..banned..'\n⌔  الكتم ↫ '..muted..'\n⌔  التقيد ↫ '..tkeed, 1, 'md')  
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),kshf_by_reply) 
end
if text and text:match('^كشف القيود @(.*)') and Admin(msg) and ChCheck(msg) then 
local username = text:match('^كشف القيود @(.*)') 
function kshf_by_username(extra, result, success)
if result.id_ then
if DevRio:sismember(Prox..'Rio:Muted:'..msg.chat_id_,result.id_) then muted = 'مكتوم' else muted = 'غير مكتوم' end
if DevRio:sismember(Prox..'Rio:Ban:'..msg.chat_id_,result.id_) then banned = 'محظور' else banned = 'غير محظور' end
if DevRio:sismember(Prox..'Rio:BanAll:',result.id_) then banall = 'محظور عام' else banall = 'غير محظور عام' end
if DevRio:sismember(Prox..'Rio:MuteAll:',result.id_) then muteall = 'مكتوم عام' else muteall = 'غير مكتوم عام' end
if DevRio:sismember(Prox..'Rio:Tkeed:',result.id_) then tkeed = 'مقيد' else tkeed = 'غير مقيد' end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الحظر العام ↫ '..banall..'\n⌔  الكتم العام ↫ '..muteall..'\n⌔  الحظر ↫ '..banned..'\n⌔  الكتم ↫ '..muted..'\n⌔  التقيد ↫ '..tkeed, 1, 'md')  
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')  
end
end
resolve_username(username,kshf_by_username) 
end
if text == 'رفع القيود' and tonumber(msg.reply_to_message_id_) > 0 and Admin(msg) and ChCheck(msg) then 
function unbanreply(extra, result, success) 
if tonumber(result.sender_user_id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
ReplyStatus(msg,result.sender_user_id_,"Reply","⌔  تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(Prox..'Rio:BanAll:',result.sender_user_id_) DevRio:srem(Prox..'Rio:MuteAll:',result.sender_user_id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.sender_user_id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,result.sender_user_id_) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,result.sender_user_id_) 
end
end
getMessage(msg.chat_id_, tonumber(msg.reply_to_message_id_),unbanreply) 
end
if text and text:match('^رفع القيود (%d+)') and Admin(msg) and ChCheck(msg) then 
local user = text:match('رفع القيود (%d+)') 
if tonumber(user) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = user},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لم استطع استخراج المعلومات', 1, 'md') 
return false  
end
ReplyStatus(msg,user,"Reply","⌔  تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,user) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,user) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,user) DevRio:srem(Prox..'Rio:BanAll:',user) DevRio:srem(Prox..'Rio:MuteAll:',user)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..user.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,user) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,user) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,user) 
end  
end,nil)  
end
if text and text:match('^رفع القيود @(.*)') and Admin(msg) and ChCheck(msg) then  
local username = text:match('رفع القيود @(.*)')  
function unbanusername(extra,result,success)  
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *المعرف غير صحيح*', 1, 'md')  
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا معرف قناة وليس معرف حساب', 1, 'md') 
return false  
end
if tonumber(result.id_) == tonumber(Prox) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  انا البوت وليس لدي قيود', 1, 'md')  
return false  
end 
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(arg,data) 
if data and data.code_ and data.code_ == 6 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لم استطع استخراج المعلومات', 1, 'md') 
return false  
end
ReplyStatus(msg,result.id_,"Reply","⌔  تم رفع قيوده") 
if SecondSudo(msg) then
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,result.id_) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,result.id_) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,result.id_) DevRio:srem(Prox..'Rio:BanAll:',result.id_) DevRio:srem(Prox..'Rio:MuteAll:',result.id_)
else
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id=" ..result.id_.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")  
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_,result.id_) DevRio:srem(Prox..'Rio:Ban:'..msg.chat_id_,result.id_) DevRio:srem(Prox..'Rio:Muted:'..msg.chat_id_,result.id_) 
end
end,nil)   
end  
resolve_username(username,unbanusername) 
end 
--     Source Prox     --
if Manager(msg) then
if text and text:match("^تغيير الايدي$") and ChCheck(msg) or text and text:match("^تغير الايدي$") and ChCheck(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂️ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 : #username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 : #stast 
𓄼🇮🇶 𝒊𝒅 : #id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 : #game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 : #msgs
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]],
[[
⌔  𝐔𝐒𝐄𝐑 ↬ #username 
⌔  𝐈𝐃 ↬ #id
⌔  𝐒𝐓𝐀𝐒𝐓 ↬ #stast
⌔  𝐀𝐔𝐓𝐎 ↬ #cont 
⌔  𝐌𝐀𝐒𝐆 ↬ #msgs
⌔  𝐆𝐀𝐌𝐄 ↬ #game
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . #username 🇺🇸 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧 . #stast 🇺🇸 ꙰
ᯓ 𝗜𝗗 . #id 🇺🇸 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 . #game 🇺🇸 ꙰
ᯓ 𝗺𝗦𝗚𝗦 . #msgs 🇺🇸 ꙰
]],
[[
- ᴜѕᴇʀɴᴀᴍᴇ ➥• #username .
- ᴍѕɢѕ ➥• #msgs .
- ѕᴛᴀᴛѕ ➥• #stast .
- ʏᴏᴜʀ ɪᴅ ➥• #id  .
- ᴇᴅɪᴛ ᴍsɢ ➥• #edit .
- ᴅᴇᴛᴀɪʟs ➥• #auto . 
- ɢᴀᴍᴇ ➥• #game .
]]}
local Text_Rand = List[math.random(#List)]
DevRio:set(Prox.."Rio:GpIds:Text"..msg.chat_id_,Text_Rand)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم تغير كليشة الايدي")  
end
--     Source Prox     --
if SecondSudo(msg) then
if text and text:match("^تعيين الايدي العام$") or text and text:match("^تعين الايدي العام$") or text and text:match("^تعيين كليشة الايدي$") then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  رجائا اتبع التعليمات للتعيين \n⌔  لطبع كليشة الايدي ارسل كليشه تحتوي على النصوص التي باللغه الانجليزيه ادناه ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n `#username` ↬ لطبع المعرف\n `#id` ↬ لطبع الايدي \n `#photos` ↬ لطبع عدد الصور \n `#stast` ↬ لطبع الرتب \n `#msgs` ↬ لطبع عدد الرسائل \n `#msgday` ↬ لطبع الرسائل اليوميه \n `#CustomTitle` ↬ لطبع اللقب \n `#bio` ↬ لطبع البايو \n `#auto` ↬ لطبع التفاعل \n `#game` ↬ لطبع عدد النقاط \n `#cont` ↬ لطبع عدد الجهات \n `#edit` ↬ لطبع عدد السحكات \n `#Description` ↬ لطبع تعليق الصور\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈', 1, 'md')
DevRio:set("Prox:New:id:"..Prox..msg.sender_user_id_,'ProxTeam')
return "ProxTeam"
end
if text and DevRio:get("Prox:New:id:"..Prox..msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ كليشة الايدي', 1, 'md')
DevRio:del("Prox:New:id:"..Prox..msg.sender_user_id_)
return false
end
DevRio:del("Prox:New:id:"..Prox..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ كليشة الايدي العامه', 1, 'md')
DevRio:set(Prox.."Rio:AllIds:Text",text)
return false
end
if text and text:match("^حذف الايدي العام$") or text and text:match("^مسح الايدي العام$") or text and text:match("^حذف كليشة الايدي$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف كليشة الايدي العامه")  
DevRio:del(Prox.."Rio:AllIds:Text")
end
end
--     Source Prox     --
if text and text:match("^تعيين الايدي$") and ChCheck(msg) or text and text:match("^تعين الايدي$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  رجائا اتبع التعليمات للتعيين \n⌔  لطبع كليشة الايدي ارسل كليشه تحتوي على النصوص التي باللغه الانجليزيه ادناه ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n `#username` ↬ لطبع المعرف\n `#id` ↬ لطبع الايدي \n `#photos` ↬ لطبع عدد الصور \n `#stast` ↬ لطبع الرتب \n `#msgs` ↬ لطبع عدد الرسائل \n `#msgday` ↬ لطبع الرسائل اليوميه \n `#CustomTitle` ↬ لطبع اللقب \n `#bio` ↬ لطبع البايو \n `#auto` ↬ لطبع التفاعل \n `#game` ↬ لطبع عدد النقاط \n `#cont` ↬ لطبع عدد الجهات \n `#edit` ↬ لطبع عدد السحكات \n `#Description` ↬ لطبع تعليق الصور\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈', 1, 'md')
DevRio:set("Prox:New:id:"..Prox..msg.chat_id_..msg.sender_user_id_,'ProxTeam')
return "ProxTeam"
end
if text and Manager(msg) and DevRio:get("Prox:New:id:"..Prox..msg.chat_id_..msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ كليشة الايدي', 1, 'md')
DevRio:del("Prox:New:id:"..Prox..msg.chat_id_..msg.sender_user_id_)
return false
end
DevRio:del("Prox:New:id:"..Prox..msg.chat_id_..msg.sender_user_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ الكليشه الجديده', 1, 'md')
DevRio:set(Prox.."Rio:GpIds:Text"..msg.chat_id_,text)
return false
end
if text and text:match("^حذف الايدي$") and ChCheck(msg) or text and text:match("^مسح الايدي$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف كليشة الايدي")  
DevRio:del(Prox.."Rio:GpIds:Text"..msg.chat_id_)
end
end
--     Source Prox     --
if msg.reply_to_message_id_ ~= 0 then
return ""
else
if text and (text:match("^ايدي$") or text:match("^id$") or text:match("^Id$")) and ChCheck(msg) then
function ProxTeam(extra,rio,success)
if rio.username_ then username = '@'..rio.username_ else username = 'لا يوجد' end
if GetCustomTitle(msg.sender_user_id_,msg.chat_id_) ~= false then CustomTitle = GetCustomTitle(msg.sender_user_id_,msg.chat_id_) else CustomTitle = 'لا يوجد' end
local function getpro(extra, rio, success) 
local msgsday = DevRio:get(Prox..'Rio:UsersMsgs'..Prox..os.date('%d')..':'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local edit_msg = DevRio:get(Prox..'Rio:EditMsg'..msg.chat_id_..msg.sender_user_id_) or 0
local user_msgs = DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_)
local user_nkt = tonumber(DevRio:get(Prox..'Rio:GamesNumber'..msg.chat_id_..msg.sender_user_id_) or 0)
local cont = (tonumber(DevRio:get(Prox..'Rio:ContactNumber'..msg.chat_id_..':'..msg.sender_user_id_)) or 0)
local msguser = tonumber(DevRio:get(Prox..'Rio:UsersMsgs'..msg.chat_id_..':'..msg.sender_user_id_))
local Texting = {"مو صوره ظيم بالنبي ،🤤💞","مقتنع بصورتك !؟ 😹🖤","ملاك وناسيك بكروبنه ،🤤💞","وفالله ،🤤💞","كشخه برب ،😉🤍","لزكت بيها دغيرها عاد ،😒😕","صورتك مامرتاحلها ،🙄😶","حلغوم والله ،🥺💘","مو صوره غنبله براسها ٦٠ حظ ،😹🤍"}
local Description = Texting[math.random(#Texting)]
if rio.photos_[0] then
if not DevRio:get(Prox..'Rio:Lock:Id'..msg.chat_id_) then 
if not DevRio:get(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_) then 
if DevRio:get(Prox.."Rio:AllIds:Text") then
newpicid = DevRio:get(Prox.."Rio:AllIds:Text")
newpicid = newpicid:gsub('#username',(username or 'لا يوجد'))
newpicid = newpicid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
newpicid = newpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
newpicid = newpicid:gsub('#photos',(rio.total_count_ or 'لا يوجد')) 
newpicid = newpicid:gsub('#game',(user_nkt or 'لا يوجد'))
newpicid = newpicid:gsub('#edit',(edit_msg or 'لا يوجد'))
newpicid = newpicid:gsub('#cont',(cont or 'لا يوجد'))
newpicid = newpicid:gsub('#msgs',(user_msgs or 'لا يوجد'))
newpicid = newpicid:gsub('#msgday',(msgsday or 'لا يوجد'))
newpicid = newpicid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
newpicid = newpicid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
newpicid = newpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
newpicid = newpicid:gsub('#Description',(Description or 'لا يوجد'))
else
newpicid = ""..Description.."\n U𝘴ꫀ𝘳 メ〈"..username.."〉\n 𝓲 ᦔ メ〈"..msg.sender_user_id_.."〉\n Rꪖꪀ𝘬 メ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n M𝘴ᧁ メ〈"..user_msgs.."〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
end 
if not DevRio:get(Prox.."Rio:GpIds:Text"..msg.chat_id_) then 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, rio.photos_[0].sizes_[1].photo_.persistent_id_,newpicid,msg.id_,msg.id_.."")
else 
local new_id = DevRio:get(Prox.."Rio:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'لا يوجد'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#photos',(rio.total_count_ or '')) 
local new_id = new_id:gsub('#game',(user_nkt or 'لا يوجد'))
local new_id = new_id:gsub('#edit',(edit_msg or 'لا يوجد'))
local new_id = new_id:gsub('#cont',(cont or 'لا يوجد'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'لا يوجد'))
local new_id = new_id:gsub('#msgday',(msgsday or 'لا يوجد'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#Description',(Description or 'لا يوجد'))
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, rio.photos_[0].sizes_[1].photo_.persistent_id_,new_id,msg.id_,msg.id_.."")
end
else
if DevRio:get(Prox.."Rio:AllIds:Text") then
newallid = DevRio:get(Prox.."Rio:AllIds:Text")
newallid = newallid:gsub('#username',(username or 'لا يوجد'))
newallid = newallid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
newallid = newallid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
newallid = newallid:gsub('#photos',(rio.total_count_ or 'لا يوجد')) 
newallid = newallid:gsub('#game',(user_nkt or 'لا يوجد'))
newallid = newallid:gsub('#edit',(edit_msg or 'لا يوجد'))
newallid = newallid:gsub('#cont',(cont or 'لا يوجد'))
newallid = newallid:gsub('#msgs',(user_msgs or 'لا يوجد'))
newallid = newallid:gsub('#msgday',(msgsday or 'لا يوجد'))
newallid = newallid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
newallid = newallid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
newallid = newallid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
newallid = newallid:gsub('#Description',(Description or 'لا يوجد'))
else
newallid = "◍ U𝘴ꫀ𝘳 メ〈"..username.."〉\n 𝓲 ᦔ メ〈"..msg.sender_user_id_.."〉\n Rꪖꪀ𝘬 メ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n M𝘴ᧁ メ〈"..user_msgs.."〉"
end 
if not DevRio:get(Prox.."Rio:GpIds:Text"..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, newallid, 1, 'html')
else
local new_id = DevRio:get(Prox.."Rio:GpIds:Text"..msg.chat_id_)
local new_id = new_id:gsub('#username',(username or 'لا يوجد'))
local new_id = new_id:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
local new_id = new_id:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#photos',(rio.total_count_ or 'لا يوجد')) 
local new_id = new_id:gsub('#game',(user_nkt or 'لا يوجد'))
local new_id = new_id:gsub('#edit',(edit_msg or 'لا يوجد'))
local new_id = new_id:gsub('#cont',(cont or 'لا يوجد'))
local new_id = new_id:gsub('#msgs',(user_msgs or 'لا يوجد'))
local new_id = new_id:gsub('#msgday',(msgsday or 'لا يوجد'))
local new_id = new_id:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
local new_id = new_id:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
local new_id = new_id:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
local new_id = new_id:gsub('#Description',(Description or 'لا يوجد'))
Dev_Rio(msg.chat_id_, msg.id_, 1, new_id, 1, 'html')  
end
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔︙عذرا الايدي معطل ', 1, 'md')
end
else
if DevRio:get(Prox.."Rio:AllIds:Text") then
notpicid = DevRio:get(Prox.."Rio:AllIds:Text")
notpicid = notpicid:gsub('#username',(username or 'لا يوجد'))
notpicid = notpicid:gsub('#CustomTitle',(CustomTitle or 'لا يوجد'))
notpicid = notpicid:gsub('#bio',(GetBio(msg.sender_user_id_) or 'لا يوجد'))
notpicid = notpicid:gsub('#photos',(rio.total_count_ or 'لا يوجد')) 
notpicid = notpicid:gsub('#game',(user_nkt or 'لا يوجد'))
notpicid = notpicid:gsub('#edit',(edit_msg or 'لا يوجد'))
notpicid = notpicid:gsub('#cont',(cont or 'لا يوجد'))
notpicid = notpicid:gsub('#msgs',(user_msgs or 'لا يوجد'))
notpicid = notpicid:gsub('#msgday',(msgsday or 'لا يوجد'))
notpicid = notpicid:gsub('#id',(msg.sender_user_id_ or 'لا يوجد'))
notpicid = notpicid:gsub('#auto',(formsgs(msguser) or 'لا يوجد'))
notpicid = notpicid:gsub('#stast',(IdRank(msg.sender_user_id_, msg.chat_id_) or 'لا يوجد'))
notpicid = notpicid:gsub('#Description',(Description or 'لا يوجد'))
else
notpicid = "◍لا استطيع عرض صورتك لانك قمت بحظر البوت او انك لاتمتلك صوره في بروفايلك\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n U𝘴ꫀ𝘳 メ〈 "..username.."〉\n 𝓲 ᦔ メ〈 "..msg.sender_user_id_.."〉\n Rꪖꪀ𝘬 メ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n M𝘴ᧁ メ〈 "..user_msgs.."〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
end 
if not DevRio:get(Prox..'Rio:Lock:Id'..msg.chat_id_) then
if not DevRio:get(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, notpicid, 1, 'html')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, " U𝘴ꫀ𝘳 メ〈"..username.."〉\n 𝓲 ᦔ メ〈"..msg.sender_user_id_.."〉\n Rꪖꪀ𝘬 メ "..IdRank(msg.sender_user_id_, msg.chat_id_).."\n M𝘴ᧁ メ〈"..user_msgs.."〉", 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔︙عذرا الايدي معطل', 1, 'md')
end end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
getUser(msg.sender_user_id_, ProxTeam)
end
end 
--     Source Prox     --
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^قفل (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(قفل) (.*)$")}
if LockText[2] == "التعديل" then
if not DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التعديل")  
DevRio:set(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التعديل بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "التعديل الميديا" or LockText[2] == "تعديل الميديا" then
if not DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل تعديل الميديا")  
DevRio:set(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تعديل الميديا بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفارسيه" then
if not DevRio:get(Prox..'Rio:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الفارسيه")  
DevRio:set(Prox..'Rio:Lock:Farsi'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفارسيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفشار" then
if DevRio:get(Prox..'Rio:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الفشار")  
DevRio:del(Prox..'Rio:Lock:Fshar'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفشار بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الطائفيه" then
if DevRio:get(Prox..'Rio:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الطائفيه")  
DevRio:del(Prox..'Rio:Lock:Taf'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الطائفيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الكفر" then
if DevRio:get(Prox..'Rio:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الكفر")  
DevRio:del(Prox..'Rio:Lock:Kfr'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الكفر بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفارسيه بالطرد" then
if not DevRio:get(Prox..'Rio:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الفارسيه بالطرد")  
DevRio:set(Prox..'Rio:Lock:FarsiBan'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفارسيه بالطرد بالفعل مقفله ', 1, 'md')
end
end
if LockText[2] == "البوتات" or LockText[2] == "البوتات بالحذف" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل البوتات بالحذف")  
DevRio:set(Prox.."Rio:Lock:Bots"..msg.chat_id_,"del")  
end
if LockText[2] == "البوتات بالطرد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل البوتات بالطرد")  
DevRio:set(Prox.."Rio:Lock:Bots"..msg.chat_id_,"kick")  
end
if LockText[2] == "البوتات بالتقييد" or LockText[2] == "البوتات بالتقيد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل البوتات بالتقيد")  
DevRio:set(Prox.."Rio:Lock:Bots"..msg.chat_id_,"ked")  
end
if LockText[2] == "التكرار" or LockText[2] == "التكرار بالحذف" then 
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","del")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التكرار بالحذف")  
end
if LockText[2] == "التكرار بالطرد" then 
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","kick")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التكرار بالطرد")  
end
if LockText[2] == "التكرار بالتقيد" or LockText[2] == "التكرار بالتقييد" then 
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التكرار بالتقيد")  
end
if LockText[2] == "التكرار بالكتم" then 
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","mute")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التكرار بالكتم")  
end
if BasicConstructor(msg) then
if LockText[2] == "التثبيت" then
if not DevRio:get(Prox..'Rio:Lock:Pin'..msg.chat_id_) then
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = msg.chat_id_:gsub("-100","") }, function(arg,data)  DevRio:set(Prox.."Rio:PinnedMsg"..msg.chat_id_,data.pinned_message_id_)  end,nil)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التثبيت")  
DevRio:set(Prox..'Rio:Lock:Pin'..msg.chat_id_,true)
DevRio:sadd(Prox.."Rio:Lock:Pinpin",msg.chat_id_) 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التثبيت بالفعل مقفل في المجموعه', 1, 'md')
end end end
end
end
end
--     Source Prox     --
if Admin(msg) then
if text and (text:match("^ضع تكرار (%d+)$") or text:match("^وضع تكرار (%d+)$")) then   
local TextSpam = text:match("ضع تكرار (%d+)$") or text:match("وضع تكرار (%d+)$")
if tonumber(TextSpam) < 2 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بتحديد عدد اكبر من 2 للتكرار', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم وضع عدد التكرار ↫ '..TextSpam, 1, 'md')
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Num:Spam" ,TextSpam) 
end
end
if text and (text:match("^ضع زمن التكرار (%d+)$") or text:match("^وضع زمن التكرار (%d+)$")) then  
local TextSpam = text:match("ضع زمن التكرار (%d+)$") or text:match("وضع زمن التكرار (%d+)$")
DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Num:Spam:Time" ,TextSpam) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم وضع زمن التكرار ↫ '..TextSpam, 1, 'md')
end
--     Source Prox     --
if Manager(msg) then
if text and text == 'تفعيل الايدي بالصوره' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الايدي بالصوره بالتاكيد مفعل', 1, 'md')
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الايدي بالصوره'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_)
end end
if text and text == 'تعطيل الايدي بالصوره' and ChCheck(msg) then
if DevRio:get(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الايدي بالصوره بالتاكيد معطل', 1, 'md')
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الايدي بالصوره'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Id:Photo'..msg.chat_id_,true)
end end 

if text and text == 'تفعيل الايدي' and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Lock:Id'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الايدي بالتاكيد مفعل ', 1, 'md')
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الايدي بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Id'..msg.chat_id_)
end end 
if text and text == 'تعطيل الايدي' and ChCheck(msg) then
if DevRio:get(Prox..'Rio:Lock:Id'..msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الايدي بالتاكيد معطل ', 1, 'md')
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الايدي بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Id'..msg.chat_id_,true)
end end
end
--     Source Prox     --
if text == 'ضع رابط' and ChCheck(msg) or text == 'وضع رابط' and ChCheck(msg) or text == 'ضع الرابط' and ChCheck(msg) or text == 'وضع الرابط' and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل رابط المجموعه او رابط قناة المجموعه', 1, 'md')
DevRio:setex(Prox.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
if text == 'انشاء رابط' and ChCheck(msg) or text == 'انشاء الرابط' and ChCheck(msg) then
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if not DevRio:get(Prox.."Rio:Groups:Links"..msg.chat_id_)  then 
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
DevRio:set(Prox.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم انشاء رابط جديد ارسل ↫ الرابط', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ليست لدي صلاحية دعوة المستخدمين عبر الرابط يرجى التحقق من الصلاحيات', 1, 'md')
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل رابط المجموعه او رابط قناة المجموعه', 1, 'md')
DevRio:setex(Prox.."Rio:Set:Groups:Links"..msg.chat_id_..msg.sender_user_id_,300,true) 
end
end
end
--     Source Prox     --
if Admin(msg) then
if text and text:match("^تفعيل الترحيب$") and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الترحيب بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Lock:Welcome"..msg.chat_id_,true)
end
if text and text:match("^تعطيل الترحيب$") and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الترحيب بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Lock:Welcome"..msg.chat_id_)
end
if DevRio:get(Prox..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ كليشة الترحيب', 1, 'md')
DevRio:del(Prox..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(Prox..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_)
Welcomes = text:gsub('"',"") Welcomes = text:gsub("'","") Welcomes = text:gsub(",","") Welcomes = text:gsub("*","") Welcomes = text:gsub(";","") Welcomes = text:gsub("`","") Welcomes = text:gsub("{","") Welcomes = text:gsub("}","") 
DevRio:set(Prox..'Rio:Groups:Welcomes'..msg.chat_id_,Welcomes)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ كليشة الترحيب', 1, 'md')
return false   
end
if text and text:match("^ضع ترحيب$") and ChCheck(msg) or text and text:match("^وضع ترحيب$") and ChCheck(msg) or text and text:match("^اضف ترحيب$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل لي الترحيب الان\n⌔  تستطيع اضافة مايلي ↫ ⤈\n⌔  دالة عرض الاسم ↫ firstname\n⌔  دالة عرض المعرف ↫ username', 1, 'md')
DevRio:set(Prox..'Rio:setwelcome'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
if text and text:match("^حذف الترحيب$") and ChCheck(msg) or text and text:match("^حذف ترحيب$") and ChCheck(msg) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف الترحيب")  
DevRio:del(Prox..'Rio:Groups:Welcomes'..msg.chat_id_)
end
if text and text:match("^جلب الترحيب$") and ChCheck(msg) or text and text:match("^جلب ترحيب$") and ChCheck(msg) or text and text:match("^الترحيب$") and ChCheck(msg) then
local Welcomes = DevRio:get(Prox..'Rio:Groups:Welcomes'..msg.chat_id_)
if Welcomes then
Dev_Rio(msg.chat_id_, msg.id_, 1, Welcomes, 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لم يتم وضع الترحيب \n⌔  ارسل ↫ ضع ترحيب للحفظ ', 1, 'md')
end
end
--     Source Prox     --
if DevRio:get(Prox..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_) then  
if text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء حفظ الوصف", 1, 'md')
DevRio:del(Prox..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(Prox..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_)
https.request('https://api.telegram.org/bot'..TokenBot..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تغيير وصف المجموعه', 1, 'md')
return false  
end 
if text and text:match("^ضع وصف$") and ChCheck(msg) or text and text:match("^وضع وصف$") and ChCheck(msg) then  
DevRio:set(Prox..'Rio:SetDescription'..msg.chat_id_..':'..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل لي الوصف الان', 1, 'md')
end
--     Source Prox     --
if text and text == "منع" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل لي الكلمه الان", 1, 'md') 
DevRio:set(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_,"add")  
return false  
end    
if DevRio:get(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "add" then
if text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر المنع', 1, 'md')
DevRio:del(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم منع الكلمه ↫ "..text, 1, 'html')
DevRio:del(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
DevRio:hset(Prox..'Rio:Filters:'..msg.chat_id_, text,'newword')
return false
end
if text and text == "الغاء منع" and msg.reply_to_message_id_ == 0 and ChCheck(msg) then       
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل لي الكلمه الان", 1, 'md') 
DevRio:set(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_,"del")  
return false  
end    
if DevRio:get(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_) == "del" then   
if text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر الغاء المنع', 1, 'md')
DevRio:del(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
return false  
end   
if not DevRio:hget(Prox..'Rio:Filters:'..msg.chat_id_, text) then  
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  الكلمه ↫ "..text.." غير ممنوعه", 1, 'html')
DevRio:del(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
else
DevRio:hdel(Prox..'Rio:Filters:'..msg.chat_id_, text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  الكلمه ↫ "..text.." تم الغاء منعها", 1, 'html')
DevRio:del(Prox.."Rio:SetFilters"..msg.sender_user_id_..msg.chat_id_)  
end
return false
end
--     Source Prox     --
if SudoBot(msg) then
if text and text == "الاحصائيات" and ChCheck(msg) or text and text == "↫  الاحصائيات ⌔" and ChCheck(msg) then
local gps = DevRio:scard(Prox.."Rio:Groups") local users = DevRio:scard(Prox.."Rio:Users") 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  احصائيات البوت ↫ ⤈\n⌔  عدد المشتركين ↫ 〈 '..users..' 〉\n⌔  عدد المجموعات ↫ 〈 '..gps..' 〉', 1, 'md')
end
if text and text == "المشتركين" and ChCheck(msg) or text and text == "↫ المشتركين ⌔" and ChCheck(msg) then
local users = DevRio:scard(Prox.."Rio:Users")
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد المشتركين ↫ 〈 '..users..' 〉', 1, 'md')
end
if text and text == "المجموعات" and ChCheck(msg) or text and text == "↫ المجموعات ⌔" and ChCheck(msg) then
local gps = DevRio:scard(Prox.."Rio:Groups")
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد المجموعات ↫ 〈 '..gps..' 〉', 1, 'md')
end
end
--     Source Prox     --
if text and text == "المجموعات" and ChCheck(msg) or text and text == "↫ المجموعات ⌔" and ChCheck(msg) then
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطورين فقط ', 1, 'md')
else
local list = DevRio:smembers(Prox.."Rio:Groups")
local t = '⌔  مجموعات البوت ↫ ⤈ \n'
for k,v in pairs(list) do
t = t..k.."~ : `"..v.."`\n" 
end
if #list == 0 then
t = '⌔  لا يوجد مجموعات مفعله'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,t, 1, 'md')
end end
--     Source Prox     --
if text and text:match('^تنظيف (%d+)$') or text and text:match('^مسح (%d+)$') and ChCheck(msg) then  
if not DevRio:get(Prox..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then  
local Number = tonumber(text:match('^تنظيف (%d+)$') or text:match('^مسح (%d+)$')) 
if Number > 5000 then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لاتستطيع تنظيف اكثر من 5000 رساله', 1, 'md')
return false  
end  
local Message = msg.id_
for i=1,tonumber(Number) do
DeleteMessage(msg.chat_id_,{[0]=Message})
Message = Message - 1048576 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تنظيف *'..Number..'* من الرسائل', 1, 'md')
DevRio:setex(Prox..'Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end 
end
if text == "تنظيف المشتركين" and SecondSudo(msg) and ChCheck(msg) or text == "↫ تنظيف المشتركين ⌔" and SecondSudo(msg) and ChCheck(msg) then 
local pv = DevRio:smembers(Prox.."Rio:Users")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok" then
else
DevRio:srem(Prox.."Rio:Users",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  *لا يوجد مشتركين وهميين*', 1, 'md')
else
local ok = #pv - sendok
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد المشتركين الان ↫ { '..#pv..' }\n⌔  تم حذف ↫ { '..sendok..' } من المشتركين\n⌔  العدد الحقيقي الان  ↫ ( '..ok..' ) \n', 1, 'md')
end
end
end,nil)
end,nil)
end
return false
end
--     Source Prox     --
if text == "تنظيف الكروبات" and SecondSudo(msg) and ChCheck(msg) or text == "تنظيف المجموعات" and SecondSudo(msg) and ChCheck(msg) or text == "↫ تنظيف المجموعات ⌔" and SecondSudo(msg) and ChCheck(msg) then 
local group = DevRio:smembers(Prox.."Rio:Groups")
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
DevRio:srem(Prox.."Rio:Groups",group[i]) 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = group[i], user_id_ = Prox, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevRio:srem(Prox.."Rio:Groups",group[i]) 
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevRio:srem(Prox.."Rio:Groups",group[i]) 
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
DevRio:srem(Prox.."Rio:Groups",group[i]) 
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  *لاتوجد مجموعات وهميه*', 1, 'md')   
else
local Proxgp2 = (w + q)
local Proxgp3 = #group - Proxgp2
if q == 0 then
Proxgp2 = ''
else
Proxgp2 = '\n⌔  تم حذف ↫ { '..q..' } مجموعه من البوت'
end
if w == 0 then
Proxgp1 = ''
else
Proxgp1 = '\n⌔  تم حذف ↫ { '..w..' } مجموعه بسبب تنزيل البوت الى عضو'
end
Dev_Rio(msg.chat_id_, msg.id_, 1,'⌔  عدد الكروبات الان ↫ { '..#group..' }'..Proxgp1..Proxgp2..'\n⌔  العدد الحقيقي الان  ↫ ( '..Proxgp3..' ) \n ', 1, 'md')
end end
end,nil)
end
return false
end 
end
--     Source Prox     --
if text and (text == "تفعيل التلقائي" or text == "تفعيل المسح التلقائي" or text == "تفعيل الحذف التلقائي") and Constructor(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل ميزة الحذف التلقائي للميديا'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:CleanNum'..msg.chat_id_,true)  
end
if text and (text == "تعطيل التلقائي" or text == "تعطيل المسح التلقائي" or text == "تعطيل الحذف التلقائي") and Constructor(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الحذف التلقائي للميديا'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:CleanNum'..msg.chat_id_) 
end
if text and (text:match("^تعين عدد المسح (%d+)$") or text:match("^تعيين عدد المسح (%d+)$") or text:match("^تعين عدد الحذف (%d+)$") or text:match("^تعيين عدد الحذف (%d+)$") or text:match("^عدد المسح (%d+)$")) and Constructor(msg) and ChCheck(msg) then
local Num = text:match("تعين عدد المسح (%d+)$") or text:match("تعيين عدد المسح (%d+)$") or text:match("تعين عدد الحذف (%d+)$") or text:match("تعيين عدد الحذف (%d+)$") or text:match("عدد المسح (%d+)$")
if tonumber(Num) < 10 or tonumber(Num) > 1000 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بتحديد عدد اكبر من 10 واصغر من 1000 للحذف التلقائي', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم وضع ↫ *'..Num..'* من الميديا للحذف التلقائي', 1, 'md')
DevRio:set(Prox..'Rio:CleanNum'..msg.chat_id_,Num) 
end end 
if msg and DevRio:get(Prox..'Rio:Lock:CleanNum'..msg.chat_id_) then
if DevRio:get(Prox..'Rio:CleanNum'..msg.chat_id_) then CleanNum = DevRio:get(Prox..'Rio:CleanNum'..msg.chat_id_) else CleanNum = 200 end
if DevRio:scard(Prox.."Rio:cleanernum"..msg.chat_id_) >= tonumber(CleanNum) then 
local List = DevRio:smembers(Prox.."Rio:cleanernum"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
SendText(msg.chat_id_,"⌔  تم حذف "..Del.." من الميديا تلقائيا",0,'md') 
DevRio:del(Prox.."Rio:cleanernum"..msg.chat_id_)
end 
end
if CleanerNum(msg) then
if DevRio:get(Prox..'Rio:Lock:CleanNum'..msg.chat_id_) then 
if text == "التلقائي" and ChCheck(msg) or text == "عدد التلقائي" and ChCheck(msg) then 
local M = DevRio:scard(Prox.."Rio:cleanernum"..msg.chat_id_)
if M ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عدد الميديا ↫ "..M.."\n⌔  الحذف التلقائي ↫ "..(DevRio:get(Prox..'Rio:CleanNum'..msg.chat_id_) or 200), 1, 'md') 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتوجد ميديا هنا", 1, 'md') 
end end
end
end
if text == "تفعيل القران" and Manager(msg) and ChCheck(msg) or text == "تفعيل الالقران" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔ اهلا عزيزي ↫ '..AbsRank(msg)..' \n⌔ تم تفعيل الالقران'
absmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(DevProx..'Rio:memz:Rio'..msg.chat_id_) 
end
if text == "تعطيل القران" and Manager(msg) and ChCheck(msg) or text == "تعطيل الالقران" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔ اهلا عزيزي ↫ '..AbsRank(msg)..' \n⌔ تم تعطيل الالقران'
absmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:memz:Rio'..msg.chat_id_,true)  
end
if text and (text == "القران" or text == "قران") and not DevRio:get(DevProx..'Rio:memz:Rio'..msg.chat_id_) and ChCheck(msg) then
Abs = math.random(2,1201); 
local Text ='*⌔ تم اختيار أيهّ من القران لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/DFDFGQRAN/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل امسح" and Constructor(msg) and ChCheck(msg) then
local ProxTEAM = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل امسح بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTEAM, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Clean'..msg.chat_id_,true)  
end
if text == "تعطيل امسح" and Constructor(msg) and ChCheck(msg) then
local ProxTEAM = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل امسح بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTEAM, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Clean'..msg.chat_id_) 
end
if Cleaner(msg) then
if DevRio:get(Prox..'Rio:Lock:Clean'..msg.chat_id_) then 
if text == "الميديا" and ChCheck(msg) or text == "عدد الميديا" and ChCheck(msg) then 
local M = DevRio:scard(Prox.."Rio:cleaner"..msg.chat_id_)
if M ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  عدد الميديا ↫ "..M, 1, 'md') 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتوجد ميديا هنا", 1, 'md') 
end end
if text == "امسح" and ChCheck(msg) or text == "احذف" and ChCheck(msg) or text == "تنظيف ميديا" and ChCheck(msg) or text == "تنظيف الميديا" and ChCheck(msg) then
local List = DevRio:smembers(Prox.."Rio:cleaner"..msg.chat_id_)
local Del = 0
for k,v in pairs(List) do
Del = (Del + 1)
local Message = v
DeleteMessage(msg.chat_id_,{[0]=Message})
end
if Del ~= 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف "..Del.." من الميديا", 1, 'md') 
DevRio:del(Prox.."Rio:cleaner"..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتوجد ميديا هنا", 1, 'md') 
end end 
end
end
--     Source Prox     --
if Admin(msg) then
if text == "تنظيف تعديل" and ChCheck(msg) or text == "تنظيف التعديل" and ChCheck(msg) then   
Rio_Del = {[0]= msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Rio_Del[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Rio_Del},function(arg,data)
new = 0
Rio_Del2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Rio_Del2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Rio_Del2)
end,nil)  
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تنظيف 100 من الرسائل المعدله', 1, 'md')
end
--     Source Prox     --
if ChatType == 'sp' or ChatType == 'gp'  then
if Admin(msg) then
if text and text:match("^فتح (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(فتح) (.*)$")}
if UnLockText[2] == "التعديل" then
if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح التعديل")  
DevRio:del(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التعديل بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "التعديل الميديا" or UnLockText[2] == "تعديل الميديا" then
if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح تعديل الميديا")  
DevRio:del(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تعديل الميديا بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفارسيه" then
if DevRio:get(Prox..'Rio:Lock:Farsi'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الفارسيه")  
DevRio:del(Prox..'Rio:Lock:Farsi'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفارسيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفشار" then
if not DevRio:get(Prox..'Rio:Lock:Fshar'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الفشار")  
DevRio:set(Prox..'Rio:Lock:Fshar'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفشار بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الطائفيه" then
if not DevRio:get(Prox..'Rio:Lock:Taf'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الطائفيه")  
DevRio:set(Prox..'Rio:Lock:Taf'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الطائفيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الكفر" then
if not DevRio:get(Prox..'Rio:Lock:Kfr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الكفر")  
DevRio:set(Prox..'Rio:Lock:Kfr'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الكفر بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفارسيه بالطرد" then
if DevRio:get(Prox..'Rio:Lock:FarsiBan'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الفارسيه بالطرد")  
DevRio:del(Prox..'Rio:Lock:FarsiBan'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفارسيه بالطرد بالفعل مفتوحه', 1, 'md')
end
end
if UnLockText[2] == "البوتات" or UnLockText[2] == "البوتات بالطرد" or UnLockText[2] == "البوتات بالتقييد" or UnLockText[2] == "البوتات بالتقيد" then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح البوتات")  
DevRio:del(Prox.."Rio:Lock:Bots"..msg.chat_id_)  
end
if UnLockText[2] == "التكرار" then 
DevRio:hdel(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User")  
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح التكرار")  
end
if BasicConstructor(msg) then
if UnLockText[2] == "التثبيت" then
if DevRio:get(Prox..'Rio:Lock:Pin'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح التثبيت")  
DevRio:del(Prox..'Rio:Lock:Pin'..msg.chat_id_)
DevRio:srem(Prox.."Rio:Lock:Pinpin",msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التثبيت بالفعل مفتوح في المجموعه', 1, 'md')
end end end
end
end
--     Source Prox     --
if Admin(msg) then
if text and text:match("^قفل (.*)$") and ChCheck(msg) then
local LockText = {string.match(text, "^(قفل) (.*)$")}
if LockText[2] == "الدردشه" then
if not DevRio:get(Prox..'Rio:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الدردشه")  
DevRio:set(Prox..'Rio:Lock:Text'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الدردشه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاونلاين" then
if not DevRio:get(Prox..'Rio:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الاونلاين")  
DevRio:set(Prox..'Rio:Lock:Inline'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاونلاين بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الصور" then
if not DevRio:get(Prox..'Rio:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الصور")  
DevRio:set(Prox..'Rio:Lock:Photo'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الصور بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الكلايش" then
if not DevRio:get(Prox..'Rio:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الكلايش")  
DevRio:set(Prox..'Rio:Lock:Spam'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الكلايش بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الدخول" then
if not DevRio:get(Prox..'Rio:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الدخول")  
DevRio:set(Prox..'Rio:Lock:Join'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الدخول بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الفيديو" then
if not DevRio:get(Prox..'Rio:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الفيديو")  
DevRio:set(Prox..'Rio:Lock:Videos'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفيديو بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "المتحركه" then
if not DevRio:get(Prox..'Rio:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل المتحركه")  
DevRio:set(Prox..'Rio:Lock:Gifs'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المتحركه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاغاني" then
if not DevRio:get(Prox..'Rio:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الاغاني")  
DevRio:set(Prox..'Rio:Lock:Music'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاغاني بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الصوت" then
if not DevRio:get(Prox..'Rio:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الصوت")  
DevRio:set(Prox..'Rio:Lock:Voice'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الصوت بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الروابط" then
if not DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الروابط")  
DevRio:set(Prox..'Rio:Lock:Links'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الروابط بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "المواقع" then
if not DevRio:get(Prox..'Rio:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل المواقع")  
DevRio:set(Prox..'Rio:Lock:Location'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المواقع بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "المعرف" or LockText[2] == "المعرفات" then
if not DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل المعرفات")  
DevRio:set(Prox..'Rio:Lock:Tags'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المعرفات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الملفات" then
if not DevRio:get(Prox..'Rio:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الملفات")  
DevRio:set(Prox..'Rio:Lock:Document'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الملفات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الهاشتاك" or LockText[2] == "التاك" then
if not DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الهاشتاك")  
DevRio:set(Prox..'Rio:Lock:Hashtak'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الهاشتاك بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الجهات" then
if not DevRio:get(Prox..'Rio:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الجهات")  
DevRio:set(Prox..'Rio:Lock:Contact'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '️⌔  الجهات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الشبكات" then
if not DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الشبكات")  
DevRio:set(Prox..'Rio:Lock:WebLinks'..msg.chat_id_,true) 
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الشبكات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "العربيه" then
if not DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل العربيه")  
DevRio:set(Prox..'Rio:Lock:Arabic'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العربيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الانكليزيه" then
if not DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الانكليزيه")  
DevRio:set(Prox..'Rio:Lock:English'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الانكليزيه بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الملصقات" then
if not DevRio:get(Prox..'Rio:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الملصقات")  
DevRio:set(Prox..'Rio:Lock:Stickers'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الملصقات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "الماركداون" then
if not DevRio:get(Prox..'Rio:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الماركداون")  
DevRio:set(Prox..'Rio:Lock:Markdown'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الماركداون بالفعل مقفل في المجموعه', 1, 'md')
end
end
if LockText[2] == "الاشعارات" then
if not DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل الاشعارات")  
DevRio:set(Prox..'Rio:Lock:TagServr'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاشعارات بالفعل مقفله في المجموعه', 1, 'md')
end
end
if LockText[2] == "التوجيه" then
if not DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التوجيه")  
DevRio:set(Prox..'Rio:Lock:Forwards'..msg.chat_id_,true)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التوجيه بالفعل مقفل في المجموعه', 1, 'md')
end
end
end
end
--     Source Prox     --
if Admin(msg) then
if text and text:match("^فتح (.*)$") and ChCheck(msg) then
local UnLockText = {string.match(text, "^(فتح) (.*)$")}
if UnLockText[2] == "الدردشه" then
if DevRio:get(Prox..'Rio:Lock:Text'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الدردشه")  
DevRio:del(Prox..'Rio:Lock:Text'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الدردشه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الصور" then
if DevRio:get(Prox..'Rio:Lock:Photo'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الصور")  
DevRio:del(Prox..'Rio:Lock:Photo'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الصور بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الكلايش" then
if DevRio:get(Prox..'Rio:Lock:Spam'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الكلايش")  
DevRio:del(Prox..'Rio:Lock:Spam'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الكلايش بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الدخول" then
if DevRio:get(Prox..'Rio:Lock:Join'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الدخول")  
DevRio:del(Prox..'Rio:Lock:Join'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الدخول بالفعل مفتوح في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الفيديو" then
if DevRio:get(Prox..'Rio:Lock:Videos'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الفيديو")  
DevRio:del(Prox..'Rio:Lock:Videos'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الفيديو بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الملفات" then
if DevRio:get(Prox..'Rio:Lock:Document'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الملفات")  
DevRio:del(Prox..'Rio:Lock:Document'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الملفات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاونلاين" then
if DevRio:get(Prox..'Rio:Lock:Inline'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الاونلاين")  
DevRio:del(Prox..'Rio:Lock:Inline'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاونلاين بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الماركداون" then
if DevRio:get(Prox..'Rio:Lock:Markdown'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الماركداون")  
DevRio:del(Prox..'Rio:Lock:Markdown'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الماركداون بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المتحركه" then
if DevRio:get(Prox..'Rio:Lock:Gifs'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح المتحركه")  
DevRio:del(Prox..'Rio:Lock:Gifs'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المتحركه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاغاني" then
if DevRio:get(Prox..'Rio:Lock:Music'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الاغاني")  
DevRio:del(Prox..'Rio:Lock:Music'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاغاني بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الصوت" then
if DevRio:get(Prox..'Rio:Lock:Voice'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الصوت")  
DevRio:del(Prox..'Rio:Lock:Voice'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الصوت بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الروابط" then
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الروابط")  
DevRio:del(Prox..'Rio:Lock:Links'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الروابط بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المواقع" then
if DevRio:get(Prox..'Rio:Lock:Location'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح المواقع")  
DevRio:del(Prox..'Rio:Lock:Location'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المواقع بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "المعرف" or UnLockText[2] == "المعرفات" then
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح المعرفات")  
DevRio:del(Prox..'Rio:Lock:Tags'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المعرفات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الهاشتاك" or UnLockText[2] == "التاك" then
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الهاشتاك")  
DevRio:del(Prox..'Rio:Lock:Hashtak'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الهاشتاك بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الجهات" then
if DevRio:get(Prox..'Rio:Lock:Contact'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الجهات")  
DevRio:del(Prox..'Rio:Lock:Contact'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الجهات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الشبكات" then
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الشبكات")  
DevRio:del(Prox..'Rio:Lock:WebLinks'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الشبكات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "العربيه" then
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح العربيه")  
DevRio:del(Prox..'Rio:Lock:Arabic'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  العربيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الانكليزيه" then
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الانكليزيه")  
DevRio:del(Prox..'Rio:Lock:English'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الانكليزيه بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الاشعارات" then
if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الاشعارات")  
DevRio:del(Prox..'Rio:Lock:TagServr'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الاشعارات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "الملصقات" then
if DevRio:get(Prox..'Rio:Lock:Stickers'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح الملصقات")  
DevRio:del(Prox..'Rio:Lock:Stickers'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  الملصقات بالفعل مفتوحه في المجموعه', 1, 'md')
end
end
if UnLockText[2] == "التوجيه" then
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح التوجيه")  
DevRio:del(Prox..'Rio:Lock:Forwards'..msg.chat_id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  التوجيه بالفعل مفتوح في المجموعه', 1, 'md')
end
end
end
end
--     Source Prox     --
if text and text:match("^قفل التفليش$") or text and text:match("^تفعيل الحمايه القصوى$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمنشئين فقط', 1, 'md')
else
DevRio:set(Prox.."Rio:Lock:Bots"..msg.chat_id_,"del") DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,Lock in pairs(LockList) do
DevRio:set(Prox..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل التفليش")  
end
end
if text and text:match("^فتح التفليش$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمنشئين فقط', 1, 'md')
else
DevRio:hdel(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'Rio:Lock:Links','Rio:Lock:Contact','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks','Rio:Lock:Photo'}
for i,UnLock in pairs(UnLockList) do
DevRio:del(Prox..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح التفليش")  
end
end
--     Source Prox     --
if text and text:match("^قفل الكل$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمنشئين فقط', 1, 'md')
else
DevRio:del(Prox..'Rio:Lock:Fshar'..msg.chat_id_) DevRio:del(Prox..'Rio:Lock:Taf'..msg.chat_id_) DevRio:del(Prox..'Rio:Lock:Kfr'..msg.chat_id_) 
DevRio:set(Prox.."Rio:Lock:Bots"..msg.chat_id_,"del") DevRio:hset(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User","keed") 
LockList ={'Rio:Lock:EditMsgs','Rio:Lock:Farsi','Rio:Lock:TagServr','Rio:Lock:Inline','Rio:Lock:Photo','Rio:Lock:Spam','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:Music','Rio:Lock:Voice','Rio:Lock:Links','Rio:Lock:Location','Rio:Lock:Tags','Rio:Lock:Stickers','Rio:Lock:Markdown','Rio:Lock:Forwards','Rio:Lock:Document','Rio:Lock:Contact','Rio:Lock:Hashtak','Rio:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevRio:set(Prox..Lock..msg.chat_id_,true)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم قفل جميع الاوامر")  
end
end
if text and text:match("^فتح الكل$") and ChCheck(msg) then
if not Constructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمنشئين فقط', 1, 'md')
else
DevRio:set(Prox..'Rio:Lock:Fshar'..msg.chat_id_,true) DevRio:set(Prox..'Rio:Lock:Taf'..msg.chat_id_,true) DevRio:set(Prox..'Rio:Lock:Kfr'..msg.chat_id_,true) DevRio:hdel(Prox.."Rio:Spam:Group:User"..msg.chat_id_ ,"Spam:User") 
UnLockList ={'Rio:Lock:EditMsgs','Rio:Lock:Text','Rio:Lock:Arabic','Rio:Lock:English','Rio:Lock:Join','Rio:Lock:Bots','Rio:Lock:Farsi','Rio:Lock:FarsiBan','Rio:Lock:TagServr','Rio:Lock:Inline','Rio:Lock:Photo','Rio:Lock:Spam','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:Music','Rio:Lock:Voice','Rio:Lock:Links','Rio:Lock:Location','Rio:Lock:Tags','Rio:Lock:Stickers','Rio:Lock:Markdown','Rio:Lock:Forwards','Rio:Lock:Document','Rio:Lock:Contact','Rio:Lock:Hashtak','Rio:Lock:WebLinks'}
for i,UnLock in pairs(UnLockList) do
DevRio:del(Prox..UnLock..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم فتح جميع الاوامر")  
end
end
--     Source Prox     --
if Admin(msg) then
if text and (text:match("^ضع سبام (%d+)$") or text:match("^وضع سبام (%d+)$")) then
local SetSpam = text:match("ضع سبام (%d+)$") or text:match("وضع سبام (%d+)$")
if tonumber(SetSpam) < 40 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  اختر عدد اكبر من 40 حرف ', 1, 'md')
else
DevRio:set(Prox..'Rio:Spam:Text'..msg.chat_id_,SetSpam)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم وضع عدد السبام ↫'..SetSpam, 1, 'md')
end
end
end
--     Source Prox     --
if Manager(msg) then
if text == "فحص" and ChCheck(msg) or text == "فحص البوت" and ChCheck(msg) then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..Prox)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.can_change_info == true then EDT = '✔️' else EDT = '✖️' end
if GetInfo.result.can_delete_messages == true then DEL = '✔️' else DEL = '✖️' end
if GetInfo.result.can_invite_users == true then INV = '✔️' else INV = '✖️' end
if GetInfo.result.can_pin_messages == true then PIN = '✔️' else PIN = '✖️' end
if GetInfo.result.can_restrict_members == true then BAN = '✔️' else BAN = '✖️' end
if GetInfo.result.can_promote_members == true then VIP = '✔️' else VIP = '✖️' end 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  صلاحيات البوت هي ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  حذف الرسائل ↫ '..DEL..'\n⌔  دعوة المستخدمين ↫ '..INV..'\n⌔  حظر المستخدمين ↫ '..BAN..'\n⌔  تثبيت الرسائل ↫ '..PIN..'\n⌔  تغيير المعلومات ↫ '..EDT..'\n⌔  اضافة مشرفين ↫ '..VIP..'\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈', 1, 'md')
end end
if text and text:match("^تغير رد المطور (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المطور (.*)$") 
DevRio:set(Prox.."Rio:SudoBot:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المطور الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد منشئ الاساسي (.*)$") 
DevRio:set(Prox.."Rio:BasicConstructor:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المنشئ الاساسي الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد المنشئ (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المنشئ (.*)$") 
DevRio:set(Prox.."Rio:Constructor:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المنشئ الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد المدير (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المدير (.*)$") 
DevRio:set(Prox.."Rio:Managers:Rd"..msg.chat_id_,Text) 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المدير الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد الادمن (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد الادمن (.*)$") 
DevRio:set(Prox.."Rio:Admins:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد الادمن الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد المميز (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المميز (.*)$") 
DevRio:set(Prox.."Rio:VipMem:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المميز الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد المنظف (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد المنظف (.*)$") 
DevRio:set(Prox.."Rio:Cleaner:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد المنظف الى ↫ "..Text, 1, 'md')
end
if text and text:match("^تغير رد العضو (.*)$") and ChCheck(msg) then
local Text = text:match("^تغير رد العضو (.*)$") 
DevRio:set(Prox.."Rio:mem:Rd"..msg.chat_id_,Text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تغير رد العضو الى ↫ "..Text, 1, 'md')
end
if text == "حذف ردود الرتب" or text == "مسح ردود الرتب" and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف جميع ردود الرتب", 1, 'md')
DevRio:del(Prox.."Rio:mem:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:Cleaner:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:VipMem:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:Admins:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:Managers:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:Constructor:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:BasicConstructor:Rd"..msg.chat_id_)
DevRio:del(Prox.."Rio:SudoBot:Rd"..msg.chat_id_)
end
end
--     Source Prox     --
if text == "كشف البوتات" and ChCheck(msg) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = '⌔  *قائمة البوتات* ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,data) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
ab = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
ab = ' ✯'
end
text = text.."~ [@"..data.username_..']'..ab.."\n"
if #admins == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتوجد بوتات هنا*", 1, 'md')
return false end
if #admins == i then 
local a = '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  *عدد البوتات هنا* ↫ '..n..'\n'
local f = '⌔  *عدد البوتات المرفوعه* ↫ '..t..'\n⌔  *ملاحضه علامة الـ*✯ *تعني ان البوت ادمن في هذه المجموعه*'
Dev_Rio(msg.chat_id_, msg.id_, 1, text..a..f, 1, 'md')
end
end,nil)
end
end,nil)
end
if text == 'حذف البوتات' and ChCheck(msg) or text == 'طرد البوتات' and ChCheck(msg) or text == 'مسح البوتات' and ChCheck(msg) then
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,dp)  
local admins = dp.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if dp.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(Prox) then
ChatKick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *لاتوجد بوتات هنا*", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  *عدد البوتات هنا* ↫ "..c.."\n⌔  *عدد البوتات المرفوعه* ↫ "..x.."\n⌔  *تم طرد* ↫ "..(c - x).." *من البوتات*", 1, 'md')
end 
end,nil)  
end 
--     Source Prox     --
end
--     Source Prox     --
if Admin(msg) then
if text and text:match("^حذف (.*)$") or text and text:match("^مسح (.*)$") and ChCheck(msg) then
local txts = {string.match(text, "^(حذف) (.*)$")}
local txtss = {string.match(text, "^(مسح) (.*)$")}
if Sudo(msg) then
if txts[2] == 'الاساسيين' or txtss[2] == 'الاساسيين' or txts[2] == 'المطورين الاساسيين' or txtss[2] == 'المطورين الاساسيين' then
DevRio:del(Prox..'Rio:RioSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المطورين الاساسيين")  
end
end
if RioSudo(msg) then
if txts[2] == 'الثانويين' or txtss[2] == 'الثانويين' or txts[2] == 'المطورين الثانويين' or txtss[2] == 'المطورين الثانويين' then
DevRio:del(Prox..'Rio:SecondSudo:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المطورين الثانويين")  
end
end
if SecondSudo(msg) then 
if txts[2] == 'المطورين' or txtss[2] == 'المطورين' then
DevRio:del(Prox..'Rio:SudoBot:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المطورين")  
end
if txts[2] == 'قائمه العام' or txtss[2] == 'قائمه العام' then
DevRio:del(Prox..'Rio:BanAll:')
DevRio:del(Prox..'Rio:MuteAll:')
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قائمة العام")  
end
end
if SudoBot(msg) then
if txts[2] == 'المالكين' or txtss[2] == 'المالكين' then
DevRio:del(Prox..'Rio:RioConstructor:'..msg.chat_id_)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,dp) 
local admins = dp.members_
for i=0 , #admins do
if dp.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(Prox.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end 
end  
end,nil)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المالكين")  
end
end
if RioConstructor(msg) then
if txts[2] == 'المنشئين الاساسيين' or txtss[2] == 'المنشئين الاساسيين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المنشئين الاساسيين")  
DevRio:del(Prox..'Rio:BasicConstructor:'..msg.chat_id_)
end
end
if BasicConstructor(msg) then
if txts[2] == 'المنشئين' or txtss[2] == 'المنشئين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المنشئين")  
DevRio:del(Prox..'Rio:Constructor:'..msg.chat_id_)
end end
if Constructor(msg) then
if txts[2] == 'المدراء' or txtss[2] == 'المدراء' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المدراء")  
DevRio:del(Prox..'Rio:Managers:'..msg.chat_id_)
end 
if txts[2] == 'المنظفين' or txtss[2] == 'المنظفين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المنظفين")  
DevRio:del(Prox..'Rio:Cleaner:'..msg.chat_id_)
end end
if Manager(msg) then
if txts[2] == 'الادمنيه' or txtss[2] == 'الادمنيه' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف الادمنيه")  
DevRio:del(Prox..'Rio:Admins:'..msg.chat_id_)
end
end
if txts[2] == 'قوانين' or txtss[2] == 'قوانين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف القوانين")  
DevRio:del(Prox..'Rio:rules'..msg.chat_id_)
end
if txts[2] == 'المطايه' or txtss[2] == 'المطايه' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المطايه")  
DevRio:del(Prox..'User:Donky:'..msg.chat_id_)
end
if txts[2] == 'الرابط' or txtss[2] == 'الرابط' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف رابط المجموعه")  
DevRio:del(Prox.."Rio:Groups:Links"..msg.chat_id_)
end
if txts[2] == 'المميزين' or txtss[2] == 'المميزين' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المميزين")  
DevRio:del(Prox..'Rio:VipMem:'..msg.chat_id_)
end
if txts[2] == 'المكتومين' or txtss[2] == 'المكتومين' then
DevRio:del(Prox..'Rio:Muted:'..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المكتومين")  
end
if txts[2] == 'المقيدين' or txtss[2] == 'المقيدين' then     
local List = DevRio:smembers(Prox..'Rio:Tkeed:'..msg.chat_id_)
for k,v in pairs(List) do   
HTTPS.request("https://api.telegram.org/bot"..TokenBot.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..v.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True") 
DevRio:srem(Prox..'Rio:Tkeed:'..msg.chat_id_, v)
end 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المقيدين")  
end
if txts[2] == 'قائمه المنع' or txtss[2] == 'قائمه المنع' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قائمة المنع")  
DevRio:del(Prox..'Rio:Filters:'..msg.chat_id_)
end
if txts[2] == 'قوائم المنع' or txtss[2] == 'قوائم المنع' then
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قوائم المنع")  
DevRio:del(Prox..'Rio:Filters:'..msg.chat_id_)
DevRio:del(Prox.."Rio:FilterAnimation"..msg.chat_id_)
DevRio:del(Prox.."Rio:FilterPhoto"..msg.chat_id_)
DevRio:del(Prox.."Rio:FilterSteckr"..msg.chat_id_)
end
if txts[2] == 'قائمه منع المتحركات' or txtss[2] == 'قائمه منع المتحركات' then     
DevRio:del(Prox.."Rio:FilterAnimation"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قائمة منع المتحركات")  
end
if txts[2] == 'قائمه منع الصور' or txtss[2] == 'قائمه منع الصور' then     
DevRio:del(Prox.."Rio:FilterPhoto"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قائمة منع الصور")  
end
if txts[2] == 'قائمه منع الملصقات' or txtss[2] == 'قائمه منع الملصقات' then     
DevRio:del(Prox.."Rio:FilterSteckr"..msg.chat_id_)
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف قائمة منع الملصقات")  
end
end
end
--     Source Prox     --
if text and text:match("^حذف القوائم$") and ChCheck(msg) or text and text:match("^مسح القوائم$") and ChCheck(msg) then
if not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمنشئ الاساسي فقط', 1, 'md')
else
DevRio:del(Prox..'Rio:Ban:'..msg.chat_id_) DevRio:del(Prox..'Rio:Admins:'..msg.chat_id_) DevRio:del(Prox..'User:Donky:'..msg.chat_id_) DevRio:del(Prox..'Rio:VipMem:'..msg.chat_id_) DevRio:del(Prox..'Rio:Filters:'..msg.chat_id_) DevRio:del(Prox..'Rio:Muted:'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف ↫ 〈 قائمة المنع • المحظورين • المكتومين • الادمنيه • المميزين • المطايه 〉 بنجاح \n ✓", 1, 'md')
end end
--     Source Prox     --
if text and text:match("^حذف جميع الرتب$") and ChCheck(msg) or text and text:match("^مسح جميع الرتب$") and ChCheck(msg) or text and text:match("^تنزيل جميع الرتب$") and ChCheck(msg) then
if not RioConstructor(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمالكين فقط', 1, 'md')
else
local basicconstructor = DevRio:smembers(Prox..'Rio:BasicConstructor:'..msg.chat_id_)
local constructor = DevRio:smembers(Prox..'Rio:Constructor:'..msg.chat_id_)
local Managers = DevRio:smembers(Prox..'Rio:Managers:'..msg.chat_id_)
local admins = DevRio:smembers(Prox..'Rio:Admins:'..msg.chat_id_)
local vipmem = DevRio:smembers(Prox..'Rio:VipMem:'..msg.chat_id_)
local donky = DevRio:smembers(Prox..'User:Donky:'..msg.chat_id_)
if #basicconstructor ~= 0 then basicconstructort = 'المنشئين الاساسيين • ' else basicconstructort = '' end
if #constructor ~= 0 then constructort = 'المنشئين • ' else constructort = '' end
if #Managers ~= 0 then Managerst = 'المدراء • ' else Managerst = '' end
if #admins ~= 0 then adminst = 'الادمنيه • ' else adminst = '' end
if #vipmem ~= 0 then vipmemt = 'المميزين • ' else vipmemt = '' end
if #donky ~= 0 then donkyt = 'المطايه • ' else donkyt = '' end
if #basicconstructor ~= 0 or #constructor ~= 0 or #Managers ~= 0 or #admins ~= 0 or #vipmem ~= 0 or #donky ~= 0 then 
DevRio:del(Prox..'Rio:BasicConstructor:'..msg.chat_id_)
DevRio:del(Prox..'Rio:Constructor:'..msg.chat_id_)
DevRio:del(Prox..'Rio:Managers:'..msg.chat_id_)
DevRio:del(Prox..'Rio:Admins:'..msg.chat_id_)
DevRio:del(Prox..'Rio:VipMem:'..msg.chat_id_)
DevRio:del(Prox..'User:Donky:'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف جميع الرتب التاليه ↫ 〈 "..basicconstructort..constructort..Managerst..adminst..vipmemt..donkyt.." 〉 بنجاح \n ✓", 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لاتوجد رتب هنا", 1, 'md')
end 
end 
end
--     Source Prox     --
if Admin(msg) then 
if text and text:match("^الاعدادات$") and ChCheck(msg) then
if not DevRio:get(Prox..'Rio:Spam:Text'..msg.chat_id_) then
spam_c = 400
else
spam_c = DevRio:get(Prox..'Rio:Spam:Text'..msg.chat_id_)
end
--     Source Prox     --
if DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_, "Spam:User") == "kick" then     
flood = "بالطرد"     
elseif DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "keed" then     
flood = "بالتقيد"     
elseif DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "mute" then     
flood = "بالكتم"           
elseif DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Spam:User") == "del" then     
flood = "بالحذف"
else     
flood = "مفتوح"     
end
--     Source Prox     --
if DevRio:get(Prox.."Rio:Lock:Bots"..msg.chat_id_) == "del" then
lock_bots = "بالحذف"
elseif DevRio:get(Prox.."Rio:Lock:Bots"..msg.chat_id_) == "ked" then
lock_bots = "بالتقيد"   
elseif DevRio:get(Prox.."Rio:Lock:Bots"..msg.chat_id_) == "kick" then
lock_bots = "بالطرد"    
else
lock_bots = "مفتوحه"    
end
--     Source Prox     --
if DevRio:get(Prox..'Rio:Lock:Text'..msg.chat_id_) then mute_text = 'مقفله' else mute_text = 'مفتوحه'end
if DevRio:get(Prox..'Rio:Lock:Photo'..msg.chat_id_) then mute_photo = 'مقفله' else mute_photo = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Videos'..msg.chat_id_) then mute_video = 'مقفله' else mute_video = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'مقفله' else mute_gifs = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Music'..msg.chat_id_) then mute_music = 'مقفله' else mute_music = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Inline'..msg.chat_id_) then mute_in = 'مقفله' else mute_in = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Voice'..msg.chat_id_) then mute_voice = 'مقفله' else mute_voice = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'مقفله' else mute_edit = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then mute_links = 'مقفله' else mute_links = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Pin'..msg.chat_id_) then lock_pin = 'مقفله' else lock_pin = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'مقفله' else lock_sticker = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'مقفله' else lock_tgservice = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'مقفله' else lock_wp = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'مقفله' else lock_htag = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then lock_tag = 'مقفله' else lock_tag = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Location'..msg.chat_id_) then lock_location = 'مقفله' else lock_location = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Contact'..msg.chat_id_) then lock_contact = 'مقفله' else lock_contact = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then lock_english = 'مقفله' else lock_english = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'مقفله' else lock_arabic = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then lock_forward = 'مقفله' else lock_forward = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Document'..msg.chat_id_) then lock_file = 'مقفله' else lock_file = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Markdown'..msg.chat_id_) then markdown = 'مقفله' else markdown = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Spam'..msg.chat_id_) then lock_spam = 'مقفله' else lock_spam = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Join'..msg.chat_id_) then lock_Join = 'مقفل' else lock_Join = 'مفتوح' end
if DevRio:get(Prox.."Rio:Lock:Welcome"..msg.chat_id_) then send_welcome = 'مقفله' else send_welcome = 'مفتوحه' end
if DevRio:get(Prox..'Rio:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'مفتوح' else lock_fshar = 'مقفل' end
if DevRio:get(Prox..'Rio:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'مفتوح' else lock_kaf = 'مقفل' end
if DevRio:get(Prox..'Rio:Lock:Taf'..msg.chat_id_) then lock_taf = 'مفتوحه' else lock_taf = 'مقفله' end
if DevRio:get(Prox..'Rio:Lock:Farsi'..msg.chat_id_) then lock_farsi = 'مقفله' else lock_farsi = 'مفتوحه' end
local Flood_Num = DevRio:hget(Prox.."Rio:Spam:Group:User"..msg.chat_id_,"Num:Spam") or 5
--     Source Prox     --
local TXTE = "⌔  اعدادات المجموعه ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
.."⌔  الروابط ↫ "..mute_links.."\n"
.."⌔  المعرف ↫ "..lock_tag.."\n"
.."⌔  البوتات ↫ "..lock_bots.."\n"
.."⌔  المتحركه ↫ "..mute_gifs.."\n"
.."⌔  الملصقات ↫ "..lock_sticker.."\n"
.."⌔  الملفات ↫ "..lock_file.."\n"
.."⌔  الصور ↫ "..mute_photo.."\n"
.."⌔  الفيديو ↫ "..mute_video.."\n"
.."⌔  الاونلاين ↫ "..mute_in.."\n"
.."⌔  الدردشه ↫ "..mute_text.."\n"
.."⌔  التوجيه ↫ "..lock_forward.."\n"
.."⌔  الاغاني ↫ "..mute_music.."\n"
.."⌔  الصوت ↫ "..mute_voice.."\n"
.."⌔  الجهات ↫ "..lock_contact.."\n"
.."⌔  الماركداون ↫ "..markdown.."\n"
.."⌔  الهاشتاك ↫ "..lock_htag.."\n"
.."⌔  التعديل ↫ "..mute_edit.."\n"
.."⌔  التثبيت ↫ "..lock_pin.."\n"
.."⌔  الاشعارات ↫ "..lock_tgservice.."\n"
.."⌔  الكلايش ↫ "..lock_spam.."\n"
.."⌔  الدخول ↫ "..lock_Join.."\n"
.."⌔  الشبكات ↫ "..lock_wp.."\n"
.."⌔  المواقع ↫ "..lock_location.."\n"
.."⌔  الفشار ↫ "..lock_fshar.."\n"
.."⌔  الكفر ↫ "..lock_kaf.."\n"
.."⌔  الطائفيه ↫ "..lock_taf.."\n"
.."⌔  العربيه ↫ "..lock_arabic.."\n"
.."⌔  الانكليزيه ↫ "..lock_english.."\n"
.."⌔  الفارسيه ↫ "..lock_farsi.."\n"
.."⌔  التكرار ↫ "..flood.."\n"
.."⌔  عدد التكرار ↫ "..Flood_Num.."\n"
.."⌔  عدد السبام ↫ "..spam_c.."\n"
.."──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  [Source Channel](https://t.me/F_L_3)\n"
Dev_Rio(msg.chat_id_, msg.id_, 1, TXTE, 1, 'md')
end
end
--     Source Prox     --
if text and text:match("^كول (.*)$") and ChCheck(msg) then
local txt = {string.match(text, "^(كول) (.*)$")}
Dev_Rio(msg.chat_id_,0, 1, txt[2], 1, 'md')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end
if text == "تفعيل انطق" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل ميزة انطق'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Antk:Rio'..msg.chat_id_) 
end
if text == "تعطيل انطق" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل ميزة انطق'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Antk:Rio'..msg.chat_id_,true)  
end
if text and text:match("^انطق (.*)$") and not DevRio:get(Prox..'Rio:Antk:Rio'..msg.chat_id_) and ChCheck(msg) then
local UrlAntk = https.request('https://apiabs.ml/Antk.php?abs='..URL.escape(text:match("^انطق (.*)$")))
Antk = JSON.decode(UrlAntk)
if UrlAntk.ok ~= false then
download_to_file("https://translate"..Antk.result.google..Antk.result.code.."UTF-8"..Antk.result.utf..Antk.result.translate.."&tl=ar-IN",Antk.result.translate..'.mp3') 
sendAudio(msg.chat_id_, msg.id_, 0, 1,nil, './'..Antk.result.translate..'.mp3')  
os.execute('rm -rf ./'..Antk.result.translate..'.mp3') 
end
end
--     Source Prox     --
if DevRio:get(Prox..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_) then 
if text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء حفظ قوانين المجموعه', 1, 'md')
DevRio:del(Prox..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
return false  
end 
DevRio:del(Prox..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:rules'..msg.chat_id_,text)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حفظ قوانين المجموعه', 1, 'md')
return false   
end
if text and text:match("^ضع قوانين$") and ChCheck(msg) or text and text:match("^وضع قوانين$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل لي القوانين الان', 1, 'md')
DevRio:set(Prox..'Rio:setrules'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
end
if text and text:match("^القوانين$") and ChCheck(msg) then
local rules = DevRio:get(Prox..'Rio:rules'..msg.chat_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, rules, 1, nil)
end
--     Source Prox     --
if text == 'رقمي' and ChCheck(msg) then
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.phone_number_  then
MyNumber = "⌔  رقمك ↫ +"..result.phone_number_
else
MyNumber = "⌔  رقمك موضوع لجهات اتصالك فقط"
end
send(msg.chat_id_, msg.id_,MyNumber)
end,nil)
end
--     Source Prox     --
if text == "تفعيل الزخرفه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔︙اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔︙تم تفعيل الزخرفه بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Zrf:Rio'..msg.chat_id_) 
end
if text == "تعطيل الزخرفه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔︙اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔︙تم تعطيل الزخرفه بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Zrf:Rio'..msg.chat_id_,true)  
end
if DevRio:get(Prox..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_) then 
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔︙تم الغاء امر الزخرفه', 1, 'md')
DevRio:del(Prox..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_)
return false  
end 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)) 
Zrf = JSON.decode(UrlZrf) 
t = "⌔︙قائمة الزخرفه ↫ ⤈\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'md')
DevRio:del(Prox..'Zrf:Rio'..msg.chat_id_..msg.sender_user_id_)
return false   
end
if not DevRio:get(Prox..'Rio:Zrf:Rio'..msg.chat_id_) then
if text == 'زخرفه' and ChCheck(msg) or text == 'الزخرفه' and ChCheck(msg) then  
DevRio:setex(Prox.."Zrf:Rio"..msg.chat_id_..msg.sender_user_id_,300,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔︙ارسل لي الكلمه لزخرفتها \nيمكنك الزخرفة باللغه { en } ~ { ar } ', 1, 'md')
end
end
if not DevRio:get(Prox..'Rio:Zrf:Rio'..msg.chat_id_) then
if text and text:match("^زخرفه (.*)$") and ChCheck(msg) or text and text:match("^زخرف (.*)$") and ChCheck(msg) then 
local TextZrf = text:match("^زخرفه (.*)$") or text:match("^زخرف (.*)$") 
UrlZrf = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZrf)) 
Zrf = JSON.decode(UrlZrf) 
t = "⌔︙قائمة الزخرفه ↫ ⤈\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
i = 0
for k,v in pairs(Zrf.ok) do
i = i + 1
t = t..i.."~ `"..v.."` \n"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'md')
end
end
--     Source Prox     --
if text == "تفعيل الابراج" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الابراج بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Brg:Rio'..msg.chat_id_) 
end
if text == "تعطيل الابراج" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الابراج بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Brg:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(Prox..'Rio:Brg:Rio'..msg.chat_id_) then
if text and text:match("^برج (.*)$") and ChCheck(msg) or text and text:match("^برجي (.*)$") and ChCheck(msg) then 
local TextBrg = text:match("^برج (.*)$") or text:match("^برجي (.*)$") 
UrlBrg = https.request('https://apiabs.ml/brg.php?brg='..URL.escape(TextBrg)) 
Brg = JSON.decode(UrlBrg) 
t = Brg.ok.abs  
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Prox     --
if text and (text == "تفعيل اوامر النسب" or text == "تفعيل نسبه الحب" or text == "تفعيل نسبه الكره" or text == "تفعيل نسبه الرجوله" or text == "تفعيل نسبه الانوثه" or text == "تفعيل نسبه الغباء") and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل اوامر النسب'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Nsba:Rio'..msg.chat_id_) 
end
if text and (text == "تعطيل اوامر النسب" or text == "تعطيل نسبه الحب" or text == "تعطيل نسبه الكره" or text == "تعطيل نسبه الرجوله" or text == "تعطيل نسبه الانوثه" or text == "تعطيل نسبه الغباء") and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل اوامر النسب'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Nsba:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "نسبه الحب" and ChCheck(msg) or text == "نسبة الحب" and ChCheck(msg) then
DevRio:set(Prox..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسمين لحساب نسبة الحب بينهما كمثال ↫ جاك و روز', 1, 'md')
end
end
if text and text ~= "نسبه الحب" and text ~= "نسبة الحب" and DevRio:get(Prox..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الحب ', 1, 'md')
DevRio:del(Prox..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة الحب بين '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'LoveNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "نسبه الخيانه" and ChCheck(msg) or text == "نسبة الخيانه" and ChCheck(msg) or text == "↫ نسبه الخيانه ⌔" and ChCheck(msg) then
DevRio:set(Prox..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسمين لحساب نسبة الخيانه بينهما كمثال ↫ جاك و روز', 1, 'md')
end
end
if text and text ~= "نسبه الخيانه" and text ~= "نسبة الخيانه" and text ~= "↫ نسبه الخيانه ⌔" and DevRio:get(Prox..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الخيانه ', 1, 'md')
DevRio:del(Prox..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة الخيانه بين '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'RyNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "نسبه الجمال" or text == "نسبة الجمال" or text == "↫ نسبه الجمال ⌔") and ChCheck(msg) then
DevRio:set(Prox..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسم الشخص لقياس نسبة جماله كمثال ↫ جاك او روز', 1, 'md')
end
end
if text and text ~= "نسبه الجمال" and text ~= "نسبة الجمال" and text ~= "↫ نسبه الجمال ⌔" and DevRio:get(Prox..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الجمال ', 1, 'md')
DevRio:del(Prox..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة جمال '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'JNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text == "نسبه الكره" and ChCheck(msg) or text == "نسبة الكره" and ChCheck(msg) or text == "↫ نسبه الكره ⌔" and ChCheck(msg) then
DevRio:set(Prox..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسمين لحساب نسبة الكره بينهما كمثال ↫ جاك و روز', 1, 'md')
end
end
if text and text ~= "نسبه الكره" and text ~= "نسبة الكره" and text ~= "↫ نسبه الكره ⌔" and DevRio:get(Prox..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الكره ', 1, 'md')
DevRio:del(Prox..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة الكره بين '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'HataNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "نسبه الرجوله" or text == "نسبة الرجوله" or text == "نسبه رجوله" or text == "نسبة رجوله" or text == "↫ نسبه الرجوله ⌔") and ChCheck(msg) then
DevRio:set(Prox..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسم الشخص لقياس نسبة رجولته كمثال ↫ جاك', 1, 'md')
end
end
if text and text ~= "نسبه الرجوله" and text ~= "نسبة الرجوله" and text ~= "نسبه رجوله" and text ~= "نسبة رجوله" and text ~= "↫ نسبه الرجوله ⌔" and DevRio:get(Prox..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الرجوله ', 1, 'md')
DevRio:del(Prox..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة رجولة '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'RjolaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "نسبه الانوثه" or text == "نسبة الانوثه" or text == "نسبه انوثه" or text == "نسبة انوثه" or text == "↫ نسبه الانوثه ⌔") and ChCheck(msg) then
DevRio:set(Prox..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسم الشخص لقياس نسبة انوثته كمثال ↫ روز', 1, 'md')
end
end
if text and text ~= "نسبه الانوثه" and text ~= "نسبة الانوثه" and text ~= "نسبه انوثه" and text ~= "نسبة انوثه" and text ~= "↫ نسبه الانوثه ⌔" and DevRio:get(Prox..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الانوثه ', 1, 'md')
DevRio:del(Prox..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة انوثة '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'AnothaNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
if not DevRio:get(Prox..'Rio:Nsba:Rio'..msg.chat_id_) then
if text and (text == "نسبه الغباء" or text == "نسبة الغباء" or text == "↫ نسبه الغباء ⌔") and ChCheck(msg) then
DevRio:set(Prox..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_,true) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  قم بارسل اسم الشخص لقياس نسبة غبائه كمثال ↫ جاك او روز', 1, 'md')
end
end
if text and text ~= "نسبه الغباء" and text ~= "نسبة الغباء" and text ~= "↫ نسبه الغباء ⌔" and DevRio:get(Prox..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) then
if text and text == 'الغاء' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم الغاء امر نسبة الغباء ', 1, 'md')
DevRio:del(Prox..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end 
Rio = math.random(0,100);
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  نسبة غباء '..text..' هي : '..Rio..'%', 1, 'md')
DevRio:del(Prox..'StupidNsba:Rio'..msg.chat_id_..msg.sender_user_id_) 
return false 
end
--     Source Prox     --
if text == "تفعيل حساب العمر" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل حساب العمر'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Age:Rio'..msg.chat_id_) 
end
if text == "تعطيل حساب العمر" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل حساب العمر'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Age:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(Prox..'Rio:Age:Rio'..msg.chat_id_) then
if text and text:match("^احسب (.*)$") and ChCheck(msg) or text and text:match("^عمري (.*)$") and ChCheck(msg) then 
local TextAge = text:match("^احسب (.*)$") or text:match("^عمري (.*)$") 
UrlAge = https.request('https://apiabs.ml/age.php?age='..URL.escape(TextAge)) 
Age = JSON.decode(UrlAge) 
t = Age.ok.abs
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Prox     --
if text == "تفعيل معاني الاسماء" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل معاني الاسماء'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Mean:Rio'..msg.chat_id_) 
end
if text == "تعطيل معاني الاسماء" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل معاني الاسماء'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Mean:Rio'..msg.chat_id_,true)  
end
if not DevRio:get(Prox..'Rio:Mean:Rio'..msg.chat_id_) then
if text and text:match("^معنى الاسم (.*)$") and ChCheck(msg) or text and text:match("^معنى اسم (.*)$") and ChCheck(msg) then 
local TextMean = text:match("^معنى الاسم (.*)$") or text:match("^معنى اسم (.*)$") 
UrlMean = https.request('https://apiabs.ml/Mean.php?Abs='..URL.escape(TextMean)) 
Mean = JSON.decode(UrlMean) 
t = Mean.ok.abs
Dev_Rio(msg.chat_id_, msg.id_, 1, t, 1, 'html')
end
end
--     Source Prox     --
if text == "تفعيل متحركه" and Manager(msg) and ChCheck(msg) or text == "تفعيل المتحركه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل المتحركه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:gif:Rio'..msg.chat_id_) 
end
if text == "تعطيل متحركه" and Manager(msg) and ChCheck(msg) or text == "تعطيل المتحركه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل المتحركه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:gif:Rio'..msg.chat_id_,true)  
end
if text and (text == "متحركه" or text == "↫ متحركه ⌔") and not DevRio:get(Prox..'Rio:gif:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,1075); 
local Text ='*⌔  تم اختيار المتحركه لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendanimation?chat_id=' .. msg.chat_id_ .. '&animation=https://t.me/GifDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل شعبي" and Manager(msg) and ChCheck(msg) or text == "تفعيل شعبيي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔ اهلا عزيزي ↫ '..AbsRank(msg)..' \n⌔︙تم تفعيل شعبي'
absmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:mp3:Abs'..msg.chat_id_) 
end
if text == "تعطيل شعبي" and Manager(msg) and ChCheck(msg) or text == "تعطيل شعبي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔︙اهلا عزيزي ↫ '..AbsRank(msg)..' \n⌔︙تم تعطيل شعبي'
absmoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:mp3:Abs'..msg.chat_id_,true)  
end
if text and (text == "شعبي" or text == "↫ شعبي ⌔" or text == "اغاني") and not DevRio:get(Prox..'Rio:mp3:Abs'..msg.chat_id_) and ChCheck(msg) then
Abs = math.random(2,1167); 
local Text ='*⌔ تم اختيار شعبي شعبي لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/Dndjdieiwqkznxnfn/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل غنيلي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل غنيلي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Audios:Rio'..msg.chat_id_) 
end
if text == "تعطيل غنيلي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل غنيلي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Audios:Rio'..msg.chat_id_,true)  
end
if text == "غنيلي" and ChCheck(msg) then
data,res = https.request('https://devqn.cf/audios.php')
if res == 200 then
Audios = json:decode(data)
if Audios.ok == true then
local Text ='تم اختيار المقطع المصري بنجاح 💘'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Sꪮꪊ𝘳ᥴꫀ  𝅘𝅥𝅮',url="t.me/F_L_3"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(Audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
--     Source Prox     --
if text == "تفعيل الاغاني" and Manager(msg) and ChCheck(msg) or text == "تفعيل اغنيه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الاغاني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:mp3:Rio'..msg.chat_id_) 
end
if text == "تعطيل الاغاني" and Manager(msg) and ChCheck(msg) or text == "تعطيل اغنيه" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الاغاني'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:mp3:Rio'..msg.chat_id_,true)  
end
if text and (text == "اغنيه" or text == "↫ اغنيه ⌔" or text == "اغاني") and not DevRio:get(Prox..'Rio:mp3:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,1167); 
local Text ='*⌔  تم اختيار الاغنيه لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/ProxMp3/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل ريمكس" and Manager(msg) and ChCheck(msg) or text == "تفعيل الريمكس" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الريمكس'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Remix:Rio'..msg.chat_id_) 
end
if text == "تعطيل ريمكس" and Manager(msg) and ChCheck(msg) or text == "تعطيل الريمكس" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الريمكس'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Remix:Rio'..msg.chat_id_,true)  
end
if text and (text == "ريمكس" or text == "↫ ريمكس ⌔") and not DevRio:get(Prox..'Rio:Remix:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,612); 
local Text ='*⌔  تم اختيار الريمكس لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice=https://t.me/RemixDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل صوره" and Manager(msg) and ChCheck(msg) or text == "تفعيل الصوره" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الصوره'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Photo:Rio'..msg.chat_id_) 
end
if text == "تعطيل صوره" and Manager(msg) and ChCheck(msg) or text == "تعطيل الصوره" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الصوره'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Photo:Rio'..msg.chat_id_,true)  
end
if text and (text == "صوره" or text == "↫ صوره ⌔") and not DevRio:get(Prox..'Rio:Photo:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(4,1122); 
local Text ='*⌔  تم اختيار الصوره لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/PhotosDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل انمي" and Manager(msg) and ChCheck(msg) or text == "تفعيل الانمي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الانمي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Anime:Rio'..msg.chat_id_) 
end
if text == "تعطيل انمي" and Manager(msg) and ChCheck(msg) or text == "تعطيل الانمي" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الانمي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Anime:Rio'..msg.chat_id_,true)  
end
if text and (text == "انمي" or text == "↫ انمي ⌔") and not DevRio:get(Prox..'Rio:Anime:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(3,1002); 
local Text ='*⌔  تم اختيار صورة الانمي لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/AnimeDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل فلم" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الافلام'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Movies:Rio'..msg.chat_id_) 
end
if text == "تعطيل فلم" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الافلام'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Movies:Rio'..msg.chat_id_,true)  
end
if text and (text == "فلم" or text == "↫ فلم ⌔") and not DevRio:get(Prox..'Rio:Movies:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(45,125); 
local Text ='*⌔  تم اختيار الفلم لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/MoviesDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if text == "تفعيل مسلسل" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل المسلسلات'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Series:Rio'..msg.chat_id_) 
end
if text == "تعطيل مسلسل" and Manager(msg) and ChCheck(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل المسلسلات'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Series:Rio'..msg.chat_id_,true)  
end
if text and (text == "مسلسل" or text == "↫ مسلسل ⌔") and not DevRio:get(Prox..'Rio:Series:Rio'..msg.chat_id_) and ChCheck(msg) then
Rio = math.random(2,54); 
local Text ='*⌔  تم اختيار المسلسل لك*'
keyboard = {}  
keyboard.inline_keyboard = { 
{{text = '⌔ 𝘚ᑌᖇ𝘚E KEᒪOᗩ .',url="t.me/F_L_3"}},
} 
local msg_id = msg.id_/2097152/0.5 
https.request("https://api.telegram.org/bot"..TokenBot..'/sendphoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/SeriesDavid/'..Rio..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
--     Source Prox     --
if Admin(msg) then
if DevRio:get(Prox..'Rio:LockSettings'..msg.chat_id_) then 
if text == "الروابط" then if DevRio:get(Prox..'Rio:Lock:Links'..msg.chat_id_) then mute_links = 'مقفله' else mute_links = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الروابط ↫ "..mute_links.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "المعرف" or text == "المعرفات" then if DevRio:get(Prox..'Rio:Lock:Tags'..msg.chat_id_) then lock_tag = 'مقفوله' else lock_tag = 'مفتوحه' end local ProxTeam = "\n" .."⌔  المعرف ↫ "..lock_tag.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "المتحركه" or text == "الملصقات المتحركه" then if DevRio:get(Prox..'Rio:Lock:Gifs'..msg.chat_id_) then mute_gifs = 'مقفوله' else mute_gifs = 'مفتوحه' end local ProxTeam = "\n" .."⌔  المتحركه ↫ "..mute_gifs.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الملصقات" then if DevRio:get(Prox..'Rio:Lock:Stickers'..msg.chat_id_) then lock_sticker = 'مقفوله' else lock_sticker = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الملصقات ↫ "..lock_sticker.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الصور" then if DevRio:get(Prox..'Rio:Lock:Photo'..msg.chat_id_) then mute_photo = 'مقفوله' else mute_photo = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الصور ↫ "..mute_photo.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الفيديو" or text == "الفيديوهات" then if DevRio:get(Prox..'Rio:Lock:Videos'..msg.chat_id_) then mute_video = 'مقفوله' else mute_video = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الفيديو ↫ "..mute_video.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الاونلاين" then if DevRio:get(Prox..'Rio:Lock:Inline'..msg.chat_id_) then mute_in = 'مقفل' else mute_in = 'مفتوح' end local ProxTeam = "\n" .."⌔  الاونلاين ↫ "..mute_in.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الدردشه" then if DevRio:get(Prox..'Rio:Lock:Text'..msg.chat_id_) then mute_text = 'مقفله' else mute_text = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الدردشه ↫ "..mute_text.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "التوجيه" or text == "اعاده التوجيه" then if DevRio:get(Prox..'Rio:Lock:Forwards'..msg.chat_id_) then lock_forward = 'مقفل' else lock_forward = 'مفتوح' end local ProxTeam = "\n" .."⌔  التوجيه ↫ "..lock_forward.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الاغاني" then if DevRio:get(Prox..'Rio:Lock:Music'..msg.chat_id_) then mute_music = 'مقفوله' else mute_music = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الاغاني ↫ "..mute_music.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الصوت" or text == "الصوتيات" then if DevRio:get(Prox..'Rio:Lock:Voice'..msg.chat_id_) then mute_voice = 'مقفول' else mute_voice = 'مفتوح' end local ProxTeam = "\n" .."⌔  الصوت ↫ "..mute_voice.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الجهات" or text == "جهات الاتصال" then if DevRio:get(Prox..'Rio:Lock:Contact'..msg.chat_id_) then lock_contact = 'مقفوله' else lock_contact = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الجهات ↫ "..lock_contact.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الماركداون" then if DevRio:get(Prox..'Rio:Lock:Markdown'..msg.chat_id_) then markdown = 'مقفل' else markdown = 'مفتوح' end local ProxTeam = "\n" .."⌔  الماركداون ↫ "..markdown.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الهاشتاك" then if DevRio:get(Prox..'Rio:Lock:Hashtak'..msg.chat_id_) then lock_htag = 'مقفل' else lock_htag = 'مفتوح' end local ProxTeam = "\n" .."⌔  الهاشتاك ↫ "..lock_htag.."\n"Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "التعديل" then if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then mute_edit = 'مقفل' else mute_edit = 'مفتوح' end local ProxTeam = "\n" .."⌔  التعديل ↫ "..mute_edit.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "التثبيت" then if DevRio:get(Prox..'Rio:Lock:Pin'..msg.chat_id_) then lock_pin = 'مقفل' else lock_pin = 'مفتوح' end local ProxTeam = "\n" .."⌔  التثبيت ↫ "..lock_pin.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الاشعارات" then if DevRio:get(Prox..'Rio:Lock:TagServr'..msg.chat_id_) then lock_tgservice = 'مقفوله' else lock_tgservice = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الاشعارات ↫ "..lock_tgservice.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الكلايش" then if DevRio:get(Prox..'Rio:Lock:Spam'..msg.chat_id_) then lock_spam = 'مقفوله' else lock_spam = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الكلايش ↫ "..lock_spam.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الدخول" then if DevRio:get(Prox..'Rio:Lock:Join'..msg.chat_id_) then lock_Join = 'مقفول' else lock_Join = 'مفتوح' end local ProxTeam = "\n" .."⌔  الدخول ↫ "..lock_Join.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الشبكات" then if DevRio:get(Prox..'Rio:Lock:WebLinks'..msg.chat_id_) then lock_wp = 'مقفوله' else lock_wp = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الشبكات ↫ "..lock_wp.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "المواقع" then if DevRio:get(Prox..'Rio:Lock:Location'..msg.chat_id_) then lock_location = 'مقفوله' else lock_location = 'مفتوحه' end local ProxTeam = "\n" .."⌔  المواقع ↫ "..lock_location.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "العربيه" then if DevRio:get(Prox..'Rio:Lock:Arabic'..msg.chat_id_) then lock_arabic = 'مقفوله' else lock_arabic = 'مفتوحه' end local ProxTeam = "\n" .."⌔  العربيه ↫ "..lock_arabic.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الانكليزيه" then if DevRio:get(Prox..'Rio:Lock:English'..msg.chat_id_) then lock_english = 'مقفوله' else lock_english = 'مفتوحه' end local ProxTeam = "\n" .."⌔  الانكليزيه ↫ "..lock_english.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الكفر" then if DevRio:get(Prox..'Rio:Lock:Kfr'..msg.chat_id_) then lock_kaf = 'مفتوح' else lock_kaf = 'مقفل' end local ProxTeam = "\n" .."⌔  الكفر ↫ "..lock_kaf.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الفشار" then if DevRio:get(Prox..'Rio:Lock:Fshar'..msg.chat_id_) then lock_fshar = 'مفتوح' else lock_fshar = 'مقفل' end local ProxTeam = "\n" .."⌔  الفشار ↫ "..lock_fshar.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
if text == "الطائفيه" then if DevRio:get(Prox..'Rio:Lock:Taf'..msg.chat_id_) then lock_taf = 'مفتوحه' else lock_taf = 'مقفله' end local ProxTeam = "\n" .."⌔  الطائفيه ↫ "..lock_taf.."\n" Dev_Rio(msg.chat_id_, msg.id_, 1, ProxTeam, 1, 'md') end
end
--     Source Prox     --
if text == 'تفعيل كشف الاعدادات' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل كشف الاعدادات'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:LockSettings'..msg.chat_id_,true)  
end
if text == 'تعطيل كشف الاعدادات' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل كشف الاعدادات'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:LockSettings'..msg.chat_id_) 
end
--     Source Prox     --
if text == 'تفعيل اوامر التحشيش' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل اوامر التحشيش'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Stupid'..msg.chat_id_)
end
if text == 'تعطيل اوامر التحشيش' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل اوامر التحشيش'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Stupid'..msg.chat_id_,true)
end
--     Source Prox     --
if text and (text == 'تعطيل التحقق' or text == 'قفل التحقق' or text == 'تعطيل تنبيه الدخول') and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل التحقق بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Robot'..msg.chat_id_)
end
if text and (text == 'تفعيل التحقق' or text == 'فتح التحقق' or text == 'تفعيل تنبيه الدخول') and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل التحقق بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Robot'..msg.chat_id_,true)
end
--     Source Prox     --
if text == 'تفعيل ردود المدير' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل ردود المدير'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:GpRed'..msg.chat_id_)
end
if text == 'تعطيل ردود المدير' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل ردود المدير'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:GpRed'..msg.chat_id_,true)
end
--     Source Prox     --
if text == 'تفعيل ردود المطور' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل ردود المطور'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:AllRed'..msg.chat_id_)
end
if text == 'تعطيل ردود المطور' and Manager(msg) and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل ردود المطور'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:AllRed'..msg.chat_id_,true)
end
--     Source Prox     --
if SecondSudo(msg) then
if text == 'تفعيل المغادره' or text == '↫ تفعيل المغادره ⌔' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل المغادره بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Left:Bot"..Prox)
end
if text == 'تعطيل المغادره' or text == '↫ تعطيل المغادره ⌔' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل المغادره بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Left:Bot"..Prox,true) 
end 
if text == 'تفعيل الاذاعه' or text == '↫ تفعيل الاذاعه ⌔' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الاذاعه بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Send:Bot"..Prox)
end
if text == 'تعطيل الاذاعه' or text == '↫ تعطيل الاذاعه ⌔' and ChCheck(msg) then 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الاذاعه بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Send:Bot"..Prox,true) 
end
end
--     Source Prox     --
if text and text:match("^ضع اسم (.*)$") and Manager(msg) and ChCheck(msg) then
local txt = {string.match(text, "^(ضع اسم) (.*)$")}
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = txt[2] },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⌔  البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔  ليست لدي صلاحية تغير معلومات المجموعه يرجى التحقق من الصلاحيات")  
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تغير اسم المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
end,nil) 
end
--     Source Prox     --
if msg.content_.photo_ then
if DevRio:get(Prox..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_) then
if msg.content_.photo_.sizes_[3] then
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,"⌔  عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا") 
DevRio:del(Prox..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,"⌔  ليست لدي صلاحية تغير معلومات المجموعه يرجى التحقق من الصلاحيات") 
DevRio:del(Prox..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
else
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تغير صورة المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end
end,nil) 
DevRio:del(Prox..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_)
end 
end
if text and text:match("^ضع صوره$") and ChCheck(msg) or text and text:match("^وضع صوره$") and ChCheck(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, '⌔  ارسل صورة المجموعه الان', 1, 'md')
DevRio:set(Prox..'Rio:SetPhoto'..msg.chat_id_..':'..msg.sender_user_id_,true)
end
--     Source Prox     --
if text and text:match("^حذف الصوره$") and ChCheck(msg) or text and text:match("^مسح الصوره$") and ChCheck(msg) then
https.request("https://api.telegram.org/bot"..TokenBot.."/deleteChatPhoto?chat_id="..msg.chat_id_) 
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف صورة المجموعه")  
return false  
end
--     Source Prox     --
if Manager(msg) then
if text and text:match("^الغاء تثبيت$") and ChCheck(msg) or text and text:match("^الغاء التثبيت$") and ChCheck(msg) then
if DevRio:sismember(Prox.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "⌔  التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
DevRio:del(Prox..'Rio:PinnedMsg'..msg.chat_id_)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم الغاء تثبيت الرساله'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⌔  انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔  ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
return false  
end
end,nil)
end
--     Source Prox     --
if text and text:match("^الغاء تثبيت الكل$") and ChCheck(msg) then  
if DevRio:sismember(Prox.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "⌔  التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
if data.ID == "Ok" then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم الغاء تثبيت الكل'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
https.request('https://api.telegram.org/bot'..TokenBot..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
DevRio:del(Prox.."Rio:PinnedMsg"..msg.chat_id_)
return false  
end
if data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⌔  انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
return false  
end
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⌔  ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
return false  
end
end,nil)
end
--     Source Prox     --
if text and text:match("^اعاده تثبيت$") and ChCheck(msg) or text and text:match("^اعاده التثبيت$") and ChCheck(msg) or text and text:match("^اعادة التثبيت$") and ChCheck(msg) then
if DevRio:sismember(Prox.."Rio:Lock:Pinpin",msg.chat_id_) and not BasicConstructor(msg) then
Dev_Rio(msg.chat_id_,msg.id_, 1, "⌔  التثبيت والغاء واعادة التثبيت تم قفله من قبل المنشئين الاساسيين", 1, 'md')
return false  
end
local PinId = DevRio:get(Prox..'Rio:PinnedMsg'..msg.chat_id_)
if PinId then
Pin(msg.chat_id_,PinId,0)
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم اعادة تثبيت الرساله'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end end
end
--     Source Prox     --
if text == 'طرد المحذوفين' and ChCheck(msg) or text == 'مسح المحذوفين' and ChCheck(msg) or text == 'طرد الحسابات المحذوفه' and ChCheck(msg) or text == 'حذف المحذوفين' and ChCheck(msg) then  
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
ChatKick(msg.chat_id_, data.id_)
end
end,nil)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم طرد المحذوفين")  
end,nil)
end
--     Source Prox     --
if text and text:match("^مسح المحظورين$") or text and text:match("^حذف المحظورين$") and ChCheck(msg) or text and text:match("^مسح المطرودين$") or text and text:match("^حذف المطرودين$") and ChCheck(msg) then
local function RemoveBlockList(extra, result)
if tonumber(result.total_count_) == 0 then 
Dev_Rio(msg.chat_id_, msg.id_, 0,'⌔  *لا يوجد محظورين*', 1, 'md')
DevRio:del(Prox..'Rio:Ban:'..msg.chat_id_)
else
local x = 0
for x,y in pairs(result.members_) do
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatusLeft" }, }, dl_cb, nil)
DevRio:del(Prox..'Rio:Ban:'..msg.chat_id_)
x = x + 1
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف المحظورين")  
end
end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, RemoveBlockList, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
end
end
--     Source Prox     --
if text and text:match("^معلومات المجموعه$") and ChCheck(msg) or text and text:match("^عدد الاعضاء$") and ChCheck(msg) or text and text:match("^عدد الكروب$") and ChCheck(msg) or text and text:match("^عدد الادمنيه$") and ChCheck(msg) or text and text:match("^عدد المحظورين$") and ChCheck(msg) then
local Muted = DevRio:scard(Prox.."Rio:Muted:"..msg.chat_id_) or "0"
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub("-100","")},function(arg,data) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه ↫ 〈 '..dp.title_..' 〉\n⌔  الايدي ↫ 〈 '..msg.chat_id_..' 〉\n⌔  عدد الاعضاء ↫ 〈 *'..data.member_count_..'* 〉\n⌔  عدد الادمنيه ↫ 〈 *'..data.administrator_count_..'* 〉\n⌔  عدد المطرودين ↫ 〈 *'..data.kicked_count_..'* 〉\n⌔  عدد المكتومين ↫ 〈 *'..Muted..'* 〉\n⌔  عدد رسائل المجموعه ↫ 〈 *'..(msg.id_/2097152/0.5)..'* 〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n', 1, 'md') 
end,nil)
end,nil)
end
--     Source Prox     --
if text and text:match('^كشف (-%d+)') and ChCheck(msg) then
local ChatId = text:match('كشف (-%d+)') 
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطورين فقط', 1, 'md')
else
local ConstructorList = DevRio:scard(Prox.."Rio:Constructor:"..ChatId) or 0
local BanedList = DevRio:scard(Prox.."Rio:Ban:"..ChatId) or 0
local ManagerList = DevRio:scard(Prox.."Rio:Managers:"..ChatId) or 0
local MutedList = DevRio:scard(Prox.."Rio:Muted:"..ChatId) or 0
local TkeedList = DevRio:scard(Prox.."Rio:Rio:Tkeed:"..ChatId) or 0
local AdminsList = DevRio:scard(Prox.."Rio:Admins:"..ChatId) or 0
local VipList = DevRio:scard(Prox.."Rio:VipMem:"..ChatId) or 0
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..ChatId))
if LinkGp.ok == true then LinkGroup = LinkGp.result else LinkGroup = 't.me/F_L_3' end
tdcli_function({ID ="GetChat",chat_id_=ChatId},function(arg,dp)
tdcli_function ({ID = "GetChannelMembers",channel_id_ = ChatId:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
if dp.id_ then
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,Rio) 
if Rio.first_name_ ~= false then
ConstructorRio = "["..Rio.first_name_.."](T.me/"..(Rio.username_ or "F_L_3")..")"
else 
ConstructorRio = "حساب محذوف"
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  المجموعه ↫ ["..dp.title_.."]("..LinkGroup..")\n⌔  الايدي ↫ ( `"..ChatId.."` )\n⌔  المنشئ ↫ "..ConstructorRio.."\n⌔  عدد المدراء ↫ ( *"..ManagerList.."* )\n⌔  عدد المنشئين ↫ ( *"..ConstructorList.."* )\n⌔  عدد الادمنيه ↫ ( *"..AdminsList.."* )\n⌔  عدد المميزين ↫ ( *"..VipList.."* )\n⌔  عدد المحظورين ↫ ( *"..BanedList.."* )\n⌔  عدد المقيدين ↫ ( *"..TkeedList.."* )\n⌔  عدد المكتومين ↫ ( *"..MutedList.."* )", 1,"md")
end,nil)
end
end
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لم تتم اضافتي بها لاقوم بكشفها", 1, "md")
end
end,nil)
end,nil)
end 
end
--     Source Prox     --
if text and text:match("^غادر (-%d+)$") and ChCheck(msg) then
local Text = { string.match(text, "^(غادر) (-%d+)$")}
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط', 1, 'md')
else 
tdcli_function({ID ="GetChat",chat_id_=Text[2]},function(arg,dp) 
if dp.id_ then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  المجموعه ↫ ["..dp.title_.."]\n⌔  تمت المغادره منها بنجاح", 1, "md")
Dev_Rio(Text[2], 0, 1, "⌔  بامر المطور تم مغادرة هذه المجموعه ", 1, "md")  
ChatLeave(dp.id_, Prox)
DevRio:srem(Prox.."Rio:Groups", dp.id_)
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لم تتم اضافتي بها لاقوم بمغادرتها", 1, "md")
end 
end,nil)
end 
end
--     Source Prox     --
if text and text:match("^تعين عدد الاعضاء (%d+)$") and SecondSudo(msg) or text and text:match("^تعيين عدد الاعضاء (%d+)$") and SecondSudo(msg) then
local Num = text:match("تعين عدد الاعضاء (%d+)$") or text:match("تعيين عدد الاعضاء (%d+)$")
DevRio:set(Prox..'Rio:Num:Add:Bot',Num) 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم وضع عدد الاعضاء ↫ *'..Num..'* عضو', 1, 'md')
end
--     Source Prox     --
if text == 'تفعيل البوت الخدمي' and ChCheck(msg) or text == '↫ تفعيل البوت الخدمي ⌔' and ChCheck(msg) then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط', 1, 'md')
else 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل البوت الخدمي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:FreeBot'..Prox) 
end 
end
if text == 'تعطيل البوت الخدمي' and ChCheck(msg) or text == '↫ تعطيل البوت الخدمي ⌔' and ChCheck(msg) then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط', 1, 'md')
else 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل البوت الخدمي'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:FreeBot'..Prox,true) 
end 
end
if ChatType == 'sp' or ChatType == 'gp'  then
if text == 'تعطيل صورتي' and Manager(msg) and ChCheck(msg) then   
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل صورتي بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Photo:Profile'..msg.chat_id_) 
end
if text == 'تفعيل صورتي' and Manager(msg) and ChCheck(msg) then  
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل صورتي بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Photo:Profile'..msg.chat_id_,true)  
end
if text == 'تفعيل الالعاب' and Manager(msg) and ChCheck(msg) or text == 'تفعيل اللعبه' and Manager(msg) and ChCheck(msg) then   
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الالعاب بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Games'..msg.chat_id_) 
end
if text == 'تعطيل الالعاب' and Manager(msg) and ChCheck(msg) or text == 'تعطيل اللعبه' and Manager(msg) and ChCheck(msg) then  
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الالعاب بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Games'..msg.chat_id_,true)  
end
if text == 'تفعيل الالعاب المتطوره' and Manager(msg) and ChCheck(msg) or text == 'تفعيل الالعاب الاحترافيه' and Manager(msg) and ChCheck(msg) then   
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل الالعاب المتطوره بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox..'Rio:Lock:Gamesinline'..msg.chat_id_) 
end
if text == 'تعطيل الالعاب المتطوره' and Manager(msg) and ChCheck(msg) or text == 'تعطيل الالعاب الاحترافيه' and Manager(msg) and ChCheck(msg) then  
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل الالعاب المتطوره بنجاح'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox..'Rio:Lock:Gamesinline'..msg.chat_id_,true)  
end
if text == "تفعيل الرابط" and ChCheck(msg) or text == "تفعيل جلب الرابط" and ChCheck(msg) then 
if Admin(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل جلب رابط المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Lock:GpLinks"..msg.chat_id_)
return false  
end
end
if text == "تعطيل الرابط" and ChCheck(msg) or text == "تعطيل جلب الرابط" and ChCheck(msg) then 
if Admin(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل جلب رابط المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Lock:GpLinks"..msg.chat_id_,"ok")
return false  
end
end
if text == "تفعيل حذف الردود" and ChCheck(msg) or text == "تفعيل مسح الردود" and ChCheck(msg) then 
if RioConstructor(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل حذف ردود المدير'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Lock:Rd"..msg.chat_id_)
return false  
end
end
if text == "تعطيل الرابط انلاين" and ChCheck(msg) or text == "تعطيل جلب الرابط انلاين" and ChCheck(msg) then 
if Admin(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل جلب رابط انلاين المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Lock:GpLinksinline"..msg.chat_id_,"ok")
return false  
end
end
if text == "تفعيل الرابط انلاين" and ChCheck(msg) or text == "تفعيل جلب الرابط انلاين" and ChCheck(msg) then 
if Admin(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل جلب رابط انلاين المجموعه'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Lock:GpLinksinline"..msg.chat_id_)
return false  
end
end
if text == "تعطيل حذف الردود" and ChCheck(msg) or text == "تعطيل مسح الردود" and ChCheck(msg) then 
if RioConstructor(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل حذف ردود المدير'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Lock:Rd"..msg.chat_id_,true)
return false  
end
end
if text == "تفعيل اضف رد" and ChCheck(msg) or text == "تفعيل اضافه رد" and ChCheck(msg) then 
if RioConstructor(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تفعيل اضف رد'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:del(Prox.."Rio:Lock:Rd"..msg.chat_id_)
return false  
end
end
if text == "تعطيل اضف رد" and ChCheck(msg) or text == "تعطيل اضافه رد" and ChCheck(msg) then 
if RioConstructor(msg) then
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم تعطيل اضف رد'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
DevRio:set(Prox.."Rio:Lock:Rd"..msg.chat_id_,true)
return false  
end
end
--     Source Prox     --
if text and text:match('^تفعيل$') and SudoBot(msg) and ChCheck(msg) then
if ChatType ~= 'sp' then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه عاديه وليست خارقه لا تستطيع تفعيلي يرجى ان تضع سجل رسائل المجموعه ضاهر وليس مخفي ومن بعدها يمكنك رفعي ادمن ثم تفعيلي', 1, 'md')
return false
end
if msg.can_be_deleted_ == false then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  البوت ليس ادمن يرجى ترقيتي !', 1, 'md')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
if tonumber(data.member_count_) < tonumber(DevRio:get(Prox..'Rio:Num:Add:Bot') or 0) and not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  عدد اعضاء المجموعه اقل من ↫ *'..(DevRio:get(Prox..'Rio:Num:Add:Bot') or 0)..'* عضو', 1, 'md')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_
for i=0 , #admins do
if rio.members_[i].bot_info_ == false and rio.members_[i].status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
end,nil)
else
DevRio:sadd(Prox..'Rio:Admins:'..msg.chat_id_, admins[i].user_id_)
end
if rio.members_[i].status_.ID == "ChatMemberStatusCreator" then
DevRio:sadd(Prox.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:sadd(Prox.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
DevRio:srem(Prox.."Rio:BasicConstructor:"..msg.chat_id_,admins[i].user_id_)
DevRio:srem(Prox.."Rio:RioConstructor:"..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if DevRio:sismember(Prox..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه بالتاكيد مفعله', 1, 'md')
else
ReplyStatus(msg,result.id_,"ReplyBy","⌔  تم تفعيل المجموعه "..dp.title_)  
DevRio:sadd(Prox.."Rio:Groups",msg.chat_id_)
if not DevRio:get(Prox..'Rio:SudosGp'..msg.sender_user_id_..msg.chat_id_) and not SecondSudo(msg) then 
DevRio:incrby(Prox..'Rio:Sudos'..msg.sender_user_id_,1)
DevRio:set(Prox..'Rio:SudosGp'..msg.sender_user_id_..msg.chat_id_,"rio")
end
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NumMem = data.member_count_
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevRio:set(Prox.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"⌔  تم تفعيل مجموعه جديده ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  بواسطة ↫ "..Name.."\n⌔  اسم المجموعه ↫ ["..NameChat.."]\n⌔  عدد اعضاء المجموعه ↫ 〈 *"..NumMem.."* 〉\n⌔  ايدي المجموعه ↫ ⤈ \n〈 `"..msg.chat_id_.."` 〉\n⌔  رابط المجموعه ↫ ⤈\n〈 ["..LinkGroup.."] 〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الوقت ↫ "..os.date("%I:%M%p").."\n⌔  التاريخ ↫ "..os.date("%Y/%m/%d").."",0,'md')
end
end
end,nil)
end,nil)
end,nil)
end
if text == 'تعطيل' and SudoBot(msg) and ChCheck(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
if not DevRio:sismember(Prox..'Rio:Groups',msg.chat_id_) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  المجموعه بالتاكيد معطله', 1, 'md')
else
ReplyStatus(msg,result.id_,"ReplyBy","⌔  تم تعطيل المجموعه "..dp.title_)  
DevRio:srem(Prox.."Rio:Groups",msg.chat_id_)
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
else
LinkGroup = 'لا يوجد'
end
DevRio:set(Prox.."Rio:Groups:Links"..msg.chat_id_,LinkGroup) 
if not Sudo(msg) then
SendText(DevId,"⌔  تم تعطيل مجموعه جديده ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  بواسطة ↫ "..Name.."\n⌔  اسم المجموعه ↫ ["..NameChat.."]\n⌔  ايدي المجموعه ↫ ⤈ \n〈 `"..msg.chat_id_.."` 〉\n⌔  رابط المجموعه ↫ ⤈\n〈 ["..LinkGroup.."] 〉\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الوقت ↫ "..os.date("%I:%M%p").."\n⌔  التاريخ ↫ "..os.date("%Y/%m/%d").."",0,'md')
end
end
end,nil)
end,nil)
end
end
--     Source Prox     --
if text and text:match("^المطور$") then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
local LinkGp = json:decode(https.request('https://api.telegram.org/bot'..TokenBot..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if LinkGp.ok == true then 
LinkGroup = LinkGp.result
LinkGroup = "⌔  رابط المجموعه ↫ ⤈\n〈 ["..LinkGroup.."] 〉"
else
LinkGroup = '⌔  ليست لدي صلاحية الدعوه لهذه المجموعه !'
end
if not Sudo(msg) then
SendText(DevId,"⌔  هناك من بحاجه الى مساعده ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الشخص ↫ "..Name.."\n⌔  اسم المجموعه ↫ ["..NameChat.."]\n⌔  ايدي المجموعه ↫ ⤈ \n〈 `"..msg.chat_id_.."` 〉\n"..LinkGroup.."\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الوقت ↫ "..os.date("%I:%M%p").."\n⌔  التاريخ ↫ "..os.date("%Y/%m/%d").."",0,'md')
end
end,nil)
end,nil)
end
--     Source Prox     --
if text == 'روابط الكروبات' or text == 'روابط المجموعات' or text == '↫ روابط المجموعات ⌔' then
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
local List = DevRio:smembers(Prox.."Rio:Groups")
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لا توجد مجموعات مفعله', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  جاري ارسال نسخه تحتوي على ↫ '..#List..' مجموعه', 1, 'md')
local Text = "⌔  Source Prox\n⌔  File Bot Groups\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
for k,v in pairs(List) do
local GroupsManagers = DevRio:scard(Prox.."Rio:Managers:"..v) or 0
local GroupsAdmins = DevRio:scard(Prox.."Rio:Admins:"..v) or 0
local Groupslink = DevRio:get(Prox.."Rio:Groups:Links" ..v)
Text = Text..k.." ↬ ⤈ \n⌔  Group ID ↬ "..v.."\n⌔  Group Link ↬ "..(Groupslink or "Not Found").."\n⌔  Group Managers ↬ "..GroupsManagers.."\n⌔  Group Admins ↬ "..GroupsAdmins.."\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
end
local File = io.open('GroupsBot.txt', 'w')
File:write(Text)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './GroupsBot.txt',dl_cb, nil)
io.popen('rm -rf ./GroupsBot.txt')
end
end
end
--     Source Prox     --
if text == "اذاعه خاص" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "↫ اذاعه خاص ⌔" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevRio:setex(Prox.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  ارسل لي سواء ↫ ⤈ \n〈 ملف • ملصق • متحركه • صوره\n • فيديو • بصمه • صوت • رساله 〉\n⌔  للخروج ارسل ↫ ( الغاء ) \n ✓'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(Prox.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevRio:del(Prox.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevRio:smembers(Prox..'Rio:Users') 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اذاعة "..RioText.." بنجاح \n⌔  ‏الى ↫ 〈 "..#List.." 〉 مشترك \n ✓", 1, 'md')
DevRio:del(Prox.."Rio:Send:Pv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Prox     --
if text == "اذاعه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "↫ اذاعه عام ⌔" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevRio:setex(Prox.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  ارسل لي سواء ↫ ⤈ \n〈 ملف • ملصق • متحركه • صوره\n • فيديو • بصمه • صوت • رساله 〉\n⌔  للخروج ارسل ↫ ( الغاء ) \n ✓'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(Prox.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevRio:del(Prox.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
List = DevRio:smembers(Prox..'Rio:Groups') 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اذاعة "..RioText.." بنجاح \n⌔  ‏في ↫ 〈 "..#List.." 〉 مجموعه \n ✓", 1, 'md')
DevRio:del(Prox.."Rio:Send:Gp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Prox     --
if text == "اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "↫ اذاعه عام بالتوجيه ⌔" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevRio:setex(Prox.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  ارسل الرساله الان لتوجيها \n⌔  للخروج ارسل ↫ ( الغاء ) \n ✓'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(Prox.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevRio:del(Prox.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevRio:smembers(Prox..'Rio:Groups')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اذاعة رسالتك بالتوجيه \n⌔  ‏في ↫ 〈 "..#List.." 〉 مجموعه \n ✓", 1, 'md')
DevRio:del(Prox.."Rio:Send:FwdGp"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Prox     --
if text == "اذاعه خاص بالتوجيه" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "↫ اذاعه خاص بالتوجيه ⌔" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevRio:setex(Prox.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  ارسل الرساله الان لتوجيها \n⌔  للخروج ارسل ↫ ( الغاء ) \n ✓'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(Prox.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == 'الغاء' then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevRio:del(Prox.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false  
end 
local List = DevRio:smembers(Prox..'Rio:Users')   
for k,v in pairs(List) do  
tdcli_function({ID="ForwardMessages", chat_id_ = v, from_chat_id_ = msg.chat_id_, message_ids_ = {[0] = msg.id_}, disable_notification_ = 0, from_background_ = 1},function(a,t) end,nil) 
end   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اذاعة رسالتك بالتوجيه \n⌔  ‏الى ↫ 〈 "..#List.." 〉 مشترك \n ✓", 1, 'md')
DevRio:del(Prox.."Rio:Send:FwdPv"..msg.chat_id_..":" .. msg.sender_user_id_) 
end
--     Source Prox     --
if text == "اذاعه بالتثبيت" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) or text == "↫ اذاعه بالتثبيت ⌔" and msg.reply_to_message_id_ == 0 and SudoBot(msg) and ChCheck(msg) then 
if DevRio:get(Prox.."Rio:Send:Bot"..Prox) and not SecondSudo(msg) then 
send(msg.chat_id_, msg.id_,"⌔  الاذاعه معطله من قبل المطور الاساسي")
return false
end
DevRio:setex(Prox.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_, 600, true) 
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  ارسل لي سواء ↫ ⤈ \n〈 ملف • ملصق • متحركه • صوره\n • فيديو • بصمه • صوت • رساله 〉\n⌔  للخروج ارسل ↫ ( الغاء ) \n ✓'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
return false
end 
if DevRio:get(Prox.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) then 
if text == "الغاء" then   
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء امر الاذاعه بنجاح", 1, 'md')
DevRio:del(Prox.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end 
local List = DevRio:smembers(Prox.."Rio:Groups") 
if msg.content_.text_ then
for k,v in pairs(List) do 
RioText = "الرساله"
send(v, 0,"["..msg.content_.text_.."]") 
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(List) do 
RioText = "الصوره"
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
DevRio:set(Prox..'Rio:PinnedMsgs'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(List) do 
RioText = "المتحركه"
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.video_ then
for k,v in pairs(List) do 
RioText = "الفيديو"
sendVideo(v, 0, 0, 1, nil, msg.content_.video_.video_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.video_.video_.persistent_id_)
end 
elseif msg.content_.voice_ then
for k,v in pairs(List) do 
RioText = "البصمه"
sendVoice(v, 0, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.voice_.voice_.persistent_id_)
end 
elseif msg.content_.audio_ then
for k,v in pairs(List) do 
RioText = "الصوت"
sendAudio(v, 0, 0, 1, nil, msg.content_.audio_.audio_.persistent_id_,(msg.content_.caption_ or '')) 
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.audio_.audio_.persistent_id_)
end 
elseif msg.content_.document_ then
for k,v in pairs(List) do 
RioText = "الملف"
sendDocument(v, 0, 0, 1,nil, msg.content_.document_.document_.persistent_id_,(msg.content_.caption_ or ''))    
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.document_.document_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(List) do 
RioText = "الملصق"
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
DevRio:set(Prox..'Rio:PinnedMsgs'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم اذاعة "..RioText.." بالتثبيت \n⌔  ‏في ↫ 〈 "..#List.." 〉 مجموعه \n ✓", 1, 'md')
DevRio:del(Prox.."Rio:Send:Gp:Pin"..msg.chat_id_..":" .. msg.sender_user_id_) 
return false
end
--     Source Prox     --
if text == 'حذف رد من متعدد' and Manager(msg) and ChCheck(msg) or text == 'مسح رد من متعدد' and Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(Prox..'Rio:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود متعدده مضافه" ,  1, "md")
return false
end
DevRio:set(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل كلمة الرد اولا" ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local DelGpRedRedod = DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if DelGpRedRedod == 'DelGpRedRedod' then
if text == "الغاء" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر" ,  1, "md")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if not DevRio:sismember(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لايوجد رد متعدد لهذه الكلمه ↫ "..text ,  1, "md")
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  قم بارسال الرد المتعدد الذي تريد حذفه من الكلمه ↫ "..text ,  1, "md")
DevRio:set(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedRedods')
DevRio:set(Prox..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
return false
end end
if text == 'حذف رد متعدد' and Manager(msg) and ChCheck(msg) or text == 'مسح رد متعدد' and Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(Prox..'Rio:Manager:GpRedod'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود متعدده مضافه" ,  1, "md")
return false
end
DevRio:set(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'DelGpRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه لحذفها" ,  1, "md")
return false
end
if text == 'اضف رد متعدد' and Manager(msg) and ChCheck(msg) then
DevRio:set(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SetGpRedod')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه الان" ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetGpRedod = DevRio:get(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
if SetGpRedod == 'SetGpRedod' then
if text == "الغاء" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر" ,  1, "md")
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
if DevRio:sismember(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,text) then
local Rio = "⌔  لاتستطيع اضافة رد بالتاكيد مضاف في القائمه قم بحذفه اولا !"
keyboard = {} 
keyboard.inline_keyboard = {{{text="حذف الرد ↫ "..text,callback_data="/DelRed:"..msg.sender_user_id_..text}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Rio).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
DevRio:del(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الامر ارسل الرد الاول\n⌔  للخروج ارسل ↫ ( الغاء )" ,  1, "md")
DevRio:set(Prox..'Rio:Add:GpRedod'..msg.sender_user_id_..msg.chat_id_,'SaveGpRedod')
DevRio:set(Prox..'Rio:Add:GpTexts'..msg.sender_user_id_..msg.chat_id_,text)
DevRio:sadd(Prox..'Rio:Manager:GpRedod'..msg.chat_id_,text)
return false
end end
--     Source Prox     --
if text == 'حذف رد' and Manager(msg) and ChCheck(msg) or text == 'مسح رد' and  Manager(msg) and ChCheck(msg) then
local List = DevRio:smembers(Prox..'Rio:Manager:GpRed'..msg.chat_id_)
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود مضافه" ,  1, "md")
return false
end
DevRio:set(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'DelGpRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه لحذفها " ,  1, "md")
return false
end
if text == 'اضف رد' and not DevRio:get(Prox..'Rio:Lock:Rd'..msg.chat_id_) and Manager(msg) and ChCheck(msg) then
DevRio:set(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SetGpRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه الان " ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetGpRed = DevRio:get(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
if SetGpRed == 'SetGpRed' then
if text == "الغاء" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر" ,  1, "md")
DevRio:del(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل لي الرد سواء كان ↫ ⤈\n〈 ملف • ملصق • متحركه • صوره\n • فيديو • بصمه • صوت • رساله 〉\n⌔  يمكنك اضافة الى النص ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n `#username` ↬ معرف المستخدم\n `#msgs` ↬ عدد الرسائل\n `#name` ↬ اسم المستخدم\n `#id` ↬ ايدي المستخدم\n `#stast` ↬ رتبة المستخدم\n `#edit` ↬ عدد السحكات\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  للخروج ارسل ↫ ( الغاء )\n ✓" ,  1, "md")
DevRio:set(Prox..'Rio:Add:GpRed'..msg.sender_user_id_..msg.chat_id_,'SaveGpRed')
DevRio:set(Prox..'Rio:Add:GpText'..msg.sender_user_id_..msg.chat_id_,text)
DevRio:sadd(Prox..'Rio:Manager:GpRed'..msg.chat_id_,text)
DevRio:set(Prox..'DelManagerRep'..msg.chat_id_,text)
return false
end end
--     Source Prox     --
if text == 'حذف رد عام' and SecondSudo(msg) and ChCheck(msg) or text == '↫ حذف رد عام ⌔' and SecondSudo(msg) and ChCheck(msg) or text == 'مسح رد عام' and SecondSudo(msg) and ChCheck(msg) or text == 'حذف رد للكل' and SecondSudo(msg) and ChCheck(msg) or text == 'مسح رد للكل' and SecondSudo(msg) and ChCheck(msg) or text == 'مسح رد مطور' and SecondSudo(msg) and ChCheck(msg) or text == 'حذف رد مطور' and SecondSudo(msg) and ChCheck(msg) then
local List = DevRio:smembers(Prox.."Rio:Sudo:AllRed")
if #List == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود مضافه" ,  1, "md")
return false
end
DevRio:set(Prox.."Rio:Add:AllRed"..msg.sender_user_id_,'DelAllRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه لحذفها " ,  1, "md")
return false
end
if text == 'اضف رد عام' and SecondSudo(msg) and ChCheck(msg) or text == '↫ اضف رد عام ⌔' and SecondSudo(msg) and ChCheck(msg) or text == 'اضف رد للكل' and SecondSudo(msg) and ChCheck(msg) or text == 'اضف رد مطور' and SecondSudo(msg) and ChCheck(msg) then
DevRio:set(Prox.."Rio:Add:AllRed"..msg.sender_user_id_,'SetAllRed')
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  حسنا ارسل الكلمه الان " ,  1, "md")
return false
end
if text and text:match("^(.*)$") then
local SetAllRed = DevRio:get(Prox.."Rio:Add:AllRed"..msg.sender_user_id_)
if SetAllRed == 'SetAllRed' then
if text == "الغاء" then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر" ,  1, "md")
DevRio:del(Prox..'Rio:Add:AllRed'..msg.sender_user_id_)
return false
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل لي الرد سواء كان ↫ ⤈\n〈 ملف • ملصق • متحركه • صوره\n • فيديو • بصمه • صوت • رساله 〉\n⌔  يمكنك اضافة الى النص ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n `#username` ↬ معرف المستخدم\n `#msgs` ↬ عدد الرسائل\n `#name` ↬ اسم المستخدم\n `#id` ↬ ايدي المستخدم\n `#stast` ↬ رتبة المستخدم\n `#edit` ↬ عدد السحكات\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  للخروج ارسل ↫ ( الغاء )\n ✓" ,  1, "md")
DevRio:set(Prox.."Rio:Add:AllRed"..msg.sender_user_id_,'SaveAllRed')
DevRio:set(Prox.."Rio:Add:AllText"..msg.sender_user_id_, text)
DevRio:sadd(Prox.."Rio:Sudo:AllRed",text)
DevRio:set(Prox.."DelSudoRep",text)
return false 
end end
--     Source Prox     --
if text == 'الردود المتعدده' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(Prox..'Rio:Manager:GpRedod'..msg.chat_id_)
MsgRep = '⌔  قائمة الردود المتعدده ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
for k,v in pairs(redod) do
MsgRep = MsgRep..k..'~ (`'..v..'`) • {*العدد ↫ '..#DevRio:smembers(Prox..'Rio:Text:GpTexts'..v..msg.chat_id_)..'*}\n' 
end
if #redod == 0 then
MsgRep = '⌔  لا توجد ردود متعدده مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text == 'حذف الردود المتعدده' and Manager(msg) and ChCheck(msg) or text == 'مسح الردود المتعدده' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(Prox..'Rio:Manager:GpRedod'..msg.chat_id_)
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود متعدده مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(Prox..'Rio:Text:GpTexts'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Manager:GpRedod'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف الردود المتعدده")  
return false
end
end
--     Source Prox     --
if text == 'الردود' and Manager(msg) and ChCheck(msg) or text == 'ردود المدير' and Manager(msg) and ChCheck(msg) then
local redod = DevRio:smembers(Prox..'Rio:Manager:GpRed'..msg.chat_id_)
MsgRep = '⌔  ردود المدير ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
for k,v in pairs(redod) do
if DevRio:get(Prox.."Rio:Gif:GpRed"..v..msg.chat_id_) then
dp = 'متحركه 🎭'
elseif DevRio:get(Prox.."Rio:Voice:GpRed"..v..msg.chat_id_) then
dp = 'بصمه 🎙'
elseif DevRio:get(Prox.."Rio:Stecker:GpRed"..v..msg.chat_id_) then
dp = 'ملصق 🃏'
elseif DevRio:get(Prox.."Rio:Text:GpRed"..v..msg.chat_id_) then
dp = 'رساله ✉'
elseif DevRio:get(Prox.."Rio:Photo:GpRed"..v..msg.chat_id_) then
dp = 'صوره 🎇'
elseif DevRio:get(Prox.."Rio:Video:GpRed"..v..msg.chat_id_) then
dp = 'فيديو 📽'
elseif DevRio:get(Prox.."Rio:File:GpRed"..v..msg.chat_id_) then
dp = 'ملف 📁'
elseif DevRio:get(Prox.."Rio:Audio:GpRed"..v..msg.chat_id_) then
dp = 'اغنيه 🎶'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) ↫ {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = '⌔  لا توجد ردود مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if Manager(msg) then
if text and (text =='حذف الردود' or text == 'مسح الردود' or text == 'حذف ردود المدير' or text == 'مسح ردود المدير') and not DevRio:get(Prox..'Rio:Lock:Rd'..msg.chat_id_) and ChCheck(msg) then
local redod = DevRio:smembers(Prox..'Rio:Manager:GpRed'..msg.chat_id_)
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(Prox..'Rio:Gif:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Voice:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Audio:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Photo:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Stecker:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Video:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:File:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Text:GpRed'..v..msg.chat_id_)
DevRio:del(Prox..'Rio:Manager:GpRed'..msg.chat_id_)
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف ردود المدير")  
return false
end
end
end
--     Source Prox     --
if  text == "ردود المطور" and SecondSudo(msg) and ChCheck(msg) or text == "الردود العام" and SecondSudo(msg) and ChCheck(msg) or text == "↫ ردود العام ⌔" and SecondSudo(msg) and ChCheck(msg) or text == "ردود العام" and SecondSudo(msg) and ChCheck(msg) then
local redod = DevRio:smembers(Prox.."Rio:Sudo:AllRed")
MsgRep = '⌔  ردود المطور ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
for k,v in pairs(redod) do
if DevRio:get(Prox.."Rio:Gif:AllRed"..v) then
dp = 'متحركه 🎭'
elseif DevRio:get(Prox.."Rio:Voice:AllRed"..v) then
dp = 'بصمه 🎙'
elseif DevRio:get(Prox.."Rio:Stecker:AllRed"..v) then
dp = 'ملصق 🃏'
elseif DevRio:get(Prox.."Rio:Text:AllRed"..v) then
dp = 'رساله ✉'
elseif DevRio:get(Prox.."Rio:Photo:AllRed"..v) then
dp = 'صوره 🎇'
elseif DevRio:get(Prox.."Rio:Video:AllRed"..v) then
dp = 'فيديو 📽'
elseif DevRio:get(Prox.."Rio:File:AllRed"..v) then
dp = 'ملف 📁'
elseif DevRio:get(Prox.."Rio:Audio:AllRed"..v) then
dp = 'اغنيه 🎶'
end
MsgRep = MsgRep..k..'~ (`'..v..'`) ↫ {*'..dp..'*}\n' 
end
if #redod == 0 then
MsgRep = '⌔  لا توجد ردود مضافه'
end
send(msg.chat_id_,msg.id_,MsgRep)
end
if text == "حذف ردود المطور" and SecondSudo(msg) and ChCheck(msg) or text == "حذف ردود العام" and SecondSudo(msg) and ChCheck(msg) or text == "مسح ردود المطور" and SecondSudo(msg) and ChCheck(msg) or text == "↫ مسح ردود العام ⌔" and SecondSudo(msg) and ChCheck(msg) then
local redod = DevRio:smembers(Prox.."Rio:Sudo:AllRed")
if #redod == 0 then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  لا توجد ردود مضافه" ,  1, "md")
else
for k,v in pairs(redod) do
DevRio:del(Prox.."Rio:Add:AllRed"..v)
DevRio:del(Prox.."Rio:Gif:AllRed"..v)
DevRio:del(Prox.."Rio:Voice:AllRed"..v)
DevRio:del(Prox.."Rio:Audio:AllRed"..v)
DevRio:del(Prox.."Rio:Photo:AllRed"..v)
DevRio:del(Prox.."Rio:Stecker:AllRed"..v)
DevRio:del(Prox.."Rio:Video:AllRed"..v)
DevRio:del(Prox.."Rio:File:AllRed"..v)
DevRio:del(Prox.."Rio:Text:AllRed"..v)
DevRio:del(Prox.."Rio:Sudo:AllRed")
end
ReplyStatus(msg,msg.sender_user_id_,"ReplyBy","⌔  تم حذف ردود المطور")  
return false
end
end 
--     Source Prox     --
if text and text == "تغيير اسم البوت" and ChCheck(msg) or text and text == "وضع اسم البوت" and ChCheck(msg) or text and text == "تغير اسم البوت" and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل لي اسم البوت الان" ,  1, "md") 
DevRio:set(Prox..'Rio:NameBot'..msg.sender_user_id_, 'msg')
return false 
end
end
if text and text == 'حذف اسم البوت' and ChCheck(msg) or text == 'مسح اسم البوت' and ChCheck(msg) then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
DevRio:del(Prox..'Rio:NameBot')
local ProxTeam = '⌔  اهلا عزيزي ↫ '..RioRank(msg)..' \n⌔  تم حذف اسم البوت'
riomoned(msg.chat_id_, msg.sender_user_id_, msg.id_, ProxTeam, 14, string.len(msg.sender_user_id_))
end end 
--     Source Prox     --
if text and text:match("^استعاده الاوامر$") and SecondSudo(msg) and ChCheck(msg) or text and text:match("^استعادة كلايش الاوامر$") and SecondSudo(msg) and ChCheck(msg) then
HelpList ={'Rio:Help','Rio:Help1','Rio:Help2','Rio:Help3','Rio:Help4','Rio:Help5','Rio:Help6'}
for i,Help in pairs(HelpList) do
DevRio:del(Prox..Help) 
end
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم استعادة الكلايش الاصليه" ,  1, "md") 
end
if text == "تعيين الاوامر" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر الاوامر" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (الاوامر) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help0'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help0'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help0'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده " ,  1, "md")
return false end
end
if text == "الاوامر" and ChCheck(msg) or text == "اوامر" and ChCheck(msg) or text == "مساعده" and ChCheck(msg) then
local Help = DevRio:get(Prox..'Rio:Help')
local Text = [[
⌔  اهلا بك في قائمة الاوامر ↫ ⤈ 
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  م1 ↫ اوامر الحمايه
⌔  م2 ↫ اوامر الادمنيه
⌔  م3 ↫ اوامر المدراء
⌔  م4 ↫ اوامر المنشئين
⌔  م5 ↫ اوامر المطورين
⌔  م6 ↫ اوامر الاعضاء
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]] 
keyboard = {} 
keyboard.inline_keyboard = {{{text="اوامر الادمنيه",callback_data="/HelpList2:"..msg.sender_user_id_},{text="اوامر الحمايه",callback_data="/HelpList1:"..msg.sender_user_id_}},{{text="اوامر المنشئين",callback_data="/HelpList4:"..msg.sender_user_id_},{text="اوامر المدراء",callback_data="/HelpList3:"..msg.sender_user_id_}},{{text="اوامر الاعضاء",callback_data="/HelpList6:"..msg.sender_user_id_},{text="اوامر المطورين",callback_data="/HelpList5:"..msg.sender_user_id_}},{{text="• اخفاء الكليشه •",callback_data="/HideHelpList:"..msg.sender_user_id_}}}
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Help or Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "تعيين امر م1" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر م١" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م1) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help01'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help01'..msg.sender_user_id_)
if ProxTeam == 'msg' then 
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help01'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help1', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده " ,  1, "md")
return false end
end
if text == "م1" or text == "م١" or text == "اوامر1" or text == "اوامر١" then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر يخص الرتب الاعلى فقط\n⌔  ارسل ↫ (م6) لعرض اوامر الاعضاء', 1, 'md')
else
local Help = DevRio:get(Prox..'Rio:Help1')
local Text = [[
⌔  اوامر حماية المجموعه ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  قفل • فتح ↫ الروابط
⌔  قفل • فتح ↫ المعرفات
⌔  قفل • فتح ↫ البوتات
⌔  قفل • فتح ↫ المتحركه
⌔  قفل • فتح ↫ الملصقات
⌔  قفل • فتح ↫ الملفات
⌔  قفل • فتح ↫ الصور
⌔  قفل • فتح ↫ الفيديو
⌔  قفل • فتح ↫ الاونلاين
⌔  قفل • فتح ↫ الدردشه
⌔  قفل • فتح ↫ التوجيه
⌔  قفل • فتح ↫ الاغاني
⌔  قفل • فتح ↫ الصوت
⌔  قفل • فتح ↫ الجهات
⌔  قفل • فتح ↫ الماركداون
⌔  قفل • فتح ↫ التكرار
⌔  قفل • فتح ↫ الهاشتاك
⌔  قفل • فتح ↫ التعديل
⌔  قفل • فتح ↫ التثبيت
⌔  قفل • فتح ↫ الاشعارات
⌔  قفل • فتح ↫ الكلايش
⌔  قفل • فتح ↫ الدخول
⌔  قفل • فتح ↫ الشبكات
⌔  قفل • فتح ↫ المواقع
⌔  قفل • فتح ↫ الفشار
⌔  قفل • فتح ↫ الكفر
⌔  قفل • فتح ↫ الطائفيه
⌔  قفل • فتح ↫ الكل
⌔  قفل • فتح ↫ العربيه
⌔  قفل • فتح ↫ الانكليزيه
⌔  قفل • فتح ↫ الفارسيه
⌔  قفل • فتح ↫ التفليش
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر حمايه اخرى ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  قفل • فتح + الامر ↫ ⤈
⌔  التكرار بالطرد
⌔  التكرار بالكتم
⌔  التكرار بالتقيد
⌔  الفارسيه بالطرد
⌔  البوتات بالطرد
⌔  البوتات بالتقيد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "تعيين امر م2" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر م٢" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م2) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help21'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help21'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help21'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help2', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده " ,  1, "md")
return false end
end
if text == "م2" and ChCheck(msg) or text == "م٢" and ChCheck(msg) or text == "اوامر2" and ChCheck(msg) or text == "اوامر٢" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر يخص الرتب الاعلى فقط\n⌔  ارسل ↫ (م6) لعرض اوامر الاعضاء', 1, 'md')
else
local Help = DevRio:get(Prox..'Rio:Help2')
local Text = [[
⌔  اوامر الادمنيه ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  الاعدادت
⌔  تاك للكل 
⌔  انشاء رابط
⌔  ضع وصف
⌔  ضع رابط
⌔  ضع صوره
⌔  حذف الرابط
⌔  حذف المطايه
⌔  كشف البوتات
⌔  طرد البوتات
⌔  تنظيف + العدد
⌔  تنظيف التعديل
⌔  كللهم + الكلمه
⌔  اسم البوت + الامر
⌔  ضع • حذف ↫ ترحيب
⌔  ضع • حذف ↫ قوانين
⌔  اضف • حذف ↫ صلاحيه
⌔  الصلاحيات • حذف الصلاحيات
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  ضع سبام + العدد
⌔  ضع تكرار + العدد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع مميز • تنزيل مميز
⌔  المميزين • حذف المميزين
⌔  كشف القيود • رفع القيود
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  حذف • مسح + بالرد
⌔  منع • الغاء منع
⌔  قائمه المنع
⌔  حذف قائمه المنع
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل • تعطيل ↫ الرابط
⌔  تفعيل • تعطيل ↫ الالعاب
⌔  تفعيل • تعطيل ↫ الترحيب
⌔  تفعيل • تعطيل ↫ التاك للكل
⌔  تفعيل • تعطيل ↫ كشف الاعدادات
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  طرد المحذوفين
⌔  طرد ↫ بالرد • بالمعرف • بالايدي
⌔  كتم • الغاء كتم
⌔  تقيد • الغاء تقيد
⌔  حظر • الغاء حظر
⌔  المكتومين • حذف المكتومين
⌔  المقيدين • حذف المقيدين
⌔  المحظورين • حذف المحظورين
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تقييد دقيقه + عدد الدقائق
⌔  تقييد ساعه + عدد الساعات
⌔  تقييد يوم + عدد الايام
⌔  الغاء تقييد ↫ لالغاء التقييد بالوقت
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "تعيين امر م3" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر م٣" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م3) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help31'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help31'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help31'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help3', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده " ,  1, "md")
return false end
end
if text == "م3" and ChCheck(msg) or text == "م٣" and ChCheck(msg) or text == "اوامر3" and ChCheck(msg) or text == "اوامر٣" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر يخص الرتب الاعلى فقط\n⌔  ارسل ↫ (م6) لعرض اوامر الاعضاء', 1, 'md')
else
local Help = DevRio:get(Prox..'Rio:Help3')
local Text = [[
⌔  اوامر المدراء ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  فحص البوت
⌔  ضع اسم + الاسم
⌔  اضف • حذف ↫ رد
⌔  ردود المدير
⌔  حذف ردود المدير
⌔  اضف • حذف ↫ رد متعدد
⌔  حذف رد من متعدد
⌔  الردود المتعدده
⌔  حذف الردود المتعدده
⌔  حذف قوائم المنع
⌔  منع ↫ بالرد على ( ملصق • صوره • متحركه )
⌔  حذف قائمه منع + ↫ ⤈
( الصور • المتحركات • الملصقات )
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تنزيل الكل
⌔  رفع ادمن • تنزيل ادمن
⌔  الادمنيه • حذف الادمنيه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تثبيت
⌔  الغاء التثبيت
⌔  اعاده التثبيت
⌔  الغاء تثبيت الكل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تغير رد + اسم الرتبه + النص ↫ ⤈
⌔  المطور • منشئ الاساسي
⌔  المنشئ • المدير • الادمن
⌔  المميز • المنظف • العضو
⌔  حذف ردود الرتب
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تغيير الايدي ↫ لتغيير الكليشه
⌔  تعيين الايدي ↫ لتعيين الكليشه
⌔  حذف الايدي ↫ لحذف الكليشه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  اطردني • الايدي بالصوره • الابراج
⌔  معاني الاسماء • اوامر النسب • انطق
⌔  الايدي • تحويل الصيغ • اوامر التحشيش
⌔  ردود المدير • ردود المطور • التحقق
⌔  ضافني • حساب العمر • الزخرفه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "تعيين امر م4" and ChCheck(msg) and SecondSudo(msg) or text == "تعيين امر م٤" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م4) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help41'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help41'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help41'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help4', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده" ,  1, "md")
return false end
end
if text == "م٤" and ChCheck(msg) or text == "م4" and ChCheck(msg) or text == "اوامر4" and ChCheck(msg) or text == "اوامر٤" and ChCheck(msg) then
if not Admin(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر يخص الرتب الاعلى فقط\n⌔  ارسل ↫ (م6) لعرض اوامر الاعضاء', 1, 'md')
else
local Help = DevRio:get(Prox..'Rio:Help4')
local Text = [[
⌔  اوامر المنشئين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تنزيل الكل
⌔  الميديا • امسح
⌔  تعين عدد الحذف
⌔  ترتيب الاوامر
⌔  اضف • حذف ↫ امر
⌔  حذف الاوامر المضافه
⌔  الاوامر المضافه
⌔  اضف نقاط ↫ بالرد • بالايدي
⌔  اضف رسائل ↫ بالرد • بالايدي
⌔  رفع منظف • تنزيل منظف
⌔  المنظفين • حذف المنظفين
⌔  رفع مدير • تنزيل مدير
⌔  المدراء • حذف المدراء
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  نزلني • امسح
⌔  الحظر • الكتم
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المنشئين الاساسيين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  وضع لقب + اللقب
⌔  تفعيل • تعطيل ↫ الرفع
⌔  رفع منشئ • تنزيل منشئ
⌔  المنشئين • حذف المنشئين
⌔  رفع • تنزيل ↫ مشرف
⌔  رفع بكل الصلاحيات
⌔  حذف القوائم
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المالكين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع • تنزيل ↫ منشئ اساسي
⌔  حذف المنشئين الاساسيين 
⌔  المنشئين الاساسيين 
⌔  حذف جميع الرتب
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "تعيين امر م5" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر م٥" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م5) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help51'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help51'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help51'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help5', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده " ,  1, "md")
return false end
end
if text == "م٥" and ChCheck(msg) or text == "م5" and ChCheck(msg) or text == "اوامر5" and ChCheck(msg) or text == "اوامر٥" and ChCheck(msg) then
if not SudoBot(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  هذا الامر للمطورين فقط', 1, 'md')
else
local Help = DevRio:get(Prox..'Rio:Help5')
local Text = [[
⌔  اوامر المطورين ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  الكروبات
⌔  المطورين
⌔  المشتركين
⌔  الاحصائيات
⌔  المجموعات
⌔  اسم البوت + غادر
⌔  اسم البوت + تعطيل
⌔  كشف + -ايدي المجموعه
⌔  رفع مالك • تنزيل مالك
⌔  المالكين • حذف المالكين
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  رفع • تنزيل ↫ مدير عام
⌔  حذف • المدراء العامين 
⌔  رفع • تنزيل ↫ ادمن عام
⌔  حذف • الادمنيه العامين 
⌔  رفع • تنزيل ↫ مميز عام
⌔  حذف • المميزين عام 
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  اوامر المطور الاساسي ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تحديث
⌔  الملفات
⌔  المتجر
⌔  السيرفر
⌔  روابط الكروبات
⌔  تحديث السورس
⌔  تنظيف الكروبات
⌔  تنظيف المشتركين
⌔  حذف جميع الملفات
⌔  تعيين الايدي العام
⌔  تغير المطور الاساسي
⌔  حذف معلومات الترحيب
⌔  تغير معلومات الترحيب
⌔  غادر + -ايدي المجموعه
⌔  تعيين عدد الاعضاء + العدد
⌔  حظر عام • الغاء العام
⌔  كتم عام • الغاء العام
⌔  قائمه العام • حذف قائمه العام
⌔  وضع • حذف ↫ اسم البوت
⌔  اضف • حذف ↫ رد عام
⌔  ردود المطور • حذف ردود المطور
⌔  تعيين • حذف • جلب ↫ رد الخاص
⌔  جلب نسخه الكروبات
⌔  رفع النسخه + بالرد على الملف
⌔  تعيين • حذف ↫ قناة الاشتراك
⌔  جلب كليشه الاشتراك
⌔  تغيير • حذف ↫ كليشه الاشتراك
⌔  رفع • تنزيل ↫ مطور
⌔  المطورين • حذف المطورين
⌔  رفع • تنزيل ↫ مطور ثانوي
⌔  الثانويين • حذف الثانويين
⌔  تعيين • حذف ↫ كليشة الايدي
⌔  اذاعه للكل بالتوجيه ↫ بالرد
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  تفعيل ملف + اسم الملف
⌔  تعطيل ملف + اسم الملف
⌔  تفعيل • تعطيل + الامر ↫ ⤈
⌔  الاذاعه • الاشتراك الاجباري
⌔  ترحيب البوت • المغادره
⌔  البوت الخدمي • التواصل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end end
if text == "تعيين امر م6" and SecondSudo(msg) and ChCheck(msg) or text == "تعيين امر م٦" and SecondSudo(msg) and ChCheck(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة (م6) الان " ,  1, "md")
DevRio:set(Prox..'Rio:Help61'..msg.sender_user_id_, 'msg')
return false end
if text and text:match("^(.*)$") then
local ProxTeam =  DevRio:get(Prox..'Rio:Help61'..msg.sender_user_id_)
if ProxTeam == 'msg' then
Dev_Rio(msg.chat_id_, msg.id_, 1, text , 1, 'md')
DevRio:del(Prox..'Rio:Help61'..msg.sender_user_id_)
DevRio:set(Prox..'Rio:Help6', text)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ الكليشه الجديده" ,  1, "md")
return false end
end
if text == "م٦" and ChCheck(msg) or text == "م6" and ChCheck(msg) or text == "اوامر6" and ChCheck(msg) or text == "اوامر٦" and ChCheck(msg) then
local Help = DevRio:get(Prox..'Rio:Help6')
local Text = [[
⌔  اوامر الاعضاء ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  السورس • موقعي • رتبتي • معلوماتي 
⌔  رقمي • لقبي • نبذتي • صلاحياتي • غنيلي
⌔  رسائلي • حذف رسائلي • اسمي • معرفي 
⌔  ايدي •ايديي • جهاتي • راسلني • الالعاب 
⌔  نقاطي • بيع نقاطي • القوانين • زخرفه 
⌔  رابط الحذف • نزلني • اطردني • المطور 
⌔  منو ضافني • مشاهدات المنشور • الرابط 
⌔  ايدي المجموعه • معلومات المجموعه 
⌔  نسبه الحب • نسبه الكره • نسبه الغباء 
⌔  نسبه الرجوله • نسبه الانوثه • التفاعل
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  لقبه + بالرد
⌔  كول + الكلمه
⌔  زخرفه + اسمك
⌔  برج + نوع البرج
⌔  معنى اسم + الاسم
⌔  بوسه • بوسها ↫ بالرد
⌔  احسب + تاريخ ميلادك
⌔  رفع مطي • تنزيل مطي • المطايه
⌔  هينه • هينها ↫ بالرد • بالمعرف
⌔  صيحه • صيحها ↫ بالرد • بالمعرف
⌔  تفاعلي • تفاعله ↫ بالرد
⌔  صلاحياته ↫ بالرد • بالمعرف • بالايدي
⌔  ايدي • كشف  ↫ بالرد • بالمعرف • بالايدي
⌔  تحويل + بالرد ↫ صوره • ملصق • صوت • بصمه
⌔  انطق + الكلام تدعم جميع اللغات مع الترجمه للعربي
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
⌔  [Source Channel](https://t.me/F_L_3)
]]
Dev_Rio(msg.chat_id_, msg.id_, 1, (Help or Text), 1, 'md')
end
if Text == '/game2' then
local Teext =[[
 
◍قائمة العاب المجموعه ↫ ⤈
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
◍لعبة التخمين ↫ خمن
◍لعبة الامثله ↫ امثله
◍لعبة العكس ↫ العكس
◍لعبة الاسئله ↫ اسئله
◍لعبة الروليت ↫ روليت
◍لعبة الحزوره ↫ حزوره
◍لعبة الترتيب ↫ ترتيب
◍لعبة المعاني ↫ معاني
◍لعبة التويت ↫ كت تويت
◍لعبة المختلف ↫ المختلف
◍لعبة السمايلات ↫ سمايلات
◍لعبة المحيبس ↫ المحيبس
◍لعبة الرياضيات ↫ رياضيات
◍لعبة الانكليزيه ↫ انكليزيه
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
◍ ↫ كت تويت بالصور
◍ ↫ لو خيروك بالصور
◍ ↫ لعبه عقاب
◍ ↫ لعبه مريم
◍ ↫ لعبه كتبات
◍ ↫ لعبه بوستات
◍ ↫ لعبه نكت
◍ ↫ صراحه
◍ ↫ كت تويت
◍ ↫ لو خيروك
◍ ↫ حروف
◍ ↫ انصحني
──┈┈┈┄┄╌╌╌╌┄┄┈┈┈
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◗القائمه الرائسيه◖', callback_data="/add"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/game1' then
local Teext =[[
🎮 اهلا في قائمه الالعاب المتطوره سورس كوين..↑↓   
🎮 تفضل اختر لعبه من القائمه.↑↓ 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
❲[Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠](t.me/Source_Queen)❳ 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'فلابي بيرد', url="https://t.me/awesomebot?game=FlappyBird"},{text = 'تحداني فالرياضيات',url="https://t.me/gamebot?game=MathBattle"}},   
{{text = 'لعبه دراجات', url="https://t.me/gamee?game=MotoFX"},{text = 'سباق سيارات', url="https://t.me/gamee?game=F1Racer"}}, 
{{text = 'تشابه', url="https://t.me/gamee?game=DiamondRows"},{text = 'كره القدم', url="https://t.me/gamee?game=FootballStar"}}, 
{{text = 'ورق', url="https://t.me/gamee?game=Hexonix"},{text = 'لعبه 2048', url="https://t.me/awesomebot?game=g2048"}}, 
{{text = 'SQUARES', url="https://t.me/gamee?game=Squares"},{text = 'ATOMIC', url="https://t.me/gamee?game=AtomicDrop1"}}, 
{{text = 'CORSAIRS', url="https://t.me/gamebot?game=Corsairs"},{text = 'LumberJack', url="https://t.me/gamebot?game=LumberJack"}}, 
{{text = 'LittlePlane', url="https://t.me/gamee?game=LittlePlane"},{text = 'RollerDisco', url="https://t.me/gamee?game=RollerDisco"}},  
{{text = 'كره القدم 2', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'جمع المياه', url="https://t.me/gamee?game=BlockBuster"}},  
{{text = 'لا تجعلها تسقط', url="https://t.me/gamee?game=Touchdown"},{text = 'GravityNinja', url="https://t.me/gamee?game=GravityNinjaEmeraldCity"}},  
{{text = 'Astrocat', url="https://t.me/gamee?game=Astrocat"},{text = 'Skipper', url="https://t.me/gamee?game=Skipper"}},  
{{text = 'WorldCup', url="https://t.me/gamee?game=PocketWorldCup"},{text = 'GeometryRun', url="https://t.me/gamee?game=GeometryRun"}},  
{{text = 'Ten2One', url="https://t.me/gamee?game=Ten2One"},{text = 'NeonBlast2', url="https://t.me/gamee?game=NeonBlast2"}},  
{{text = 'Paintio', url="https://t.me/gamee?game=Paintio"},{text = 'onetwothree', url="https://t.me/gamee?game=onetwothree"}},  
{{text = 'BrickStacker', url="https://t.me/gamee?game=BrickStacker"},{text = 'StairMaster3D', url="https://t.me/gamee?game=StairMaster3D"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'BasketBoyRush', url="https://t.me/gamee?game=BasketBoyRush"}},  
{{text = 'GravityNinja21', url="https://t.me/gamee?game=GravityNinja21"},{text = 'MarsRover', url="https://t.me/gamee?game=MarsRover"}},  
{{text = 'LoadTheVan', url="https://t.me/gamee?game=LoadTheVan"},{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'KeepItUp', url="https://t.me/gamee?game=KeepItUp"}},  
{{text = 'SunshineSolitaire', url="https://t.me/gamee?game=SunshineSolitaire"},{text = 'Qubo', url="https://t.me/gamee?game=Qubo"}},  
{{text = 'PenaltyShooter2', url="https://t.me/gamee?game=PenaltyShooter2"},{text = 'Getaway', url="https://t.me/gamee?game=Getaway"}},  
{{text = 'PaintioTeams', url="https://t.me/gamee?game=PaintioTeams"},{text = 'SpikyFish2', url="https://t.me/gamee?game=SpikyFish2"}},  
{{text = 'GroovySki', url="https://t.me/gamee?game=GroovySki"},{text = 'KungFuInc', url="https://t.me/gamee?game=KungFuInc"}},  
{{text = 'SpaceTraveler', url="https://t.me/gamee?game=SpaceTraveler"},{text = 'RedAndBlue', url="https://t.me/gamee?game=RedAndBlue"}},  
{{text = 'SkodaHockey1 ', url="https://t.me/gamee?game=SkodaHockey1"},{text = 'SummerLove', url="https://t.me/gamee?game=SummerLove"}},  
{{text = 'SmartUpShark', url="https://t.me/gamee?game=SmartUpShark"},{text = 'SpikyFish3', url="https://t.me/gamee?game=SpikyFish3"}},  
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/add' then
local Teext =[[
🎮 اهلا بك في قسم الالعاب ..↑↓
 اختر العبه الذي تريدها .↑↓
ده من الازرار بلاسفل . ↓
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
❲[Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠](t.me/Source_Queen)❳ 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'العاب السورس💌', callback_data="/game2"},{text = 'مميزات🎪', callback_data="/game3"},
},
{
{text = 'العاب متطوره🎮', callback_data="/game1"},
},
{
{text = 'Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠', url="t.me/Source_Queen"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/game3' then
local Teext =[[
بك في مميزات سورس كوين.↑↓
مميزات الخاصه بسورس.↑↓ 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
❲[Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠](t.me/Source_Queen)❳ 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'تويت', url="https://t.me/Exp_Queen/530"}},   
{{text = 'انصحني', url="https://t.me/Exp_Queen/538"},{text = 'لو خيروك', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'الصراحه', url="https://t.me/Exp_Queen/531"},{text = 'حروف', url="https://t.me/Exp_Queen/538"}}, 
{{text = 'بوستات', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'نكت', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'غنيلي', url="https://t.me/Exp_Queen/496"}},
{{text = 'عقاب', url="https://t.me/Exp_Queen/531"}},
{{text = 'مريم', url="https://t.me/Exp_Queen/532"}},
{{text = 'لو خيروك بالصور', url="https://t.me/Exp_Queen/531"}},
{{text = 'تويت بالصور', url="https://t.me/Exp_Queen/530"}},
{{text = 'نسبه جمالي', url="https://t.me/Exp_Queen"}},
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if text == "المميزات" or text == "مميزت" then
local Teext =[[
بك في مميزات سورس كوين.↑↓
مميزات الخاصه بسورس.↑↓ 
╾╾╾╾╾╾╾╾╾╾╾╾╾╾╾╸
❲[Sꪮꪊ𝘳ᥴꫀ Qꪊꫀꫀꪀ 𓃠](t.me/Source_Queen)❳ 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'تويت', url="https://t.me/Exp_Queen/530"}},   
{{text = 'انصحني', url="https://t.me/Exp_Queen/538"},{text = 'لو خيروك', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'الصراحه', url="https://t.me/Exp_Queen/531"},{text = 'حروف', url="https://t.me/Exp_Queen/538"}}, 
{{text = 'بوستات', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'نكت', url="https://t.me/Exp_Queen/531"}}, 
{{text = 'غنيلي', url="https://t.me/Exp_Queen/496"}},
{{text = 'عقاب', url="https://t.me/Exp_Queen/531"}},
{{text = 'مريم', url="https://t.me/Exp_Queen/532"}},
{{text = 'لو خيروك بالصور', url="https://t.me/Exp_Queen/531"}},
{{text = 'تويت بالصور', url="https://t.me/Exp_Queen/530"}},
{{text = 'نسبه جمالي', url="https://t.me/Exp_Queen"}},
{{text = '◗القائمه الرائسيه◖', callback_data="/add"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
--     Source Prox     --
if SecondSudo(msg) then
if text == "تحديث السورس" and ChCheck(msg) or text == "تحديث سورس" and ChCheck(msg) or text == "↫ تحديث السورس ⌔" and ChCheck(msg) then 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  جاري تحديث سورس كيلوا', 1, 'md') 
os.execute('rm -rf Prox.lua') 
os.execute('wget https://raw.githubusercontent.com/Hiaveen/keloa/master/Prox.lua') 
dofile('Prox.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n          ( تم تحديث السورس )          \n\27[0;34;49m\n") 
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم التحديث الى الاصدار الجديد', 1, 'md') 
end
if text == 'تحديث' and ChCheck(msg) or text == 'تحديث البوت' and ChCheck(msg) or text == '↫ تحديث ⌔' and ChCheck(msg) then  
dofile('Prox.lua') 
io.popen("rm -rf ../.telegram-cli/*")
print("\27[31;47m\n        ( تم تحديث ملفات البوت )        \n\27[0;34;49m\n") 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم تحديث ملفات البوت", 1, "md")
end
--     Source Prox     --
if text == 'نقل الاحصائيات' and ChCheck(msg) or text == '↫ نقل الاحصائيات ⌔' and ChCheck(msg) then
local Users = DevRio:smembers(Prox.."User_Bot")
local Groups = DevRio:smembers(Prox..'Chek:Groups')
local Sudos = DevRio:smembers(Prox.."Sudo:User")
if DevRio:get(Prox..'Name:Bot') then
DevRio:set(Prox..'Rio:NameBot',(DevRio:get(Prox..'Name:Bot') or 'كيلوا'))
end
for i = 1, #Users do
local id = Users[i]
if id:match("^(%d+)") then
DevRio:sadd(Prox..'Rio:Users',Users[i]) 
end
end
for i = 1, #Sudos do
DevRio:sadd(Prox..'Rio:SudoBot:',Sudos[i]) 
end
for i = 1, #Groups do
DevRio:sadd(Prox..'Rio:Groups',Groups[i]) 
if DevRio:get(Prox.."Private:Group:Link"..Groups[i]) then
DevRio:set(Prox.."Rio:Groups:Links"..Groups[i],DevRio:get(Prox.."Private:Group:Link"..Groups[i]))
end
if DevRio:get(Prox.."Get:Welcome:Group"..Groups[i]) then
DevRio:set(Prox..'Rio:Groups:Welcomes'..Groups[i],DevRio:get(Prox.."Get:Welcome:Group"..Groups[i]))
end
local list2 = DevRio:smembers(Prox..'Constructor'..Groups[i])
for k,v in pairs(list2) do
DevRio:sadd(Prox.."Rio:Constructor:"..Groups[i], v)
end
local list3 = DevRio:smembers(Prox..'BasicConstructor'..Groups[i])
for k,v in pairs(list3) do
DevRio:sadd(Prox.."Rio:BasicConstructor:"..Groups[i], v)
end
local list4 = DevRio:smembers(Prox..'Manager'..Groups[i])
for k,v in pairs(list4) do
DevRio:sadd(Prox.."Rio:Managers:"..Groups[i], v)
end
local list5 = DevRio:smembers(Prox..'Mod:User'..Groups[i])
for k,v in pairs(list5) do
DevRio:sadd(Prox.."Rio:Admins:"..Groups[i], v)
end
local list6 = DevRio:smembers(Prox..'Special:User'..Groups[i])
for k,v in pairs(list6) do
DevRio:sadd(Prox.."Rio:VipMem:"..Groups[i], v)
end
DevRio:set(Prox.."Rio:Lock:Bots"..Groups[i],"del") DevRio:hset(Prox.."Rio:Spam:Group:User"..Groups[i] ,"Spam:User","keed") 
LockList ={'Rio:Lock:Links','Rio:Lock:Forwards','Rio:Lock:Videos','Rio:Lock:Gifs','Rio:Lock:EditMsgs','Rio:Lock:Stickers','Rio:Lock:Farsi','Rio:Lock:Spam','Rio:Lock:WebLinks'}
for i,Lock in pairs(LockList) do
DevRio:set(Prox..Lock..Groups[i],true)
end
end
send(msg.chat_id_, msg.id_,'⌔  تم نقل ↫ '..#Groups..' مجموعه\n⌔  تم نقل ↫ '..#Users..' مشترك\n⌔  من التحديث القديم الى التحديث الجديد')
end
--     Source Prox     --
if text == 'الملفات' and ChCheck(msg) then
Files = '\n⌔  الملفات المفعله في البوت ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
i = 0
for v in io.popen('ls Files'):lines() do
if v:match(".lua$") then
i = i + 1
Files = Files..i..'~ : `'..v..'`\n'
end
end
if i == 0 then
Files = '⌔  لا توجد ملفات في البوت'
end
send(msg.chat_id_, msg.id_,Files)
end
if text == "متجر الملفات" and ChCheck(msg) or text == 'المتجر' and ChCheck(msg) or text == '↫  المتجر ⌔' and ChCheck(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/Hiaveen/keloaFiles/master/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n⌔  قائمة ملفات متجر سورس كيلوا\n⌔  الملفات المتوفره حاليا ↫ ⤈\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n"
local TextE = "──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  علامة ↫ (✔) تعني الملف مفعل\n⌔  علامة ↫ (✖️) تعني الملف معطل\n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local CheckFileisFound = io.open("Files/"..name,"r")
if CheckFileisFound then
io.close(CheckFileisFound)
CheckFile = "(✔)"
else
CheckFile = "(✖️)"
end
NumFile = NumFile + 1
TextS = TextS.."⌔  "..Info..' ↫ ⤈\n'..NumFile.."~ : `"..name..'` ↬ '..CheckFile.."\n"
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_,"⌔  لا يوجد اتصال من الـapi") 
end
end
if text == "مسح جميع الملفات" and ChCheck(msg) or text == "حذف جميع الملفات" and ChCheck(msg) then
os.execute("rm -fr Files/*")
send(msg.chat_id_,msg.id_,"⌔  تم حذف جميع الملفات المفعله")
end
if text and text:match("^(تعطيل ملف) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(تعطيل ملف) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/Hiaveen/keloaFiles/master/ProxFiles/"..FileName)
if Res == 200 then
os.execute("rm -fr Files/"..FileName)
send(msg.chat_id_, msg.id_,"\n⌔  الملف ↫ *"..FileName.."*\n⌔  تم تعطيله وحذفه من البوت بنجاح") 
dofile('Prox.lua')  
else
send(msg.chat_id_, msg.id_,"⌔  لا يوجد ملف بهذا الاسم") 
end
end
if text and text:match("^(تفعيل ملف) (.*)(.lua)$") and ChCheck(msg) then
local FileGet = {string.match(text, "^(تفعيل ملف) (.*)(.lua)$")}
local FileName = FileGet[2]..'.lua'
local GetJson, Res = https.request("https://raw.githubusercontent.com/Hiaveen/keloaFiles/master/ProxFiles/"..FileName)
if Res == 200 then
local ChekAuto = io.open("Files/"..FileName,'w+')
ChekAuto:write(GetJson)
ChekAuto:close()
send(msg.chat_id_, msg.id_,"\n⌔  الملف ↫ *"..FileName.."*\n⌔  تم تفعيله في البوت بنجاح") 
dofile('Prox.lua')  
else
send(msg.chat_id_, msg.id_,"⌔  لا يوجد ملف بهذا الاسم") 
end
return false
end
end 
--     Source Prox     --
if text and (text == 'حذف معلومات الترحيب' or text == 'مسح معلومات الترحيب') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم حذف معلومات الترحيب', 1, 'md')   
DevRio:del(Prox..'Rio:Text:BotWelcome')
DevRio:del(Prox..'Rio:Photo:BotWelcome')
return false
end 
if text and (text == 'تفعيل ترحيب البوت' or text == 'تفعيل معلومات الترحيب' or text == '↫ تفعيل ترحيب البوت ⌔') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تفعيل الترحيب عند اضافة البوت في المجموعه', 1, 'md')   
DevRio:del(Prox..'Rio:Lock:BotWelcome')
return false
end 
if text and (text == 'تعطيل ترحيب البوت' or text == 'تعطيل معلومات الترحيب' or text == '↫ تعطيل ترحيب البوت ⌔') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تعطيل الترحيب عند اضافة البوت في المجموعه', 1, 'md')   
DevRio:set(Prox..'Rio:Lock:BotWelcome',true)
return false
end 
if text and (text == 'تغير معلومات الترحيب' or text == 'تغيير معلومات الترحيب' or text == '↫ تغير معلومات الترحيب ⌔') and SecondSudo(msg) and ChCheck(msg) then    
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  ارسل لي نص الترحيب', 1, 'md') 
DevRio:del(Prox..'Rio:Text:BotWelcome')
DevRio:del(Prox..'Rio:Photo:BotWelcome')
DevRio:set(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_,"Text") 
return false
end 
if text and DevRio:get(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_) == 'Text' then 
if text and text:match("^الغاء$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر", 1, "md") 
DevRio:del(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_)   
return false
end 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ النص ارسل لي صورة الترحيب\n⌔  ارسل ↫ الغاء لحفظ النص فقط", 1, 'md')   
DevRio:set(Prox.."Rio:Text:BotWelcome",text) 
DevRio:set(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_,"Photo") 
return false 
end 
if DevRio:get(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_) == 'Photo' then 
if text and text:match("^الغاء$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ النص والغاء حفظ صورة الترحيب", 1, "md") 
DevRio:del(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_)    
return false
end 
if msg.content_.photo_ and msg.content_.photo_.sizes_[1] then   
DevRio:set(Prox.."Rio:Photo:BotWelcome",msg.content_.photo_.sizes_[1].photo_.persistent_id_)
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حفظ النص وصورة الترحيب", 1, 'md')   
DevRio:del(Prox.."Rio:Set:BotWelcome"..msg.sender_user_id_)   
end
return false
end
--     Source Prox     --
if text and text:match("^ضع كليشه المطور$") or text and text:match("^وضع كليشه المطور$") or text and text:match("^تغيير كليشه المطور$") or text and text:match("^↫ تغيير كليشه المطور ⌔$") and ChCheck(msg) then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  ارسل كليشة المطور الان ", 1, "md")
DevRio:setex(Prox.."Rio:DevText"..msg.chat_id_..":" .. msg.sender_user_id_, 300, true)
end end
if text and text:match("^مسح كليشه المطور$") or text and text:match("^حذف كليشه المطور$") then
if not SecondSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم حذف كليشة المطور", 1, "md")
DevRio:del(Prox.."DevText")
end end
--     Source Prox     --
if DevRio:get(Prox.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
Dev_Rio(msg.chat_id_, msg.id_, 1, "⌔  تم الغاء الامر", 1, "md") 
DevRio:del(Prox.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
return false  end 
DevRio:del(Prox.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
DevRio:set(Prox..'Rio:ChText',texxt)
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  تم تغيير كليشة الاشتراك الاجباري', 1, 'md')
end
if text and text:match("^↫ تغير كليشه الاشتراك ⌔$") and Sudo(msg)  or text and text:match("^تغيير كليشه الاشتراك$") and Sudo(msg) then  
DevRio:setex(Prox.."textch:user"..msg.chat_id_.."" .. msg.sender_user_id_, 300, true)   
local text = '⌔  حسنا ارسل كليشة الاشتراك الجديده'  
Dev_Rio(msg.chat_id_, msg.id_, 1,text, 1, 'md') 
end
if text == "حذف كليشه الاشتراك الاجباري" or text == "↫ حذف كليشه الاشتراك ⌔" then  
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
DevRio:del(Prox..'Rio:ChText')
textt = "⌔  تم حذف كليشة الاشتراك الاجباري"
Dev_Rio(msg.chat_id_, msg.id_, 1,textt, 1, 'md') 
end end
if text == 'كليشه الاشتراك' or text == 'جلب كليشه الاشتراك' or text == '↫ كليشه الاشتراك ⌔' then
if not Sudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
local chtext = DevRio:get(Prox.."Rio:ChText")
if chtext then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  كليشة الاشتراك ↫ ⤈ \n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n['..chtext..']', 1, 'md')
else
if DevRio:get(Prox.."Rio:ChId") then
local Check = https.request('https://api.telegram.org/bot'..TokenBot..'/getChat?chat_id='..DevRio:get(Prox.."Rio:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "*⌔  عذرا لاتستطيع استخدام البوت !\n⌔  عليك الاشتراك في القناة اولا :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  لم يتم تعيين قناة الاشتراك الاجباري \n⌔  ارسل ↫ تعيين قناة الاشتراك للتعيين ', 1, 'md')
end end end end
--     Source Prox     --
if text == 'القناة' and ChCheck(msg) or text == 'قناة السورس' and ChCheck(msg) or text == 'قناه السورس' and ChCheck(msg) or text == 'قنات السورس' and ChCheck(msg) or text == '↫ قناة السورس ⌔' and ChCheck(msg) then 
Text = [[
⌔  [قناة السورس](https://t.me/F_L_3)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⌔ قناة السورس',url="t.me/F_L_3"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/F_L_3&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--     Source Prox     --
if text == "هيفين" and ChCheck(msg) or text == "مطور السورس" and ChCheck(msg) or text == "فاعل خير" and ChCheck(msg) or text == "المبرمج" and ChCheck(msg) or text == "↫ مبرمج السورس ⌔" and ChCheck(msg) then 
Text = [[
⌔  [مطور السورس](htts://t.me/H_I_v_e_e_01)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⌔ مطور السورس',url="t.me/H_I_v_e_e_n101"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/H_I_v_e_e_n101&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--     Source keloa     --
if text == "ماجد" and ChCheck(msg) or text == "هكر القلوب" and ChCheck(msg) or text == "ماقد" and ChCheck(msg) or text == "مبرمج السورس" and ChCheck(msg) or text == "↫ مبرمج السور⌔" and ChCheck(msg) then 
Text = [[
⌔  [مبرمج السورس](htts://t.me/Y_5_W)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⌔ مبرمج السورس',url="t.me/Y_5_W"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/Y_5_W&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == "↫ بوت الهمسه ⌔" and ChCheck(msg) or text == "بوت الهمسه" and ChCheck(msg) or text == " اهمس" and ChCheck(msg) or text == "هات بوت الهمسه" and ChCheck(msg) or text == "عايز همسه" and ChCheck(msg) then 
Text = [[
مرحبا بك في بوت لهمسه 
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ' ⌔ بوت الهمسه ',url="t.me/nnna6bot"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/F_2_L_4/6&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == "يوتيوب" and ChCheck(msg) or text == "قران" and ChCheck(msg) or text == "تيك توك" and ChCheck(msg) or text == "بحث" and ChCheck(msg) or text == "↫ شامل⌔" and ChCheck(msg) then 
Text = [[
⌔ مرحبا عزيزي اليك افضل البوتات الخدميه لتحميل من مواقع السوشيال
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'بوت اليوتيوب ♥️',url="t.me/Qeaa_bot"}},
{{text = 'بوت تيك توك 🇦🇪',url="t.me/K0XBOT"}},
{{text = 'بوت انستقرام 🎌',url="t.me/J33Bot"}},
{{text = 'بوت قران 🕌',url="t.me/quran_lbot"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/OO_PCV/11&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == "تواصل" and ChCheck(msg) or text == "المطورين" and ChCheck(msg) or text == "مبرمجين السورس" and ChCheck(msg) or text == "اصحاب السورس" and ChCheck(msg) or text == "↫ شامل⌔" and ChCheck(msg) then 
Text = [[
⌔ مرحبا عزيزي قم بالضغط علي الازار في الاسفل وتواصل مع مطورين سورس كيلوا
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⌯ ᴛᴀᴡᴀѕᴏʟ ᴋᴇʟᴏᴀ ⌯',url="t.me/User_Laren"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/OO_PCV/12&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == "بوت الحذف" and ChCheck(msg) or text == "رابط الحذف" and ChCheck(msg) or text == "حذف حسابي" and ChCheck(msg) or text == "هات بوت الحذف" and ChCheck(msg) or text == "هحذف" and ChCheck(msg) then 
Text = [[
رابط حذف جميع موقع التواصل 
احذف عشان انته مخنوق انا حاسس بيك 😢??
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'Telegram',url="https://my.telegram.org/auth?to=delete"},{text = 'BOT Telegram', url="t.me/LC6BOT"}},  
{{text = 'instagram', url="https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/"}},  
{{text = 'Facebook', url="https://www.facebook.com/help/deleteaccount"}},  
{{text = 'Snspchat', url="https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount"}},  
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..TokenBot..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/FlassTas8080/51&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--     Source Prox     --
if text == 'معلومات السيرفر' or text == 'السيرفر' or text == '↫ السيرفر ⌔' then 
if not RioSudo(msg) then
Dev_Rio(msg.chat_id_, msg.id_, 1, '⌔  للمطور الاساسي فقط ', 1, 'md')
else
Dev_Rio(msg.chat_id_, msg.id_, 1, io.popen([[
LinuxVersion=`lsb_release -ds`
MemoryUsage=`free -m | awk 'NR==2{printf "%s/%sMB {%.2f%%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
Percentage=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
UpTime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes"}'`
echo '⌔  نظام التشغيل ↫ ⤈\n`'"$LinuxVersion"'`' 
echo '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الذاكره العشوائيه ↫ ⤈\n`'"$MemoryUsage"'`'
echo '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  وحدة التخزين ↫ ⤈\n`'"$HardDisk"'`'
echo '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  المعالج ↫ ⤈\n`'"`grep -c processor /proc/cpuinfo`""Core ~ {$Percentage%} "'`'
echo '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  الدخول ↫ ⤈\n`'`whoami`'`'
echo '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  مدة تشغيل السيرفر ↫ ⤈\n`'"$UpTime"'`'
]]):read('*a'), 1, 'md')
end
end
--     Source Prox     --
ProxFiles(msg)
--     Source Prox     --
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
DevRio:incr(Prox..'Rio:EditMsg'..result.chat_id_..result.sender_user_id_)
local text = result.content_.text_ or result.content_.caption_
local Text = result.content_.text_
if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) and not Text and not SecondSudo(result) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
Media = 'الميديا'
if result.content_.ID == "MessagePhoto" then Media = 'الصوره'
elseif result.content_.ID == "MessageSticker" then Media = 'الملصق'
elseif result.content_.ID == "MessageVoice" then Media = 'البصمه'
elseif result.content_.ID == "MessageAudio" then Media = 'الصوت'
elseif result.content_.ID == "MessageVideo" then Media = 'الفيديو'
elseif result.content_.ID == "MessageAnimation" then Media = 'المتحركه'
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,dp) 
local rioname = '⌔  العضو ↫ ['..dp.first_name_..'](tg://user?id='..dp.id_..')'
local rioid = '⌔  ايديه ↫ `'..dp.id_..'`'
local riotext = '⌔  قام بالتعديل على '..Media
local riotxt = '──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n⌔  تعالو يامشرفين اكو مخرب'
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,rio) 
local admins = rio.members_  
text = '\n──┈┈┈┄┄╌╌╌╌┄┄┈┈┈\n'
for i=0 , #admins do 
if not rio.members_[i].bot_info_ then
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,data) 
if data.first_name_ ~= false then
text = text.."~ [@"..data.username_.."]\n"
end
if #admins == i then 
SendText(msg.chat_id_, rioname..'\n'..rioid..'\n'..riotext..text..riotxt,0,'md') 
end
end,nil)
end
end
end,nil)
end,nil)
end
if not VipMem(result) then
Filters(result, text)
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]") or text:match("#") or text:match("@") or text:match("[Hh][Tt][Tt][Pp][Ss]://") or text:match("[Hh][Tt][Tt][Pp]://") or text:match(".[Cc][Oo][Mm]") or text:match(".[Oo][Rr][Gg]") or text:match("[Ww][Ww][Ww].") or text:match(".[Xx][Yy][Zz]") then
if DevRio:get(Prox..'Rio:Lock:EditMsgs'..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_})
end end end 
end,nil)
--     Source Prox     --
elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local GetMsgPin = DevRio:get(Prox..'Rio:PinnedMsgs'..msg.chat_id_)
if GetMsgPin ~= nil then
if text == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) if dp.ID == 'Ok' then;DevRio:del(Prox..'Rio:PinnedMsgs'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if GetMsgPin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(Prox..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(Prox..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == GetMsgPin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,dp) DevRio:del(Prox..'Rio:PinnedMsgs'..msg.chat_id_) end,nil)   
end end end
--     Source Prox     --
elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then
print('\27[30;32mجاري تنظيف المجموعات الوهميه يرجى الانتظار\n\27[1;37m')
local PvList = DevRio:smembers(Prox..'Rio:Users')  
for k,v in pairs(PvList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local GpList = DevRio:smembers(Prox..'Rio:Groups') 
for k,v in pairs(GpList) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=Prox,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
DevRio:srem(Prox..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
DevRio:srem(Prox..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
DevRio:srem(Prox..'Rio:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
DevRio:srem(Prox..'Rio:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
DevRio:sadd(Prox..'Rio:Groups',v)  
end end,nil) end
end
--     Source Prox     --
end 
------------------------------------------------
-- This Source Was Developed By (Rio) @C_F_4.--
--   This Is The Source Channel @F_L_3 .   --
--                - Prox -                 --
--        -- https://t.me/F_L_3 --         --
------------------------------------------------   

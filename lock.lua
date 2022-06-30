print("*moans*")
local MainLockRepo = "https://raw.githubusercontent.com/slama0001/DHLock/main/"
local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/slama0001/DHLock/main/Aiming.lua"))()
local DaHoodSettings = {
    SilentAim = true,
    AimLock = false,
    Prediction = 0.14,
    AimLockKeybind = Enum.KeyCode.E
}

print("LOADED DEFAULT SETTINGS >_<")
-- New example script written by wally
-- You can suggest changes with a pull request or something

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    -- Set Center to true if you want the menu to appear in the center
    -- Set AutoShow to true if you want the menu to appear when it is created
    -- Position and Size are also valid options here
    -- but you do not need to define them unless you are changing them :)

    Title = 'DH Aimlock // flow#2006',
    Center = true, 
    AutoShow = true,
})

-- You do not have to set your tabs & groups up this way, just a prefrence.
local Tabs = {
    -- Creates a new tab titled Main
    AimlockTab = Window:AddTab('Main'),
    Main = Window:AddTab('Credits'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local AimlockGroup = Tabs.AimlockTab:AddLeftGroupbox('ACTIVATION')

local ActivationButton = AimlockGroup:AddButton('Activate Aimlock (REQUIRED)', function()
   local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/slama0001/DHLock/main/Aiming.lua"))()
Aiming.TeamCheck(false)

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local CurrentCamera = Workspace.CurrentCamera

getgenv().DaHoodSettings = DaHoodSettings
getgenv().AimingSets = AimingSets

function Aiming.Check()
    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then
        return false
    end

    local Character = Aiming.Character(Aiming.Selected)
    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value
    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then
        return false
    end

    return true
end

local __index
__index = hookmetamethod(game, "__index", function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then
        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then
            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)
        end
    end

    return __index(t, k)
end)

RunService:BindToRenderStep("AimLock", 0, function()
    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then
        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)
    end
    end)
   print("Debug #40889767261529041175471299086021")
end)

ActivationButton:AddTooltip('Activates Lock, required for settings to work.')

local SettingsGroup = Tabs.AimlockTab:AddLeftGroupbox('Aimlock Settings/Config')

SettingsGroup:AddDivider()

SettingsGroup:AddSlider('PREDICTSLIDER', {
    Text = 'Prediction',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

    Default = 0.1437,
    Min = 0,
    Max = 10,
    Rounding = 3,

    Compact = false, -- If set to true, then it will hide the label
})


local PREDICTAMOUNT = Options.PREDICTSLIDER.Value
Options.PREDICTSLIDER:OnChanged(function()
    DaHoodSettings.Prediction = Options.PREDICTSLIDER.Value
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.PREDICTSLIDER:SetValue(0.1437)

SettingsGroup:AddDivider()

SettingsGroup:AddSlider('FOVSLIDER', {
    Text = 'FOV',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

    Default = 10,
    Min = 0,
    Max = 200,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})

local FOVSLIDERVALUE = Options.FOVSLIDER.Value
Options.FOVSLIDER:OnChanged(function()
    Aiming.FOV = Options.FOVSLIDER.Value
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.FOVSLIDER:SetValue(10)

SettingsGroup:AddSlider('FOVSIDESSLIDER', {
    Text = 'FOV Sides',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

    Default = 25,
    Min = 0,
    Max = 100,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})

local FOVSIDESVALUE = Options.FOVSIDESSLIDER.Value
Options.FOVSIDESSLIDER:OnChanged(function()
    Aiming.FOVSides = Options.FOVSIDESSLIDER.Value
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.FOVSIDESSLIDER:SetValue(25)



SettingsGroup:AddToggle('SHOWFOVTOGGLE', {
    Text = 'Show FOV',
    Default = false, -- Default value (true / false)
    Tooltip = 'Shows the FOV Circle around your mouse/cursor', -- Information shown when you hover over the toggle
})

Toggles.SHOWFOVTOGGLE:OnChanged(function()
    -- here we get our toggle object & then get its value
    print('MyToggle changed to:', Toggles.SHOWFOVTOGGLE.Value)
    if Toggles.SHOWFOVTOGGLE.Value == true then
        Aiming.ShowFOV = true
    elseif Toggles.SHOWFOVTOGGLE.Value == false then
        Aiming.ShowFOV = false
        end
end)

-- This should print to the console: "My toggle state changed! New value: false"
Toggles.SHOWFOVTOGGLE:SetValue(false)

SettingsGroup:AddDivider()


SettingsGroup:AddSlider('HITCHANCESLIDER', {
    Text = 'Hitchance',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

    Default = 110,
    Min = 0,
    Max = 300,
    Rounding = 0,

    Compact = false, -- If set to true, then it will hide the label
})

local HITCHANCEAMOUNT = Options.HITCHANCESLIDER.Value
Options.HITCHANCESLIDER:OnChanged(function()
    Aiming.HitChance = Options.HITCHANCESLIDER.Value
end)

-- This should print to the console: "MySlider was changed! New value: 3"
Options.HITCHANCESLIDER:SetValue(110)


local CreditsGroup = Tabs.Main:AddLeftGroupbox('Script Credits')

CreditsGroup:AddLabel("Full Credits to this Lock go to diegxw on github, all I did was make it in a GUI form", true)
CreditsGroup:AddLabel("diegxw - Original Script Creator")
CreditsGroup:AddLabel("flow#2006 - Converting the script into a GUI format", true)
CreditsGroup:AddLabel("Linoria - UI Library")


-- Groupbox and Tabbox inherit the same functions
-- except Tabboxes you have to call the functions on a tab (Tabbox:AddTab(name))
-- LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox')

-- Tabboxes are a tiny bit different, but here's a basic example:
--[[
local TabBox = Tabs.Main:AddLeftTabbox() -- Add Tabbox on left side
local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')
-- You can now call AddToggle, etc on the tabs you added to the Tabbox
]]

-- Groupbox:AddToggle
-- Arguments: Index, Options
--LeftGroupBox:AddToggle('MyToggle', {
--    Text = 'This is a toggle',
 --   Default = true, -- Default value (true / false)
 --   Tooltip = 'This is a tooltip', -- Information shown when you hover over the toggle
--})


-- Fetching a toggle object for later use:
-- Toggles.MyToggle.Value

-- Toggles is a table added to getgenv() by the library
-- You index Toggles with the specified index, in this case it is 'MyToggle'
-- To get the state of the toggle you do toggle.Value

-- Calls the passed function when the toggle is updated
--Toggles.MyToggle:OnChanged(function()
    -- here we get our toggle object & then get its value
 --   print('MyToggle changed to:', Toggles.MyToggle.Value)
--end)

-- This should print to the console: "My toggle state changed! New value: false"
--Toggles.MyToggle:SetValue(false)
--
-- Groupbox:AddButton
-- Arguments: Text, Callback

--local MyButton = LeftGroupBox:AddButton('Button', function()
--   print('You clicked a button!')
--end)

-- Button:AddButton
-- Arguments: Text, Callback
-- Adds a sub button to the side of the main button

--local MyButton2 = MyButton:AddButton('Sub button', function()
--    print('You clicked a sub button!')
--end)

-- Button:AddTooltip
-- Arguments: ToolTip

--MyButton:AddTooltip('This is a button')
--MyButton2:AddTooltip('This is a sub button')

-- NOTE: You can chain the button methods!
--[[
    EXAMPLE: 
    LeftGroupBox:AddButton('Kill all', Functions.KillAll):AddTooltip('This will kill everyone in the game!')
        :AddButton('Kick all', Functions.KickAll):AddTooltip('This will kick everyone in the game!')
]]

-- Groupbox:AddLabel
-- Arguments: Text, DoesWrap
--LeftGroupBox:AddLabel('This is a label')
--LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)

-- Groupbox:AddDivider
-- Arguments: None
--LeftGroupBox:AddDivider()

-- Groupbox:AddSlider
-- Arguments: Idx, Options
--LeftGroupBox:AddSlider('MySlider', {
 --   Text = 'This is my slider!',

    -- Text, Default, Min, Max, Rounding must be specified.
    -- Rounding is the number of decimal places for precision.

    -- Example:
    -- Rounding 0 - 5
    -- Rounding 1 - 5.1
    -- Rounding 2 - 5.15
    -- Rounding 3 - 5.155

--    Default = 0,
  --  Min = 0,
 --   Max = 5,
--    Rounding = 1,

  --  Compact = false, -- If set to true, then it will hide the label
--})

-- Options is a table added to getgenv() by the library
-- You index Options with the specified index, in this case it is 'MySlider'
-- To get the value of the slider you do slider.Value

--local Number = Options.MySlider.Value
--Options.MySlider:OnChanged(function()
  --  print('MySlider was changed! New value:', Options.MySlider.Value)
--end)

-- This should print to the console: "MySlider was changed! New value: 3"
--Options.MySlider:SetValue(3)

-- Groupbox:AddInput
-- Arguments: Idx, Info
--LeftGroupBox:AddInput('MyTextbox', {
 --   Default = 'My textbox!',
 --   Numeric = false, -- true / false, only allows numbers
 --   Finished = false, -- true / false, only calls callback when you press enter

 --   Text = 'This is a textbox',
--    Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox

 --   Placeholder = 'Placeholder text', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text
--})

--Options.MyTextbox:OnChanged(function()
--    print('Text updated. New text:', Options.MyTextbox.Value)
--end)

-- Groupbox:AddDropdown
-- Arguments: Idx, Info

--AddDropdown('MyDropdown', {
 --   Values = { 'This', 'is', 'a', 'dropdown' },
--    Default = 1, -- number index of the value / string
 --   Multi = false, -- true / false, allows multiple choices to be selected

 --   Text = 'A dropdown',
 --   Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox
--})

--Options.MyDropdown:OnChanged(function()
 --   print('Dropdown got changed. New value:', Options.MyDropdown.Value)
--end)

--Options.MyDropdown:SetValue('This')

-- Multi dropdowns
--LeftGroupBox:AddDropdown('MyMultiDropdown', {
    -- Default is the numeric index (e.g. "This" would be 1 since it if first in the values list)
    -- Default also accepts a string as well

    -- Currently you can not set multiple values with a dropdown

 --   Values = { 'This', 'is', 'a', 'dropdown' },
--    Default = 1, 
  --  Multi = true, -- true / false, allows multiple choices to be selected

 --   Text = 'A dropdown',
 --   Tooltip = 'This is a tooltip', -- Information shown when you hover over the textbox
--})

--Options.MyMultiDropdown:OnChanged(function()
    -- print('Dropdown got changed. New value:', )
--    print('Multi dropdown got changed:')
  --  for key, value in next, Options.MyMultiDropdown.Value do
  --      print(key, value) -- should print something like This, true
 --   end
--end)

--Options.MyMultiDropdown:SetValue({
 --   This = true,
--    is = true,
--})

-- Label:AddColorPicker
-- Arguments: Idx, Info

-- You can also ColorPicker & KeyPicker to a Toggle as well

--LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
  --  Default = Color3.new(0, 1, 0), -- Bright green
--    Title = 'Some color', -- Optional. Allows you to have a custom color picker title (when you open it)
--})

--Options.ColorPicker:OnChanged(function()
--    print('Color changed!', Options.ColorPicker.Value)
--end)

--Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))

--LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    -- SyncToggleState only works with toggles. 
    -- It allows you to make a keybind which has its state synced with its parent toggle

    -- Example: Keybind which you use to toggle flyhack, etc.
    -- Changing the toggle disables the keybind state and toggling the keybind switches the toggle state

--    Default = 'MB2', -- String as the name of the keybind (MB1, MB2 for mouse buttons)  
 --   SyncToggleState = false, 


 --   -- You can define custom Modes but I have never had a use for it.
--    Mode = 'Toggle', -- Modes: Always, Toggle, Hold

 --   Text = 'Auto lockpick safes', -- Text to display in the keybind menu
--    NoUI = false, -- Set to true if you want to hide from the Keybind menu,
--})

-- OnClick is only fired when you press the keybind and the mode is Toggle
-- Otherwise, you will have to use Keybind:GetState()
--Options.KeyPicker:OnClick(function()
 --   print('Keybind clicked!', Options.KeyPicker.Value)
--end)

--task.spawn(function()
  --  while true do
  --      wait(1)
--
        -- example for checking if a keybind is being pressed
--        local state = Options.KeyPicker:GetState()
 --       if state then
--            print('KeyPicker is being held down')
 --       end

  --      if Library.Unloaded then break end
--    end
--end)

--Options.KeyPicker:SetValue({ 'MB2', 'Toggle' }) -- Sets keybind to MB2, mode to Hold

-- Library functions
-- Sets the watermark visibility
Library:SetWatermarkVisibility(true)

-- Sets the watermark text
local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(balls)
Library:SetWatermark('DA HOOD AIMLOCK // ' .. math.round(1/balls) .. " FPS" .. ' // flow#2006')
end)

--Library.KeybindFrame.Visible = true; -- todo: add a function for this

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

-- I set NoUI so it does not show up in the keybinds menu
MenuGroup:AddButton('Unload', function()
    Library:Unload() 
    end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Toggle Menu' }) 

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager. 
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings() 

-- Adds our MenuKeybind to the ignore list 
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

-- use case for doing it this way: 
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder('DHAIMLOCK')
SaveManager:SetFolder('DHAIMLOCK/specific-game')

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings']) 

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config 
-- which has been marked to be one that auto loads!

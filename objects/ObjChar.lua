local ObjBaseUnit = require "objects.ObjBaseUnit"
local Inventory = require "xl.Inventory"
-- local Sound = require "xl.Sound"

local ObjChar = Class.create("ObjChar", ObjBaseUnit)
--util.transient( ObjChar, "healthbar", "guardbar" , "equipIcons" , "equipIcon2" , "sprite")

-- Initializes values of ObjChar, only runs once at the start of the game
-- sets up values which initial conditions
function ObjChar:init(x,y )
	-- inventory initialization
	self.inventory = Inventory(3,3)

	self.position = {}
	self.position.x = x
	self.position.y = y
	-- init other data
	self.max_health = 500
	self.health = 500

	--initialize movement data
	self.maxJumpTime = 9
	self.currentJumpTime = 0
	self.jumpSpeed = 960
	self.maxAirJumps = 1
	self.airJumps = 0
	self.deceleration = -9
	self.maxSpeed = 6 * 32
	self.acceleration = 20 * 32
	self.currentEquips = {}
	self.currentPrimary = nil
	self.x = 0
	self.y = 0
	-- self.persistent = true
	self.attackTimer = 0
	-- self.charHeight = 22
	self.canControl = true
	self.deflectable = true

	self.inventoryLocked = self.inventoryLocked or false
	self.faction = "player"
	Game.savedata["count_deaths"] = 0
	self.immortal = true
	Game.playerIsDead = false
end

--Initializes values of ObjChar which will occur at the beginning of every room
--Recreates b2 body in every room.
function ObjChar:create()
	ObjBaseUnit.create(self)

	self:addModule(require "modules.ModControllable")

	self:addSpritePiece(require("assets.spr.scripts.PceWheel"))
	self:addSpritePiece(require("assets.spr.scripts.PceBody"))


	self:setDepth(self.depth or 5000)
	
	--if set to true, the game will maintain a hitbox that displays "!" when
	-- near an interactable object (NOT IMPLEMENTED)
	-- self.detectBox = true

	Game:setPlayer(self)

	--initialize player hitboxes
	self:createBody( "dynamic" ,true, true)
	self.shape = love.physics.newRectangleShape(7, 16)
	self.shapeCrouch = love.physics.newRectangleShape(8,20)
	self.fixture = love.physics.newFixture(self.body, self.shape, 1)
	self:setFixture(self.shape, 22.6) -- you may notice that the player has a body, but I never define the shape of the body.
	-- That is because there are things called "Fixtures" which are essentially just shapes. One body can be comprised of multiple fixtures.
	-- this is all part of love2d. I wrote the function setFixture which takes a shape and a weight and sets it as the 
	-- fixture of the player character. This simplifies things a bit. The reason why is that you can simply swap shapes whenever you need to
	-- without worrying about the complexities of deleting fixtures (deleting fixtures suck.)
	self.fixture:setCategory(CL_CHAR)
	--self.fixtureDRAW = xl.SHOW_HITBOX(self.fixture)

	--initialize Inventory
	self:addModule(require "modules.ModInventory")
	self:setEquipCreateItem("ObjGun")
	-- self:addModule(require "modules.ModBomb")
	-- self:addModule( require "modules.ModEmitter")
	-- self:addModule(require "modules.ModDuplicator")
	-- self:setEquipCreateItem("EqpTest")
end

return ObjChar

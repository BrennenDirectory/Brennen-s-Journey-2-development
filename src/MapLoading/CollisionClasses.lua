local function addClass(name, params)
    world:addCollisionClass(name, params)
end

addClass("Breakable")
addClass("Crate")
addClass("Wall")
addClass("Ground")
addClass("Passage")
addClass("Chest")
addClass("Pickup", {ignores = {"All", except = {"Ground"}}})
addClass("HealthBottle", {ignores = {"All", except = {"Ground"}}})
addClass("InteriorZone", {ignores = {"All"}})
addClass("Player", {enter = {"Pickup", "HealthBottle"}}) -- "ExteriorZone"
addClass("Enemy", {ignores = {"Enemy", "Player"}, enter = {"Wall", "Ground", "Crate", "Player"}}) -- "ExteriorZone"
addClass("ExteriorZone", {ignores = {"All"}, enter = {"Player"}})
addClass("RespawnPoint", {ignores = {"All"}, enter = {"Player"}})
addClass("DamageSource", {ignores = {"All"}, enter = {"Player", "Crate"}})
--world:addCollisionClass("KillZone", {ignores = {"All"}, enter = {"Player", "Enemy", "Crate"}}) -- Replaced with DamageSource
addClass("Trigger", {ignores = {"All"}, enter = {"Player"}})
addClass("Platform") -- mostly here for querying purposes only -- MovingPlatform
addClass("EnemyProjectile", {ignores = {"Enemy", "EnemyProjectile", "Crate", "Player"}, enter = {"Player", "Enemy", "Wall", "Ground", "Crate"}})
addClass("BasicSpell", {ignores = {"Player", "BasicSpell", "Enemy", "EnemyProjectile"}, enter = {"Breakable", "Crate", "Enemy", "Ground", 'Wall', "Passage"}})
addClass("Bomb", {ignores = {"Bomb", "Player", "BasicSpell", "Enemy", "EnemyProjectile"}})
addClass("Ghost", {ignores = {"All"}})
-- COLLISION EVENTS WILL STILL TRIGGER IF THEY IGNORE CLASSES (Only prevents physical contact, not collision events)
-- ^ unless world:setExplicitCollisionEvents(true) is called, which it is.
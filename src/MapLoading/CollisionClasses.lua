world:addCollisionClass("Breakable")
world:addCollisionClass("Crate")
world:addCollisionClass("Wall")
world:addCollisionClass("Ground")
world:addCollisionClass("Passage")
world:addCollisionClass("Chest")
world:addCollisionClass("HealthBottle", {ignores = {"All", except = {"Ground"}}})
world:addCollisionClass("InteriorZone", {ignores = {"All"}})
world:addCollisionClass("Enemy", {ignores = {"Enemy"}, enter = {"Wall", "Ground", "Crate"}}) -- "ExteriorZone"
world:addCollisionClass("Pickup", {ignores = {"All", except = {"Ground"}}})
world:addCollisionClass("Player", {ignores = {"Enemy"}, enter = {"Enemy", "Pickup", "HealthBottle"}}) -- "ExteriorZone"
world:addCollisionClass("ExteriorZone", {ignores = {"All"}, enter = {"Player"}})
world:addCollisionClass("RespawnPoint", {ignores = {"All"}, enter = {"Player"}})
world:addCollisionClass("KillZone", {ignores = {"All"}, enter = {"Player", "Enemy", "Crate"}})
world:addCollisionClass("Trigger", {ignores = {"All"}, enter = {"Player"}})
world:addCollisionClass("Platform") -- mostly here for querying purposes only -- MovingPlatform
world:addCollisionClass("EnemyProjectile", {ignores = {"Enemy", "EnemyProjectile", "Crate", "Player"}, enter = {"Player", "Enemy", "Wall", "Ground", "Crate"}})
world:addCollisionClass("BasicSpell", {ignores = {"Player", "BasicSpell", "Enemy", "EnemyProjectile"}, enter = {"Breakable", "Crate", "Enemy", "Ground", 'Wall', "Passage"}})
world:addCollisionClass("Bomb", {ignores = {"Bomb", "Player", "BasicSpell", "Enemy", "EnemyProjectile"}})
world:addCollisionClass("Ghost", {ignores = {"All"}})
-- COLLISION EVENTS WILL STILL TRIGGER IF THEY IGNORE CLASSES (Only prevents physical contact, not collision events)
-- ^ unless world:setExplicitCollisionEvents(true) is called, which it is.
class_name NodeReference


const SPRITE_ROOT: String = "SpriteRoot"

const SPRITE_FACTORY: String = "/root/SpriteFactory"

const SIgNAL_SPRITE_CREATED: String = "sprite_created"

# dictonary structure:
# {source_node: {signal_name: [target_node_1, ...]}...}
const SIGNAL_CONNECTION: Dictionary = {
	SPRITE_FACTORY: {
		SIgNAL_SPRITE_CREATED: [
			SPRITE_ROOT
		]
	}
}

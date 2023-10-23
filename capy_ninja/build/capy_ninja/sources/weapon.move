module capy_ninja::weapon {

    use sui::object::{Self, UID};
    // use sui::object; == use sui::object::{Self};
    use sui::tx_context::TxContext;

    use std::string::String;


    struct Weapon has key, store {
        id: UID,
        weapon: String,
        name: vector<u8>, // how it shows on explorer
        damage: u32,
        rarity: String,
        type: String
    }

    public fun mint(
        weapon: String,
        name: vector<u8>,
        damage: u32,
        rarity: String,
        type: String,
        ctx: &mut TxContext
    ): Weapon {
        let nft = Weapon {
            id: object::new(ctx),
            weapon,
            name: name, // show
            damage,
            rarity,
            type
        };
        // nft
        return nft
    }
}
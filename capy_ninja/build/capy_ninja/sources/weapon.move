module capy_ninja::weapon {

    use sui::object::{Self, UID};
    // use sui::object; == use sui::object::{Self};
    use sui::tx_context::TxContext;

    use std::string::{Self, String};
    use std::vector;

    const RARITIES: vector<vector<u8>> = vector[b"Common", b"Rare", b"Epic"];


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
        rarity: u64,
        type: String,
        ctx: &mut TxContext
    ): Weapon {
        let rarity = vector::borrow<vector<u8>>(&RARITIES, rarity);
        let nft = Weapon {
            id: object::new(ctx),
            weapon,
            name: name, // show
            damage,
            rarity: string::utf8(*rarity),
            type
        };
        // nft
        return nft
    }

    public fun burn(nft: Weapon) {
        let Weapon {id, weapon: _, name: _, damage: _, rarity: _, type: _} = nft;
        object::delete(id);
    }

    // accessors

    public fun weapon(self: &Weapon): String
    {
        self.weapon
    }

    public fun name(self: &Weapon): vector<u8>
    {
        self.name
    }

    public fun damage(self: &Weapon): u32
    {
        self.damage
    }

    public fun rarity(self: &Weapon): String
    {
        self.rarity
    }

    // setters
    public fun set_damage(self: &mut Weapon, new_damage: u32) {
        self.damage = new_damage;
    }

    public fun set_name(self: &mut Weapon, new_name: vector<u8>)
    {
        self.name = new_name;
    }

    public fun set_rarity(self: &mut Weapon, new_rarity: u64)
    {
        self.rarity = string::utf8(*vector::borrow<vector<u8>>(&RARITIES, new_rarity));
    }
}
module PasswordManager::PasswordManager {
    use AptosFramework::signer;
    use AptosFramework::vector;

    /// Struct to store password information.
    struct PasswordData has store {
        password: vector<u8>,  // The encrypted password (as a byte array)
    }

    /// Function to store a password for a given user.
    public fun store_password(owner: &signer, password: vector<u8>) {
        let password_data = PasswordData {
            password,
        };
        move_to(owner, password_data);
    }

    /// Function to retrieve the stored password for a user.
    public fun get_password(owner: &signer): vector<u8> acquires PasswordData {
        let password_data = borrow_global<PasswordData>(signer::address_of(owner));
        return password_data.password;
    }
}

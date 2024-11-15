module PasswordManager::PasswordManager {
    use aptos_framework::signer;

    /// Struct to store password information.
    struct PasswordData has store, key {
        password: vector<u8>,  // The encrypted password stored as bytes
    }

    /// Function to store a password for the user.
    /// If a password already exists for the user, it will be replaced.
    public fun store_password(owner: &signer, password: vector<u8>) acquires PasswordData {
        // Check if a PasswordData already exists
        if (exists<PasswordData>(signer::address_of(owner))) {
            // Remove the existing password data
            move_from<PasswordData>(signer::address_of(owner));
        }

        // Create and store new password data
        move_to(owner, PasswordData { password });
    }

    /// Function to retrieve the stored password for a user.
    /// Returns the stored password as a vector<u8>.
    public fun get_password(owner: &signer): vector<u8> acquires PasswordData {
        // Borrow the PasswordData from global storage
        return borrow_global<PasswordData>(signer::address_of(owner)).password;
    }
}

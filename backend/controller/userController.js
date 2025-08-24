import * as UserModel from "../model/userModel.js";

export async function getUsers(req, res) {
    try {
        const users = await UserModel.getAllUsers();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function getUser(req, res) {
    try {
        const user = await UserModel.getUserById(req.params.id);
        if (!user) return res.status(404).json({ message: "User not found" });
        res.json(user);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function createUser(req, res) {
    try {
        const created = await UserModel.createUser(req.body);
        res.status(201).json(created);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function updateUser(req, res) {
    try {
        await UserModel.updateUser(req.params.id, req.body);
        res.status(204).end();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function deleteUser(req, res) {
    try {
        await UserModel.deleteUser(req.params.id);
        res.status(204).end();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

const { Router } = require("express");
const router = Router();

router.get("/login", (req, res) => {
    res.send("Login Page");
});

router.post("/login", (req, res) => {
    res.send("Login Page");
});

router.put("/login/:id", (req, res) => {
    const { id } = req.params;
    res.send("Login Page" + id);
});

router.delete("/login/:id", (req, res) => {
    const { id } = req.params;
    res.send("Login Page" + id);
});

module.exports = router;


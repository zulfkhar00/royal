const express = require("express");
const fs = require("fs");
const app = express();
const port = 4000;
const cors = require("cors");
const { v4: uuidv4 } = require("uuid");
const mongoose = require("mongoose");
const User = require("./models/user");

// connect to mongodb
const dbURI =
  "mongodb+srv://olxzulfar:sCrcNIeN7fsAGasO@cluster0.t17bdgw.mongodb.net/royal?retryWrites=true&w=majority";
mongoose
  .connect(dbURI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then((result) => console.log("connected to db"))
  .catch((err) => console.log(err));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());

app.get("/coin_data_service", cors(), async (req, res) => {
  const filePath = "static_files/coin_data_sevice_json_v1.txt";
  fs.readFile(filePath, "utf8", (err, data) => {
    if (err) {
      console.error(err);
      return res
        .status(500)
        .json({ error: "An error occurred while reading the file." });
    }

    // Assuming the file content is in a JSON format, you can parse it
    try {
      const jsonData = JSON.parse(data);
      return res.json(jsonData);
    } catch (parseError) {
      console.error(parseError);
      return res
        .status(500)
        .json({ error: "Failed to parse JSON data from the file." });
    }
  });
});

app.get("/register", cors(), async (req, res) => {
  const { name, email, password } = req.query;

  const user = new User({
    id: uuidv4(),
    name: name,
    email: email,
    password: password,
    wallet: {
      balance: 0,
    },
    portfolio: {
      stocks: [],
    },
  });

  // const user = User.findOne({ email: "Uuyvgh" });
  // user.then((result) => {
  //   res.send(result);
  //   console.log("Sent: ", result);
  // });

  user
    .save()
    .then((result) => {
      res.send(result);
      console.log("Sent: ", result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.get("/login", cors(), async (req, res) => {
  const { email, password } = req.query;

  // const user = User.findOne({ email: "Uuyvgh" });

  // user.then((result) => {
  //   res.send(result);
  //   console.log("Sent: ", result);
  // });

  const user = User.findOne({ email: email, password: password })
    .then((result) => {
      res.send(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.post("/sync_wallet_balance", cors(), async (req, res) => {
  const { user_id, balance } = req.body;
  let user = User.findOne({ id: user_id });

  user.then((foundUser) => {
    foundUser.wallet.balance = balance;
    foundUser.save().then((result) => {
      User.findOne({ id: user_id }).then((updatedUserInfo) => {
        console.log("/sync_wallet_balance");
        res.send(updatedUserInfo);
      });
    });
  });
});

app.post("/sync_coin", cors(), async (req, res) => {
  const { user_id, music_coin_id, amount } = req.body;

  let user = User.findOne({ id: user_id });
  user.then((result) => {
    let coin = result.portfolio.stocks.find(
      (coin) => coin.id === music_coin_id
    );
    if (coin) {
      coin.amount = amount;
    } else {
      result.portfolio.stocks.push({ id: music_coin_id, amount: amount });
    }
    result.save().then(() => {
      console.log("/sync_coin");
      User.findOne({ id: user_id }).then((updatedUserInfo) => {
        res.send(updatedUserInfo);
      });
    });
  });
});

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

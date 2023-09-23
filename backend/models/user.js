const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const musicStockSchema = new Schema({
  id: String,
  amount: Number,
});

const portfolioSchema = new Schema({
  stocks: [musicStockSchema],
});

const walletSchema = new Schema({
  balance: Number,
});

const userSchema = new Schema({
  id: {
    type: String,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  }, // Store securely hashed passwords
  wallet: {
    type: walletSchema,
    required: true,
  },
  portfolio: {
    type: portfolioSchema,
    required: true,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;

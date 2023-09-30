const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const musicStockSchema = new Schema({
  id: String,
  amount: Number,
});

const publishedSongSchema = new Schema({
  coin_id: String,
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
  is_artist: {
    type: Boolean,
    required: true,
  },
  published_coins: {
    type: [publishedSongSchema],
    required: false,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;

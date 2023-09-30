const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const coinSchema = new Schema({
  id: String,
  name: String,
  max_supply: Number,
  sparkline_in_7d: [Number],
  market_cap_change_24h: Number,
  low_24h: Number,
  fully_diluted_valuation: Number,
  price_change_percentage_24h: Number,
  image: String,
  atl_date: String,
  market_cap_rank: Number,
  market_cap_change_percentage_24h: Number,
  market_cap: Number,
  total_supply: Number,
  symbol: String,
  total_volume: Number,
  price_change_24h: Number,
  ath_change_percentage: Number,
  atl: Number,
  last_updated: String,
  circulating_supply: Number,
  ath_date: String,
  atl_change_percentage: Number,
  ath: Number,
  current_price: Number,
  high_24h: Number,
  price_change_percentage_24h_in_currency: Number,
});

const Coin = mongoose.model("Coin", coinSchema);
module.exports = Coin;

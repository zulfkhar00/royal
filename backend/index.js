const express = require("express");
const fs = require("fs");
const app = express();
const port = 4000;
const cors = require("cors");

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors());

app.get("/coin_data_service", cors(), async (req, res) => {
  const filePath = "static_files/coin_data_sevice_json.txt";
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

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

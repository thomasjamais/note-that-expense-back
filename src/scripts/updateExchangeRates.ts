import axios from "axios";
import dotenv from "dotenv";
import { Pool } from "pg";

dotenv.config();

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: Number(process.env.DB_PORT),
  ssl: {
    rejectUnauthorized: false,
  },
});

async function updateExchangeRates(): Promise<void> {
  try {
    const { data } = await axios.get(
      "https://api.frankfurter.app/latest?from=EUR"
    );
    const rates = data.rates;

    const { rows: currencies } = await pool.query(
      `SELECT id, code FROM currencies`
    );

    for (const target of currencies) {
      if (target.code === "EUR") continue;
      const rate = rates[target.code];
      if (!rate) continue;

      const baseCurrencyId = currencies.find((c) => c.code === "EUR")?.id;
      if (!baseCurrencyId) continue;

      await pool.query(
        `
        INSERT INTO exchange_rates (base_currency_id, target_currency_id, rate)
        VALUES ($1, $2, $3)
        ON CONFLICT (base_currency_id, target_currency_id)
        DO UPDATE SET rate = EXCLUDED.rate, updated_at = NOW();
        `,
        [baseCurrencyId, target.id, rate]
      );
    }

    console.log("Taux de change mis à jour (via Frankfurter)");
  } catch (error) {
    console.error("Erreur lors de la mise à jour des taux:", error);
  } finally {
    pool.end();
  }
}

updateExchangeRates();

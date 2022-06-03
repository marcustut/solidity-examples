import { ethers } from 'ethers';
import * as fs from 'fs-extra';
import 'dotenv/config';

function getEnv() {
  const { PRIVATE_KEY_PASSWORD, PRIVATE_KEY } = process.env;
  if (PRIVATE_KEY_PASSWORD === undefined)
    throw new Error(
      "'PRIVATE_KEY_PASSWORD' must be defined in the environment"
    );
  if (PRIVATE_KEY === undefined)
    throw new Error("'PRIVATE_KEY' must be defined in the environment");
  return { PRIVATE_KEY_PASSWORD, PRIVATE_KEY };
}

async function main() {
  const { PRIVATE_KEY, PRIVATE_KEY_PASSWORD } = getEnv();
  const wallet = new ethers.Wallet(PRIVATE_KEY);
  const encryptedJsonKey = await wallet.encrypt(
    PRIVATE_KEY_PASSWORD,
    PRIVATE_KEY
  );
  console.log(encryptedJsonKey);
  fs.writeFileSync('./.encryptedKey.json', encryptedJsonKey);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

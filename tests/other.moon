-- To test new features out

import Client, dotenv from require '../init'


unless process.env.TOKEN -- If they are already added we don't need to check for an env
  dotenv.config!

bot = Client process.env.TOKEN, {
    prefix: '='
}

bot\addCommand require('./advanced')!

bot\login!
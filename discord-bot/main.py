import discord
from discord.ext import commands
import base64


#initialize firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db, firestore


#firebase creds
cred_obj = firebase_admin.credentials.Certificate("<path to json>")
databaseURL = "<database url>"
default_app = firebase_admin.initialize_app(cred_obj, {
	'databaseURL':databaseURL
})
# firebase_admin.initialize_app(cred_obj)

firestore_db = firestore.client()

# add data
# firestore_db.collection('users').add({'username': 'aakzsh', 'disc': '#9182'})

bot = commands.Bot(command_prefix="!")

@bot.command()  
async def hey(ctx):
  await ctx.send("lol") 


@bot.command()
async def info(ctx, mention: discord.User, *args):
  r = str(mention.id)
  response = ""
  # author = ctx.author_id
  title = "A Message"
  for arg in args:
    response += arg + " "
  
  # feed this message in firebase
  data = {
     'title': title,
     'text': response
  }

  message_ref = firestore_db.collection(f'messages').document(r)
  message_doc = message_ref.get()

  if message_doc.exists:
    #if already exists
    message_ref.update({
      'messages': firestore.ArrayUnion([data])
    })
  else:
  # if doesnt exists
    message_ref.set({
      "counter" : 0,
      "remainingSteps": 100,
      "messages" : [data]
    })
  
  await ctx.send('Your secret message has been received')

bot.run('<bot token here>')

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

#decrypt
def decrypt(msg):
  levels = int(msg[0])
  p = msg[1:].split("^")
  q = p[0]
  r = p[1]
  print(levels, p, q, r)
  for i in range(levels):
    dectitle = base64.b64decode(q).decode('utf-8')
    decbody = base64.b64decode(r).decode('utf-8')
    q = dectitle
    r = decbody
  
  return dectitle, decbody


@bot.command()  
async def hey(ctx):
  await ctx.send("lol") 


@bot.command()  
async def retrieve(ctx):
  author = str(ctx.message.author.id)
  
  #retrieve firebase message
  output_ref = firestore_db.collection("messages").document(author)
  output = output_ref.get()

  retrieved_message =  output.to_dict()
  curr = retrieved_message["counter"]
  remainingSteps = int(retrieved_message["remainingSteps"])
  length = len(retrieved_message["messages"])
  
  

  if remainingSteps > 100 and curr < length:
    curr_message = retrieved_message["messages"][curr]["text"]
    print(curr_message)
    secrett, secretb = decrypt(curr_message)
    await ctx.send(f"{secrett} {secretb}")
    remainingSteps -= 100
    curr += 1
    output_ref.update({
      "remainingSteps": remainingSteps,
      "counter": curr
    })
  elif remainingSteps < 100 and curr < length:
    rem = 100 - remainingSteps
    await ctx.send(f"Sorry, you cannot view the message yet. To be able to access this message, you need to complete {rem} more steps")
  elif curr >= length:
    await ctx.send("You dont have new messages")
  #update
  

   




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

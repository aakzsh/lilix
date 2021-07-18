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


# # db
# ref = db.reference("/")
# import json
# with open("test.json", "r") as f:
# 	file_contents = json.load(f)
# ref.set(file_contents)

guild_id = {"haxk" : 839378229923676160}


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
async def botlol(ctx):
  await ctx.send("aakash bot is up and running") 

@bot.command()  
async def cute(ctx):
  await ctx.send("themks for the welcome hehehe") 

# send pics 
@bot.command()  
async def sendImage(ctx):
  # attachment = ctx.message.attachments[0]
  await ctx.send("Yay, I'm glad you're having fun")

# @bot.command()  
# async def dc(ctx, args):

#   response = args

  

#   secrett, secretb = decrypt(response)

#   print(secretb)


@bot.command()  
async def retrieve(ctx):
  author = str(ctx.message.author.id)
 
  # print(author)
  #retrieve firebase message
  output_ref = firestore_db.collection("messages").document(author)
  output = output_ref.get()
  
  retrieved_message =  output.to_dict()
  curr = int(retrieved_message["counter"])
  remainingSteps = int(retrieved_message["remainingSteps"])
  usedSteps = int(retrieved_message['usedSteps'])
  length = len(retrieved_message["messages"])
  
  
  #update remainingSteps
  total = remainingSteps + usedSteps

  #retrieve steps from app
  # 1. get uid
  uid_ref = firestore_db.collection("connect").document(author)
  uid_op = uid_ref.get()
  print(uid_op.to_dict())
  uid = uid_op.to_dict()['uid']
  
  #2. get steps
  steps_ref = firestore_db.collection("users").document(uid)
  steps_op = steps_ref.get()
  steps = steps_op.to_dict()['steps']

  diff = int(steps) - total
  remainingSteps += diff

  output_ref.update({
      "remainingSteps": remainingSteps,
      
  })

  
  
  if remainingSteps >= 100 and curr < length:
    print(curr)
    curr_message = retrieved_message["messages"][curr]["text"]
    print(curr_message)
    secrett, secretb = decrypt(curr_message)
    await ctx.send(f"**Title:**\n {secrett} \n \n**Body:**\n {secretb}")
    remainingSteps -= 100
    usedSteps += 100
    curr += 1
    output_ref.update({
      "remainingSteps": remainingSteps,
      "counter": curr,
      "usedSteps": usedSteps
    })
  elif remainingSteps >= 100 and curr < length:
    rem = 100 - remainingSteps
    await ctx.send(f"Sorry, you cannot view the message yet. To be able to access this message, you need to complete {rem} more steps")
  elif curr >= length:
    await ctx.send("You dont have new messages")
  else:
    await ctx.send(f"{remainingSteps}")
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
  # print(response, r)
  # await ctx.send(f"{r} {response}")



bot.run('<bot token>')

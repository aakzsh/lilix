import discord
from discord.ext import commands

bot = commands.Bot(command_prefix="!")

@bot.command()  
async def hey(ctx):
  await ctx.send("lol") 


bot.run('<bot token here>')

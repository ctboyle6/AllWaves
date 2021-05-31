# Download the twilio-ruby library from twilio.com/docs/libraries/ruby
require 'twilio-ruby'

ACCOUNT_SID = 'ACd4c5139075488a0d64dc1ce3094c3c3d'
AUTH_TOKEN = 'd75d72b33540ad69186f4b49bb164e93'
client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)

from = '+19728290975' # Your Twilio number
to = '+15142681755' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "Hey friend!"
)
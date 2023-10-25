# Tausche die Variable mit deiner Queue URL aus
QUEUE_URL="https://sqs.eu-central-1.amazonaws.com/113849619812/my-queue"

# Schleife zum Senden von 10 Nachrichten
for i in 1 2 3 4 5 6 7 8 9 10
do
  aws sqs send-message \
    --profile amira \
    --queue-url $QUEUE_URL \
    --message-body "Test $i"
done
